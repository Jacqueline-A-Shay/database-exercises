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