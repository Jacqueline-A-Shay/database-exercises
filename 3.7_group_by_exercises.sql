select distinct(title) from titles;

select 
last_name from employees where last_name like 'e%e'
group by last_name;

select 
concat(first_name, ' ', last_name) as full_name 
from employees where last_name like 'e%e'
group by full_name;

select first_name, last_name from employees.employees where last_name like 'e%e' group by last_name, first_name;

select last_name from employees where (last_name like "%q%" ) AND (last_name not like "%qu%") group by last_name;

select 
concat(first_name, ' ', last_name) as full_name, count(*)
from employees
group by full_name
order by count(*);

select gender, count(*)
from employees
where first_name IN ('Irena', 'Vidya', 'Maya') 
group by gender;

select gender, count(*)
from employees
where first_name IN ('Irena', 'Vidya', 'Maya') or last_name IN ('Irena', 'Vidya', 'Maya')
group by gender;

select lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2))) as username from employees
                group by username;

select lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2))) as username, count(*) from employees
                group by username
                having count(*)>1;    

select count(*) as count_all, count(distinct lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2)))) as count_distinct, (count(*) -count(distinct lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2)))))as difference  from employees;
-- soln
SELECT COUNT(*) FROM
(SELECT COUNT(*) AS username_count, LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username FROM employees.employees
 GROUP BY username HAVING username_count>1) AS test;


-- create a new file named 3.7_group_by_exercises.sql
-- 2) In your script, use DISTINCT to find the unique titles table.
 
 SELECT DISTINCT title from employees.titles;
 -- 3) Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY.
 
 SELECT last_name  FROM employees.employees WHERE last_name LIKE 'E%E' GROUP BY last_name ;
 -- 4) Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
 
 SELECT first_name,last_name FROM employees.employees WHERE last_name LIKE 'E%E' GROUP BY last_name,first_name;
 -- 5) Find the unique last names with a 'q' but not 'qu'.
 
 SELECT last_name FROM employees.employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
-- 6) Add a COUNT() to your results and use ORDER BY to make it easier to find employess whose unusual name is shared with others.
  
  SELECT COUNT(*),last_name FROM employees.employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name ORDER BY last_name;
  -- 7) Update your query for 'Irena', 'Vidya' or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
  
  SELECT gender,COUNT(*) FROM employees.employees WHERE first_name IN ('Irena','Vidya','Maya') GROUP BY gender;
-- 8)Recall the query that generated usernames for the employees from the last lesson. Are there any duplicate usernames? Bonus: How many duplicate usernames are there?

-- total number of duplicate ids
SELECT COUNT(*) FROM
(SELECT COUNT(*) AS username_count, LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username FROM employees.employees
 GROUP BY username HAVING username_count>1) AS test;
 
-- total number of duplicates
 SELECT SUM(test.username_count) FROM
(SELECT COUNT(*) AS username_count, LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username FROM employees.employees
 GROUP BY username HAVING username_count>1) AS test;
 
  
 SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username
 ,COUNT(*) FROM employees
 GROUP BY username
 ORDER BY COUNT(*) DESC; 
