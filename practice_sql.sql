USE sakila;
SELECT * FROM actor;
SELECT last_name, first_name FROM actor;
SELECT * FROM actor WHERE last_name = 'Cage';

SELECT * FROM actor WHERE last_name = 'cage'; -- by default non casesensitive 

SELECT actor_id, first_name, last_name 
FROM actor 
WHERE actor_id BETWEEN 11 AND 40;
