-- NO 1.
-- Using the example from the lesson, re-create the employees_with_departments table.
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_with_department (
	full_name VARCHAR(256) not null);

INSERT INTO employees_with_department SELECT CONCAT(first_name, ' ', last_name) FROM employees.employees;
SELECT * FROM employees_with_department LIMIT 5;

-- NO 2.
-- Create a temporary table based on the payment table from the sakila database. 
-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. For example, 1.99 should become 199
CREATE TEMPORARY TABLE digitss AS
SELECT amount, FORMAT((100*amount),0) FROM sakila.payment;

select* from digitss;

-- NO 3.
-- Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

use employees;
SELECT m.dept_name as 'Department', AVG(salary_z_score) as 'Average Salary'
FROM (
		SELECT d.dept_name, (s.salary-m.avg_sal)/ (m.stddev_sal) AS salary_z_score
		FROM dept_emp de 
				JOIN departments d ON d.dept_no = de.dept_no AND de.to_date > NOW()
				JOIN salaries s ON s.emp_no = de.emp_no AND s.to_date > NOW()
				JOIN (
						SELECT AVG(s.salary) as avg_sal, stddev(s.salary) as stddev_sal, d.dept_name, d.dept_no
						FROM departments as d
							JOIN dept_emp de ON (d.dept_no=de.dept_no)
							JOIN employees e ON (de.emp_no=e.emp_no)
							JOIN salaries s ON (e.emp_no=s.emp_no)
						WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
						GROUP BY d.dept_name) AS m ON m.dept_no = de.dept_no) as m			
GROUP BY m.dept_name;


-- +--------------------+-----------------+
-- | dept_name          | salary_z_score  | 
-- +--------------------+-----------------+
-- | Customer Service   | -0.065641701345 | 
-- | Development        | -0.060466339473 | 
-- | Finance            | 0.090924841177  | 
-- | Human Resources    | -0.112346685678 | 
-- | Marketing          | 0.111739523864  | 
-- | Production         | -0.057892021023 | 
-- | Quality Management | -0.091237862268 | 
-- | Research           | -0.056918950432 | 
-- | Sales              | 0.233859335317  | 
-- +--------------------+-----------------+




-- NO 4.
-- What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.

-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.

-- +--------------------+-----------------+
-- | years_with_company | salary_z_score  | 
-- +--------------------+-----------------+
-- | 0                  | -0.120126024615 | 
-- | 1                  | -0.191233079206 | 
-- | 2                  | -0.171645037241 | 
-- | 3                  | -0.156153559059 | 
-- | 4                  | -0.131917218919 | 
-- | 5                  | -0.115528505398 | 
-- | 6                  | -0.092492800591 | 
-- | 7                  | -0.068094840473 | 
-- | 8                  | -0.051630370714 | 
-- | 9                  | -0.030267415113 | 
-- | 10                 | -0.006900796634 | 
-- | 11                 | 0.01443330816   | 
-- | 12                 | 0.030400295561  | 
-- | 13                 | 0.054596508615  | 
-- | 14                 | 0.075180034951  | 
-- | 15                 | 0.095192818408  | 
-- +--------------------+-----------------+


-- Create a file named 3.9_temporary_tables.sql to do your work for this exercise.
-- 1) Using the example from the lesson, re-create the employeees_with_departments table.
USE employees;
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;
-- 1a) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR (30);
-- 1b) Update the full name column so that it contains the correct data.
UPDATE employees_with_departments
SET full_name= CONCAT(first_name," ",last_name);
-- 1c) Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
-- 1d) What is another way you could have ended up with this same table.
-- 2)CREATE TEMPORARY TABLE based on the payments table from the sakila database
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
USE sakila;
CREATE TEMPORARY TABLE payment_revamp AS
SELECT payment_id, customer_id,staff_id,rental_id,amount,payment_date,last_update
FROM payment;

ALTER TABLE payment_revamp
ADD amount_int INT(4);

UPDATE payment_revamp
SET amount_int=amount*100;

ALTER TABLE payment_revamp
DROP COLUMN amount;
-- 3)Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier,you should use the Z-score for salaries.
-- In terms of salary, what is the best department to work for? THe worst?
-- first method using subquery
USE employees;
SELECT b.dept_name,
AVG(b.salary_z_score)
FROM(
SELECT d.dept_name,
((SELECT AVG(salary) FROM salaries)-a.average_salary)/(SELECT STDDEV(salary) from salaries) AS salary_z_score
FROM dept_emp AS de
JOIN departments AS d ON (de.dept_no=d.dept_no) AND de.to_date='9999-01-01'
JOIN salaries as s ON (de.emp_no=s.emp_no) AND s.to_date='9999-01-01'
JOIN (
SELECT d.dept_name, 
AVG(s.salary) AS average_salary
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
GROUP BY d.dept_name) AS a ON (a.dept_name=d.dept_name)) AS b
GROUP BY b.dept_name
ORDER BY b.dept_name;

-- second method using temporary tables
-- DROP TABLE z_scores
USE employees;
CREATE TEMPORARY TABLE z_scores AS
SELECT d.dept_name,
((SELECT AVG(salary) FROM salaries)-a.average_salary_dept)/(SELECT STDDEV(salary) FROM salaries) AS salary_z_score
FROM dept_emp AS de
JOIN departments AS d ON (de.dept_no=d.dept_no) -- AND de.to_date='9999-01-01'
JOIN salaries as s ON (de.emp_no=s.emp_no) -- AND s.to_date='9999-01-01'
JOIN (
SELECT d.dept_name, 
AVG(s.salary) AS average_salary_dept,
STDDEV(s.salary) AS salary_stdev_dept
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
GROUP BY d.dept_name) AS a ON (a.dept_name=d.dept_name);

SELECT dept_name,AVG(salary_z_score)
FROM z_scores
GROUP BY dept_name;



-- 4)What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.
