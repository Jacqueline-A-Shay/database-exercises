use employees;

select * from employees where first_name IN ('Irena', 'Vidya', 'Maya');
select * from employees where last_name like ('E%');
select * from employees where (hire_date between "1990-01-01" and "1999-12-31");
select * from employees where (DATE_FORMAT(birth_date, '%m %d') = DATE_FORMAT('1957-12-25', '%m %d'));
or 
select * from employees where birth_date like "%-12-25";

select * from employees where (last_name like "%q%" );

select * from employees where first_name = 'Irena' or first_name= 'Vidya' or first_name = 'Maya';
select * from employees where (first_name = 'Irena' or first_name= 'Vidya' or first_name = 'Maya') and gender = 'M';
select * from employees where last_name like ('E%') and last_name like '%E';

select * from employees where (hire_date between "1990-01-01" and "1999-12-31") AND (DATE_FORMAT(birth_date, '%m %d') = DATE_FORMAT('1957-12-25', '%m %d'));

select * from employees where (last_name like "%q%" ) AND (last_name not like "%qu%");


-- 1)Create a file named 3.5.1_where_exercises.sql. Make sure to use the employees database 
USE employees;
-- 2)Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya');
-- 3)Find all employees whose last name starts with 'E'
SELECT * FROM employees	WHERE last_name LIKE 'E%';
-- 4) Find all employees hired in the 90s 
SELECT * FROM employees WHERE hire_date BETWEEN'1990-01-01' AND '1999-12-31';
-- 5) Find all employees born on Christmas 
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- 6) Find all employees with a 'q' in their last name 
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 1)Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT * FROM employees WHERE first_name='Irena'OR first_name='Vidya'OR first_name='Maya';
-- 2)Add a condition to the previous query to find everybody with those names who is also male
SELECT * FROM employees WHERE (first_name='Irena'OR first_name='Vidya'OR first_name='Maya') AND gender='M';
-- 3) Find all employees whose last name starts or ends with 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 4) Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%E';
-- 5) Find all employees hired in the 90s and born on Christmas.
SELECT * FROM employees WHERE hire_date BETWEEN'1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';
-- 6)Find all employees with a 'q' in their last name but not 'qu'
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
