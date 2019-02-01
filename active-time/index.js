// @ts-check

(async function () {

    /**
     * @param {string} url
     */
    const getText = async url => {
        const r = await fetch(url, { cache: "no-cache" });
        return await r.text();
    };

    /**
     * 转义
     * @param {string} sql
     */
    const escapeSQLite = sql => {
        return sql.replace(/\\'/g, "''");
    };

    const InitSQLJS = async () => {
        try {
            // @ts-ignore
            return await initSqlJs();
        } catch (e) {
            await new Promise(resolve => {
                const script = document.createElement("script");
                script.src = "../lib/sql-memory-growth.js";
                script.onload = () => {
                    resolve();
                };
                document.body.appendChild(script);
            });
            // @ts-ignore
            return SQL;
        }
    };

    const getTime = timestamp => {
        return new Date(timestamp * 1000)
            .toISOString()
            .match(/T(\d{2}:\d{2}:\d{2})/)[1];
    };

    const SQLJS = await InitSQLJS();
    const db = new SQLJS.Database();
    db.create_function("getTime", getTime);

    /**
     * @param {string} userName
     */
    const getData = userName => {
        const uid = db.exec(
            `SELECT uid FROM aws_users WHERE "user_name" == "${userName}"`
        )[0].values[0][0];

        const results = db.exec(`
                SELECT getTime(add_time) FROM aws_article
                WHERE uid == ${uid}
            UNION ALL
                SELECT getTime(add_time) FROM aws_article_comments
                WHERE uid == ${uid}
            UNION ALL
                SELECT getTime(add_time) FROM aws_question
                WHERE published_uid == ${uid}
            UNION ALL
                SELECT getTime(time) FROM aws_question_comments
                WHERE uid == ${uid}
            UNION ALL
                SELECT getTime(add_time) FROM aws_answer
                WHERE uid == ${uid}
            UNION ALL
                SELECT getTime(time) FROM aws_answer_comments
                WHERE uid == ${uid}
            ORDER BY getTime(add_time);
            `);

        /** @type {string[][]} */
        const data = results[0].values;

        return data.reduce((p, c) => {
            return p.concat(c);
        }, []);
    };

    let results;
    let userName = "";
    const resultEl = document.getElementById("result");
    const input = document.getElementById("username-input");
    const resultContainer = document.getElementById("result-container");
    const execute = () => {
        userName = input.value.trim();
        results = getData(userName);

        const data = results
            .map(time => {
                return new Date(`2019-01-01T${time}Z`);
            })
            .sort((a, b) => {
                return +a - +b;
            })
            .map((time, index, arr) => {
                return {
                    time: time,
                    value: index / (arr.length - 1)
                };
            });

        resultEl.style.display = "";

        // @ts-ignore
        MG.data_graphic({
            area: false,
            interpolate: d3.curveStep,
            data: data,
            full_width: true,
            height: 300,
            top: 5,
            bottom: 50,
            right: 40,
            target: resultContainer,
            utc_time: true,
            min_x: new Date("2019-01-01T00:00Z"),
            max_x: new Date("2019-01-01T24:00Z"),
            max_y: 1.1,
            x_label: "小时（UTC）",
            y_label: "F(x)",
            xax_format: d3.utcFormat("%H"),
            show_secondary_x_label: false,
            rollover_time_format: "%H:%M:%S",
            y_mouseover: () => "",
            xax_count: 25,
            yax_count: 10,
            x_accessor: "time",
            y_accessor: "value"
        });
    };

    const exportJson = () => {
        if (!results) return;
        const json = JSON.stringify(results);
        const blob = new Blob([json], { type: "application/json;charset=utf-8" });
        // @ts-ignore
        saveAs(blob, "results.json");
    };

    const exportSVG = async () => {

        /** @type {SVGSVGElement} */
        const svgElement = resultContainer.querySelector("svg").cloneNode(true);
        svgElement.setAttribute("xmlns", "http://www.w3.org/2000/svg");

        const css = await getText("../lib/metrics-graphics/metricsgraphics.css");
        const style = document.createElement("style");
        style.innerHTML = css;

        svgElement.prepend(style);
        svgElement.style.marginLeft = svgElement.style.marginTop = "10px";

        const svg = svgElement.outerHTML;
        const blob = new Blob([svg], { type: "image/svg+xml;charset=utf-8" });
        // @ts-ignore
        saveAs(blob, userName + ".svg");

    };

    const executeBtn = document.getElementById("execute-btn");
    executeBtn.onclick = () => execute();
    const exportJsonBtn = document.getElementById("export-json-btn");
    exportJsonBtn.onclick = () => exportJson();
    const exportSvgBtn = document.getElementById("export-svg-btn");
    exportSvgBtn.onclick = () => exportSVG();

    let resourceLoaded = 0;
    const resourceNumberEl = document.getElementById("resource-number");
    const resourceNumber = +resourceNumberEl.textContent;
    const resourceLoadedEl = document.getElementById("resource-loaded");
    const progressBarEl = document.getElementById("progress-bar");
    const resourceLoadedAdd = () => {
        resourceLoaded++;
        resourceLoadedEl.innerText = "" + resourceLoaded;
        progressBarEl.style.width = `${(resourceLoaded / resourceNumber) * 100}%`;

        if (resourceLoaded >= resourceNumber) {
            const loadingEl = document.getElementById("loading");
            loadingEl.style.display = "none";

            const loadedEl = document.getElementById("loaded");
            loadedEl.style.display = "";
        }
    };

    const fullSQL = await getText(
        "https://cdn.jsdelivr.net/gh/pin-cong/data@master/pink.sql"
    );
    resourceLoadedAdd();

    const tables = await getText("../tables.sql");
    const tableList = tables.split(/(?:\r?\n){2}/);
    resourceLoadedAdd();

    const exp = /\nLOCK TABLES `.+` WRITE;\n|\nUNLOCK TABLES;\n/;
    const dataList = fullSQL.split(exp).filter((data, index) => index % 2 == 1);
    dataList.forEach((data, index) => {
        const sql = tableList[index] + "\n" + data;

        const sqlLines = escapeSQLite(sql).split(/;\r?\n/);
        sqlLines.forEach(s => {
            db.run(s);
        });

        resourceLoadedAdd();
    });
})();
