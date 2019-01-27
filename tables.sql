CREATE TABLE "aws_answer" (
    "answer_id" int(11) PRIMARY KEY NOT NULL,
    "question_id" int(11) NOT NULL,
    "answer_content" text,
    "add_time" int(10) DEFAULT '0',
    "against_count" int(11) NOT NULL DEFAULT '0',
    "agree_count" int(11) NOT NULL DEFAULT '0',
    "uid" int(11) DEFAULT '0',
    "comment_count" int(11) DEFAULT '0',
    "uninterested_count" int(11) DEFAULT '0',
    "thanks_count" int(11) DEFAULT '0',
    "category_id" int(11) DEFAULT '0',
    "has_attach" tinyint(1) DEFAULT '0',
    "force_fold" tinyint(1) DEFAULT '0',
    "anonymous" tinyint(1) DEFAULT '0'
);

CREATE TABLE "aws_answer_comments" (
    "id" int(11) PRIMARY KEY NOT NULL,
    "answer_id" int(11) DEFAULT '0',
    "uid" int(11) DEFAULT '0',
    "message" text,
    "time" int(10) DEFAULT '0',
    "anonymous" tinyint(1) DEFAULT '0'
);

CREATE TABLE "aws_article" (
    "id" int(10) PRIMARY KEY NOT NULL,
    "uid" int(10) NOT NULL,
    "title" varchar(240) NOT NULL,
    "message" text,
    "comments" int(10) DEFAULT '0',
    "views" int(10) DEFAULT '0',
    "add_time" int(10) DEFAULT NULL,
    "has_attach" tinyint(1) NOT NULL DEFAULT '0',
    "lock" int(1) NOT NULL DEFAULT '0',
    "votes" int(10) DEFAULT '0',
    "title_fulltext" text,
    "category_id" int(10) DEFAULT '0',
    "is_recommend" tinyint(1) DEFAULT '0',
    "chapter_id" int(10) DEFAULT NULL,
    "sort" tinyint(2) NOT NULL DEFAULT '0',
    "update_time" int(10) DEFAULT NULL,
    "anonymous" tinyint(1) DEFAULT '0',
    "thanks_count" int(10) DEFAULT '0'
);

CREATE TABLE "aws_article_comments" (
  "id" int(10) PRIMARY KEY NOT NULL,
  "uid" int(10) NOT NULL,
  "article_id" int(10) NOT NULL,
  "message" text NOT NULL,
  "add_time" int(10) NOT NULL,
  "at_uid" int(10) DEFAULT NULL,
  "votes" int(10) DEFAULT '0',
  "anonymous" tinyint(1) DEFAULT '0'
);

CREATE TABLE "aws_category" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "title" varchar(128) DEFAULT NULL,
  "type" varchar(16) DEFAULT NULL,
  "icon" varchar(240) DEFAULT NULL,
  "parent_id" int(11) DEFAULT '0',
  "sort" smallint(6) DEFAULT '0',
  "url_token" varchar(32) DEFAULT NULL
);

CREATE TABLE "aws_feature" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "title" varchar(200) DEFAULT NULL,
  "description" varchar(240) DEFAULT NULL,
  "icon" varchar(240) DEFAULT NULL,
  "topic_count" int(11) NOT NULL DEFAULT '0',
  "css" text,
  "url_token" varchar(32) DEFAULT NULL,
  "seo_title" varchar(240) DEFAULT NULL,
  "enabled" tinyint(1) NOT NULL DEFAULT '0',
  "sort" smallint(6) DEFAULT '0'
);

CREATE TABLE "aws_feature_topic" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "feature_id" int(11) NOT NULL DEFAULT '0',
  "topic_id" int(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "aws_help_chapter" (
  "id" int(10) PRIMARY KEY NOT NULL,
  "title" varchar(240) NOT NULL,
  "description" text,
  "url_token" varchar(32) DEFAULT NULL,
  "sort" tinyint(2) NOT NULL DEFAULT '0'
);

CREATE TABLE "aws_nav_menu" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "title" varchar(128) DEFAULT NULL,
  "description" varchar(240) DEFAULT NULL,
  "type" varchar(16) DEFAULT NULL,
  "type_id" int(11) DEFAULT '0',
  "link" varchar(240) DEFAULT NULL,
  "icon" varchar(240) DEFAULT NULL,
  "sort" smallint(6) DEFAULT '0'
);

