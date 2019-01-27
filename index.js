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

    let editor;
    let results;

    const resultEl = document.getElementById("result");
    const tableContainer = document.getElementById("table-container");
    const execute = (sql = editor.getValue() + ';', showIndex = false) => {
        results = db.exec(sql);

        let html = "";

        results.forEach(result => {
            const { columns, values } = result;

            html += "<div class=\"table-responsive\" style=\"margin-bottom: 2em;\">";
            html += "<table class=\"table table-hover table-bordered\">";

            html += "<tr>";
            if (showIndex) {
                html += "<td>#</td>";
            }
            columns.forEach(header => {
                html += `<td>${header}</td>`;
            });
            html += "</tr>";

            values.forEach((x, index) => {
                html += "<tr>";
                if (showIndex) {
                    html += `<td>${index}</td>`;
                }
                x.forEach(v => {
                    html += "<td>" + JSON.stringify(v) + "</td>";
                });
                html += "</tr>";
            });

            html += "</table>";
            html += "</div>";
        });

        tableContainer.innerHTML = html;

        resultEl.style.display = "";
    };

    const exportJson = () => {
        if (!results) return;
        const json = JSON.stringify(results);
        const blob = new Blob([json], { type: "application/json;charset=utf-8" });
        // @ts-ignore
        saveAs(blob, "results.json");
    };

    const executeBtn = document.getElementById("execute-btn");
    executeBtn.onclick = () => execute();
    const exportBtn = document.getElementById("export-btn");
    exportBtn.onclick = () => exportJson();

    const CodeMirrorInit = () => {
        // @ts-ignore
        editor = CodeMirror.fromTextArea(document.getElementById('code'), {
            mode: 'text/x-mysql',
            viewportMargin: Infinity,
            indentWithTabs: true,
            smartIndent: true,
            lineNumbers: true,
            matchBrackets: true,
            autofocus: true,
            extraKeys: {
                "Ctrl-Enter": execute
            }
        });
    };

    // @ts-ignore
    const SQLJS = await initSqlJs();
    const db = new SQLJS.Database();

    let resourceLoaded = 0;
    const resourceNumberEl = document.getElementById("resource-number");
    const resourceNumber = +resourceNumberEl.textContent;
    const resourceLoadedEl = document.getElementById("resource-loaded");
    const progressBarEl = document.getElementById("progress-bar");
    const resourceLoadedAdd = () => {
        resourceLoaded++;
        resourceLoadedEl.innerText = "" + resourceLoaded;
        progressBarEl.style.width = `${resourceLoaded / resourceNumber * 100}%`;

        if (resourceLoaded >= resourceNumber) {
            const loadingEl = document.getElementById("loading");
            loadingEl.style.display = "none";

            const loadedEl = document.getElementById("loaded");
            loadedEl.style.display = "";

            CodeMirrorInit();
        }
    };

    const fullSQL = await getText("https://cdn.jsdelivr.net/gh/pin-cong/data@master/pink.sql");
    resourceLoadedAdd();

    const tables = await getText("./tables.sql");
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
