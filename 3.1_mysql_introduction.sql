SHOW databases;
-- mysql. user means use the mysql database and read from the user table
SELECT * FROM mysql.user;
-- select the user and host columns from the user table
SELECT user, host FROM mysql.user;
-- select all columns from the help_topic table on the mysql database
SELECT * FROM mysql.help_topic;
-- SELECT only certain columns
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;

  
SELECT * FROM mysql.user;
SELECT user, host FROM mysql.user;
SELECT * FROM mysql.help_topic;
SELECT help_topic_id,help_category_id,url FROM mysql.help_topic;