CREATE TABLE "aws_pages" (
  "id" int(10) PRIMARY KEY NOT NULL,
  "url_token" varchar(32) NOT NULL,
  "title" varchar(240) DEFAULT NULL,
  "keywords" varchar(240) DEFAULT NULL,
  "description" varchar(240) DEFAULT NULL,
  "contents" text,
  "enabled" tinyint(1) NOT NULL DEFAULT '0'
);

CREATE TABLE "aws_posts_index" (
  "id" int(10) PRIMARY KEY NOT NULL,
  "post_id" int(10) NOT NULL,
  "post_type" varchar(16) NOT NULL DEFAULT '',
  "add_time" int(10) NOT NULL,
  "update_time" int(10) DEFAULT '0',
  "category_id" int(10) DEFAULT '0',
  "is_recommend" tinyint(1) DEFAULT '0',
  "view_count" int(10) DEFAULT '0',
  "anonymous" tinyint(1) DEFAULT '0',
  "popular_value" int(10) DEFAULT '0',
  "uid" int(10) NOT NULL,
  "lock" tinyint(1) DEFAULT '0',
  "agree_count" int(10) DEFAULT '0',
  "answer_count" int(10) DEFAULT '0'
);

CREATE TABLE "aws_question" (
  "question_id" int(11) PRIMARY KEY NOT NULL,
  "question_content" varchar(240) NOT NULL DEFAULT '',
  "question_detail" text,
  "add_time" int(11) NOT NULL,
  "update_time" int(11) DEFAULT NULL,
  "published_uid" int(11) DEFAULT NULL,
  "answer_count" int(11) NOT NULL DEFAULT '0',
  "answer_users" int(11) NOT NULL DEFAULT '0',
  "view_count" int(11) NOT NULL DEFAULT '0',
  "focus_count" int(11) NOT NULL DEFAULT '0',
  "comment_count" int(11) NOT NULL DEFAULT '0',
  "action_history_id" int(11) NOT NULL DEFAULT '0',
  "category_id" int(11) NOT NULL DEFAULT '0',
  "agree_count" int(11) NOT NULL DEFAULT '0',
  "against_count" int(11) NOT NULL DEFAULT '0',
  "best_answer" int(11) NOT NULL DEFAULT '0',
  "has_attach" tinyint(1) NOT NULL DEFAULT '0',
  "unverified_modify" text,
  "unverified_modify_count" int(10) NOT NULL DEFAULT '0',
  "last_answer" int(11) NOT NULL DEFAULT '0',
  "popular_value" double NOT NULL DEFAULT '0',
  "popular_value_update" int(10) NOT NULL DEFAULT '0',
  "lock" tinyint(1) NOT NULL DEFAULT '0',
  "anonymous" tinyint(1) NOT NULL DEFAULT '0',
  "thanks_count" int(10) NOT NULL DEFAULT '0',
  "question_content_fulltext" text,
  "is_recommend" tinyint(1) NOT NULL DEFAULT '0',
  "received_email_id" int(10) DEFAULT NULL,
  "chapter_id" int(10) DEFAULT NULL,
  "sort" tinyint(2) NOT NULL DEFAULT '0'
);

CREATE TABLE "aws_question_comments" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "question_id" int(11) DEFAULT '0',
  "uid" int(11) DEFAULT '0',
  "message" text,
  "time" int(10) DEFAULT NULL,
  "anonymous" tinyint(1) DEFAULT '0'
);

CREATE TABLE "aws_redirect" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "item_id" int(11) DEFAULT '0',
  "target_id" int(11) DEFAULT '0',
  "time" int(10) DEFAULT NULL,
  "uid" int(11) DEFAULT NULL
);

CREATE TABLE "aws_related_topic" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "topic_id" int(11) DEFAULT '0',
  "related_id" int(11) DEFAULT '0'
);

