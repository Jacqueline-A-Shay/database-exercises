use albums_db;
SHOW tables;
DESCRIBE albums;

SELECT name
FROM albums
WHERE artist = 'Pink Floyd';

SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band ";

SELECT genre
FROM albums
WHERE name = 'Nevermind';

SELECT name
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

SELECT name
FROM albums
WHERE sales < 20;

SELECT name, genre
FROM albums
WHERE genre = "Rock";
-- because it is an explicit search
-- if want to query the genres containing Rock, need to do as follow

SELECT name, genre
FROM albums
WHERE genre LIKE '%Rock%';
