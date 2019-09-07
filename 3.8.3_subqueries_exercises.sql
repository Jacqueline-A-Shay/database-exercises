-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query.
-- 69 Rows
SELECT e.emp_no, hire_date 
FROM employees as e
    WHERE hire_date IN
        (SELECT hire_date FROM employees WHERE emp_no = '101010');

-- 2. Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles
-- using sub-query
SELECT t.title as 'Title', e.first_name as 'Name', count(t.title) as 'Count'
FROM employees e
RIGHT JOIN titles t
ON t.emp_no = e.emp_no
	WHERE first_name IN
	(SELECT e.first_name
	FROM employees e
	WHERE e.first_name = 'Aamod')
	GROUP BY t.title;

-- using join
	SELECT t.title, e.first_name, count(t.title) as 'Count'
	FROM employees as e
	JOIN titles t 
	ON t.emp_no = e.emp_no
	WHERE e.first_name = 'Aamod'
	GROUP BY t.title;

-- 3. How many people in the employees table are no longer working for the company?
    SELECT count(de.to_date) as 'Count Previous Employees'
    FROM employees e
        JOIN dept_emp de ON de.emp_no = e.emp_no
            WHERE de.to_date IN (
                SELECT de.to_date
                FROM dept_emp AS de WHERE de.to_date NOT LIKE '9999-01-01');

-- 4. Find all the current department managers that are female.

+------------+------------+
| first_name | last_name  |
+------------+------------+
| Isamu      | Legleitner |
| Karsten    | Sigstam    |
| Leon       | DasSarma   |
| Hilary     | Kambil     |
+------------+------------+

SELECT e.first_name, e.last_name
FROM employees e
    JOIN dept_manager dm ON dm.emp_no = e.emp_no
         WHERE dm.emp_no IN
            (SELECT dm.emp_no FROM dept_manager dm 
                WHERE to_date = '9999-01-01')
AND e.gender = 'F';

-- 5. Find all the employees that currently have a higher than average salary.

154543 rows in total. Here is what the first 5 rows will look like:


+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+

SELECT e.first_name as 'First Name', e.last_name as 'Last Name', s.salary as 'Salary'
FROM employees e
JOIN salaries as s on e.emp_no = s.emp_no
WHERE s.salary > (
			SELECT AVG(s.salary) FROM salaries s)
AND s.to_date > NOW();

-- 6. How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

78 salaries

-- Bonus 
-- Find all the department names that currently have female managers.

+-----------------+
| dept_name       |
+-----------------+
| Development     |
| Finance         |
| Human Resources |
| Research        |
+-----------------+

SELECT d.dept_name  'Department'
FROM dept_manager dm
JOIN departments d ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no
WHERE e.emp_no IN (
SELECT e.emp_no FROM employees e WHERE gender = 'F')
AND dm.to_date = '9999-01-01'
ORDER BY d.dept_name;

-- Find the first and last name of the employee with the highest salary.


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Tokuyasu   | Pesch     |
+------------+-----------+
Find the department name that the employee with the highest salary works in.


+-----------+
| dept_name |
+-----------+
| Sales     |
+-----------+

lec notes
-- create temp tables will not change schema
CREATE TEMPORARY TABLE employee_salary AS
	SELECT first_name, last_name, salary
	FROM employees.employees
	JOIN employees.salaries USING(emp_no);
SELECT * FROM employee_salary;

CREATE TEMPORARY TABLE FAV_ACTOR AS
    SELECT first_name, last_name
    FROM sakila.actors
    WHERE first_name like '%JAC';

CREATE TEMPORARY TABLE captains(
    name VARCHAR(256) not null,
    ship VARCHAR(256)
);