CREATE TABLE "aws_topic" (
  "topic_id" int(11) PRIMARY KEY NOT NULL,
  "topic_title" varchar(64) DEFAULT NULL,
  "add_time" int(10) DEFAULT NULL,
  "discuss_count" int(11) DEFAULT '0',
  "topic_description" text,
  "topic_pic" varchar(240) DEFAULT NULL,
  "topic_lock" tinyint(2) NOT NULL DEFAULT '0',
  "focus_count" int(11) DEFAULT '0',
  "user_related" tinyint(1) DEFAULT '0',
  "url_token" varchar(32) DEFAULT NULL,
  "merged_id" int(11) DEFAULT '0',
  "seo_title" varchar(240) DEFAULT NULL,
  "parent_id" int(10) DEFAULT '0',
  "is_parent" tinyint(1) DEFAULT '0',
  "discuss_count_last_week" int(10) DEFAULT '0',
  "discuss_count_last_month" int(10) DEFAULT '0',
  "discuss_count_update" int(10) DEFAULT '0'
);

CREATE TABLE "aws_topic_focus" (
  "focus_id" int(11) PRIMARY KEY NOT NULL,
  "topic_id" int(11) DEFAULT NULL,
  "uid" int(11) DEFAULT NULL,
  "add_time" int(10) DEFAULT NULL
);

CREATE TABLE "aws_topic_merge" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "source_id" int(11) NOT NULL DEFAULT '0',
  "target_id" int(11) NOT NULL DEFAULT '0',
  "uid" int(11) DEFAULT '0',
  "time" int(10) DEFAULT '0'
);

CREATE TABLE "aws_topic_relation" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "topic_id" int(11) DEFAULT '0',
  "item_id" int(11) DEFAULT '0',
  "add_time" int(10) DEFAULT '0',
  "uid" int(11) DEFAULT '0',
  "type" varchar(16) DEFAULT NULL
);

CREATE TABLE "aws_user_follow" (
  "follow_id" int(11) PRIMARY KEY NOT NULL,
  "fans_uid" int(11) DEFAULT NULL,
  "friend_uid" int(11) DEFAULT NULL,
  "add_time" int(10) DEFAULT NULL
);

CREATE TABLE "aws_users" (
  "uid" int(11) PRIMARY KEY NOT NULL,
  "user_name" varchar(240) DEFAULT NULL,
  "password" varchar(60) DEFAULT NULL,
  "salt" varchar(16) DEFAULT NULL,
  "avatar_file" varchar(128) DEFAULT NULL,
  "sex" tinyint(1) DEFAULT NULL,
  "reg_time" int(10) DEFAULT NULL,
  "last_login" int(10) DEFAULT '0',
  "notification_unread" int(11) NOT NULL DEFAULT '0',
  "inbox_unread" int(11) NOT NULL DEFAULT '0',
  "inbox_recv" tinyint(1) NOT NULL DEFAULT '0',
  "fans_count" int(10) NOT NULL DEFAULT '0',
  "friend_count" int(10) NOT NULL DEFAULT '0',
  "invite_count" int(10) NOT NULL DEFAULT '0',
  "article_count" int(10) NOT NULL DEFAULT '0',
  "question_count" int(10) NOT NULL DEFAULT '0',
  "answer_count" int(10) NOT NULL DEFAULT '0',
  "topic_focus_count" int(10) NOT NULL DEFAULT '0',
  "group_id" int(10) DEFAULT '0',
  "forbidden" tinyint(1) DEFAULT '0',
  "is_first_login" tinyint(1) DEFAULT '1',
  "agree_count" int(10) DEFAULT '0',
  "thanks_count" int(10) DEFAULT '0',
  "views_count" int(10) DEFAULT '0',
  "reputation" int(10) DEFAULT '0',
  "currency" int(10) DEFAULT '0',
  "user_name_update_time" int(10) DEFAULT '0',
  "verified" varchar(32) DEFAULT NULL,
  "default_timezone" varchar(32) DEFAULT NULL,
  "recent_topics" text
);

CREATE TABLE "aws_users_attrib" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "uid" int(11) DEFAULT NULL,
  "introduction" varchar(240) DEFAULT NULL,
  "signature" varchar(240) DEFAULT NULL
);

CREATE TABLE "aws_users_group" (
  "group_id" int(11) PRIMARY KEY NOT NULL,
  "type" tinyint(3) DEFAULT '0',
  "custom" tinyint(1) DEFAULT '0',
  "group_name" varchar(50) NOT NULL,
  "reputation_lower" int(11) DEFAULT '0',
  "reputation_higer" int(11) DEFAULT '0',
  "reputation_factor" float DEFAULT '0',
  "permission" text
);
