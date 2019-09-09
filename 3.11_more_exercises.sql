-- How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?

use employees;

SELECT ds.dept_name, SAL
FROM 
	(SELECT d.dept_name as "Dept", s.salary
	FROM employees AS e
		JOIN dept_manager as dm ON dm.emp_no = e.emp_no AND dm.to_date = '9999-01-01' 
		JOIN salaries as s ON s.emp_no = e.emp_no AND s.to_date = '9999-01-01'
		JOIN departments d ON d.dept_no = dm.dept_no
		JOIN (SELECT d.dept_name, AVG(s.salary) as "SAL"
					FROM employees AS e
					JOIN salaries as s ON s.emp_no = e.emp_no
					JOIN dept_emp as de ON de.emp_no = s.emp_no
					JOIN departments d ON d.dept_no = de.dept_no
					WHERE s.to_date = '9999-01-01'
					GROUP BY d.dept_name) as ds ON ds.dept_name  = d.dept_name;


SELECT ds.dept_name
FROM 
	(SELECT d.dept_name as "Dept", s.salary
	FROM employees AS e
		JOIN dept_manager as dm ON dm.emp_no = e.emp_no AND dm.to_date = '9999-01-01' 
		JOIN salaries as s ON s.emp_no = e.emp_no AND s.to_date = '9999-01-01'
		JOIN departments d ON d.dept_no = dm.dept_no
		WHERE s.salary < (SELECT d.dept_name, AVG(s.salary) as "SAL"
					FROM employees AS e
					JOIN salaries as s ON s.emp_no = e.emp_no
					JOIN dept_emp as de ON de.emp_no = s.emp_no
					JOIN departments d ON d.dept_no = de.dept_no
					WHERE s.to_date = '9999-01-01')
					group by de;




-- World Database
-- Use the world database for the questions below.

-- What languages are spoken in Santa Monica?
Select cl.Language, cl.Percentage
From countrylanguage cl
JOIN city c ON cl.CountryCode = c.CountryCode
WHERE c.Name = 'Santa Monica'
ORDER BY cl.Percentage;
total c.Population;
select * from countrylanguage;

-- +------------+------------+
-- | Language   | Percentage |
-- +------------+------------+
-- | Portuguese |        0.2 |
-- | Vietnamese |        0.2 |
-- | Japanese   |        0.2 |
-- | Korean     |        0.3 |
-- | Polish     |        0.3 |
-- | Tagalog    |        0.4 |
-- | Chinese    |        0.6 |
-- | Italian    |        0.6 |
-- | French     |        0.7 |
-- | German     |        0.7 |
-- | Spanish    |        7.5 |
-- | English    |       86.2 |
-- +------------+------------+
-- 12 rows in set (0.01 sec)

-- How many different countries are in each region?
SELECT Region, COUNT(*) FROM country GROUP BY Region ORDER BY COUNT(*);

-- +---------------------------+---------------+
-- | Region                    | num_countries |
-- +---------------------------+---------------+
-- | Micronesia/Caribbean      |             1 |
-- | British Islands           |             2 |
-- | Baltic Countries          |             3 |
-- | Antarctica                |             5 |
-- | North America             |             5 |
-- | Australia and New Zealand |             5 |
-- | Melanesia                 |             5 |
-- | Southern Africa           |             5 |
-- | Northern Africa           |             7 |
-- | Micronesia                |             7 |
-- | Nordic Countries          |             7 |
-- | Central America           |             8 |
-- | Eastern Asia              |             8 |
-- | Central Africa            |             9 |
-- | Western Europe            |             9 |
-- | Eastern Europe            |            10 |
-- | Polynesia                 |            10 |
-- | Southeast Asia            |            11 |
-- | Southern and Central Asia |            14 |
-- | South America             |            14 |
-- | Southern Europe           |            15 |
-- | Western Africa            |            17 |
-- | Middle East               |            18 |
-- | Eastern Africa            |            20 |
-- | Caribbean                 |            24 |
-- +---------------------------+---------------+
-- 25 rows in set (0.00 sec)

What is the population for each region?
SELECT Region, SUM(Population) FROM country GROUP BY Region ORDER BY SUM(Population) DESC;

-- +---------------------------+------------+
-- | Region                    | population |
-- +---------------------------+------------+
-- | Eastern Asia              | 1507328000 |
-- | Southern and Central Asia | 1490776000 |
-- | Southeast Asia            |  518541000 |
-- | South America             |  345780000 |
-- | North America             |  309632000 |
-- | Eastern Europe            |  307026000 |
-- | Eastern Africa            |  246999000 |
-- | Western Africa            |  221672000 |
-- | Middle East               |  188380700 |
-- | Western Europe            |  183247600 |
-- | Northern Africa           |  173266000 |
-- | Southern Europe           |  144674200 |
-- | Central America           |  135221000 |
-- | Central Africa            |   95652000 |
-- | British Islands           |   63398500 |
-- | Southern Africa           |   46886000 |
-- | Caribbean                 |   38140000 |
-- | Nordic Countries          |   24166400 |
-- | Australia and New Zealand |   22753100 |
-- | Baltic Countries          |    7561900 |
-- | Melanesia                 |    6472000 |
-- | Polynesia                 |     633050 |
-- | Micronesia                |     543000 |
-- | Antarctica                |          0 |
-- | Micronesia/Caribbean      |          0 |
-- +---------------------------+------------+
-- 25 rows in set (0.00 sec)

-- What is the population for each continent?
SELECT Continent, SUM(Population) FROM country GROUP BY Continent ORDER BY SUM(Population) DESC;
-- +---------------+------------+
-- | Continent     | population |
-- +---------------+------------+
-- | Asia          | 3705025700 |
-- | Africa        |  784475000 |
-- | Europe        |  730074600 |
-- | North America |  482993000 |
-- | South America |  345780000 |
-- | Oceania       |   30401150 |
-- | Antarctica    |          0 |
-- +---------------+------------+
-- 7 rows in set (0.00 sec)

-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country;

-- +---------------------+
-- | avg(LifeExpectancy) |
-- +---------------------+
-- |            66.48604 |
-- +---------------------+
-- 1 row in set (0.00 sec)

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT Continent, AVG(LifeExpectancy) FROM country GROUP BY Continent ORDER BY AVG(LifeExpectancy);

-- -- +---------------+-----------------+
-- -- | Continent     | life_expectancy |
-- -- +---------------+-----------------+
-- -- | Antarctica    |            NULL |
-- -- | Africa        |        52.57193 |
-- -- | Asia          |        67.44118 |
-- -- | Oceania       |        69.71500 |
-- -- | South America |        70.94615 |
-- -- | North America |        72.99189 |
-- -- | Europe        |        75.14773 |
-- -- +---------------+-----------------+
-- 7 rows in set (0.00 sec)

SELECT Region, AVG(LifeExpectancy) FROM country GROUP BY Region ORDER BY AVG(LifeExpectancy);
-- +---------------------------+-----------------+
-- | Region                    | life_expectancy |
-- +---------------------------+-----------------+
-- | Antarctica                |            NULL |
-- | Micronesia/Caribbean      |            NULL |
-- | Southern Africa           |        44.82000 |
-- | Central Africa            |        50.31111 |
-- | Eastern Africa            |        50.81053 |
-- | Western Africa            |        52.74118 |
-- | Southern and Central Asia |        61.35000 |
-- | Southeast Asia            |        64.40000 |
-- | Northern Africa           |        65.38571 |
-- | Melanesia                 |        67.14000 |
-- | Micronesia                |        68.08571 |
-- | Baltic Countries          |        69.00000 |
-- | Eastern Europe            |        69.93000 |
-- | Middle East               |        70.56667 |
-- | Polynesia                 |        70.73333 |
-- | South America             |        70.94615 |
-- | Central America           |        71.02500 |
-- | Caribbean                 |        73.05833 |
-- | Eastern Asia              |        75.25000 |
-- | North America             |        75.82000 |
-- | Southern Europe           |        76.52857 |
-- | British Islands           |        77.25000 |
-- | Western Europe            |        78.25556 |
-- | Nordic Countries          |        78.33333 |
-- | Australia and New Zealand |        78.80000 |
-- +---------------------------+-----------------+
-- 25 rows in set (0.00 sec)

-- Find all the countries whose local name is different from the official name
SELECT c.Name 'Countries Having Official Name Different From Local Name'
FROM country c
WHERE c.Name NOT IN (SELECT c.LocalName FROM country c);

-- Countries Having Official Name Different From Local Name
-- Afghanistan
-- Albania
-- Netherlands Antilles
-- United Arab Emirates
-- Armenia
-- American Samoa
-- Antarctica
-- French Southern territories
-- Austria
-- Azerbaijan
-- Burundi
-- Belgium
-- Bulgaria
-- Bahrain
-- Bahamas
-- Bosnia and Herzegovina
-- Brazil

-- Total 135 rows

-- How many countries have a life expectancy less than x?
SELECT count(*) as ' The number of countries having average life expentancy less than Bulgaria' FROM country WHERE LifeExpectancy < (SELECT LifeExpectancy from country c where c.Name = 'Bulgaria');
-- The number of countries having average life expentancy less than Bulgaria
-- 117

-- What state is city x located in?
SELECT District FROM city c WHERE CountryCode = 'USA' AND Name = 'Clearwater';
-- District
-- Florida

-- What region of the world is city x located in?

SELECT Region 
FROM city c 
JOIN country cy ON c.CountryCode =cy.Code
WHERE c.Name = 'Herat';

-- Region
-- Southern and Central Asia

-- What country (use the human readable name) city x located in?

SELECT cy.Name as 'Country where the city Herat belongs:'
FROM city c 
JOIN country cy ON c.CountryCode =cy.Code
WHERE c.Name = 'Herat';
-- Country where the city Herat belongs:
-- Afghanistan


-- What is the life expectancy in city x?
SELECT cy.LifeExpectancy as 'How long do the residance of Herat, Afghanistan typically live? '
FROM city c 
JOIN country cy ON c.CountryCode =  cy.Code
WHERE c.Name = 'Herat';
select * from city;

-- How long do the residance of Herat, Afghanistan typically live? 
-- 45.9



-- USE Sakila Database
-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(CONCAT(first_name, ' ', last_name)) FROM actor;
-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, 
-- "Joe." What is one query would you could use to obtain this information?

SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- Find all actors whose last name contain the letters "gen":
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%gen%';

-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;  

-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');  

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, count(*) FROM actor GROUP BY (last_name);  

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, count(*) FROM actor GROUP BY (last_name)  HAVING count(*) > 2;  

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
create table?

-- Use JOIN to display the first and last names, as well as the address, of each staff member.

SELECT s.first_name, s.last_name, CONCAT(a.address, ' ', a.district), a.postal_code FROM staff s
JOIN address a ON a.address_id = s.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.

SELECT s.first_name, count(r.rental_date)
FROM rental r
JOIN staff s ON r.staff_id = s.staff_id
WHERE DATE_FORMAT(r.rental_date, '%Y %m') = DATE_FORMAT('2005-08-01', '%Y %m')
GROUP BY s.staff_id;

-- List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(*) 
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(*) 
FROM film f
JOIN inventory i ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- SELECT fkq.title
FROM film as f 
JOIN language l ON f.language_id = l.language_id 
JOIN (SELECT title 
			FROM film 
			WHERE title LIKE 'K%' OR title LIKE 'Q%') AS fkq ON fkq.title = f.title
			where l.language_id = '1';
-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(a.first_name, ' ', a.last_name)
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip') AS ff ON ff.film_id = fa.film_id;

-- NOT DONE
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.category_id = '8';

-- NOT DONE
-- Write a query to display how much business, in dollars, each store brought in.


-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, cy.country
FROM store s
JOIN address a ON a.address_id = s.address_id 
JOIN city c ON c.city_id = a.city_id
JOIN country cy ON cy.country_id = c.country_id;


-- List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: 
SELECT c.name AS 'Top 5 Selling Genres'
FROM payment p
LEFT JOIN rental r ON p.rental_id = r.rental_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film_category fc ON fc.film_id = i.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- SELECT statements

-- Select all columns from the actor table.
SELECT * FROM actor;

-- Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- Select only the following columns from the film table.
SELECT title FROM film;

/* DISTINCT operator */

/* Select all distinct (different) last names from the actor table. */
SELECT DISTINCT(last_name) FROM actor;
/* 
Select all distinct (different) postal codes from the address table. */
SELECT DISTINCT(postal_code) FROM address;
/* 
Select all distinct (different) ratings from the film table. */
SELECT DISTINCT(rating) FROM film;

/* WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer. */
SELECT title, description, rating, length FROM film WHERE length > 180;
/* 
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005. */
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date > '2005-05-27 00:00:00' ORDER BY payment_date;
/* 
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005. */
SHOW CREATE TABLE payment;
SELECT payment_id, amount, payment_date FROM payment WHERE DATE_FORMAT(payment_date, '%Y %M %D') = DATE_FORMAT('2005-05-27', '%Y %M %D') ;
/* 
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N. */
SELECT * FROM customer WHERE last_name LIKE 'S%' AND first_name LIKE 'N%';

/* Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M". */
SELECT * FROM customer WHERE active = 0;
/* 
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T. */
SELECT * FROM category WHERE category_id > 4 AND name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%';

/* Select all columns minus the password column from the staff table for rows that contain a password. */
USE bayes_817;
CREATE TABLE drop_pwd
AS (SELECT * FROM sakila.staff WHERE password NOT LIKE ' ');
select*from drop_pwd;
ALTER TABLE drop_pwd DROP COLUMN password;
select*from drop_pwd;

/* Select all columns minus the password column from the staff table for rows that do not contain a password. */
USE bayes_817;
CREATE TABLE drop_pwd_null
AS (SELECT * FROM sakila.staff WHERE password IS NULL);
select*from drop_pwd_null;
ALTER TABLE drop_pwd_null DROP COLUMN password;
select*from drop_pwd_null;




