USE join_example_db;

-- Use join, left join, and right join to combine results from the users and roles tables 

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
JOIN roles as r ON r.id = u.role_id;

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
LEFT JOIN roles as r ON r.id = u.role_id;

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
RIGHT JOIN roles as r ON r.id = u.role_id;

-- Use count and the appropriate join type to get a list of roles along with the number of 
-- users that has the role. # need to use group by in the query.
SELECT r.name,COUNT(*)
FROM roles AS r
INNER JOIN users AS u
ON u.role_id=r.id
GROUP BY r.name;
-----------------------------------------------------------------------------------

-- no2
-- write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name as Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
ORDER BY d.dept_name;

-- no 3
-- Find the name of all departments currently managed by women.

SELECT departments.dept_name as Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE e.gender = 'F' AND dm.to_date = '9999-01-01'
ORDER BY Department_Name;

-- no4 
-- Find the current titles of employees currently working in the Customer Service department.

SELECT t.title AS Title, count(title) as Count
FROM titles as t
JOIN dept_emp as de ON de.emp_no = t.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE dept_name = 'Customer Service' AND t.to_date='9999-01-01'
GROUP BY title;

-- no5
-- Find the current salary of all current managers.

SELECT departments.dept_name as Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name, s.salary
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY dept_name;

-- no6
-- Find the number of employees in each department.

SELECT de.dept_no, d.dept_name, count(e.emp_no)
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees AS e ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no;


-- no7
-- Which department has the highest average salary?

SELECT d.dept_name, avg(s.salary) as highest_salary
FROM departments as d
JOIN dept_emp as de ON d.dept_no = de.dept_no
JOIN salaries as s ON s.emp_no = de.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

-- no8
-- Who is the highest paid employee in the Marketing department?

SELECT e.first_name, e.last_name
FROM employees as e
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN dept_emp as de ON de.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Marketing' AND  s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;


-- no9
-- Which current department manager has the highest salary?

SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name, s.salary, departments.dept_name as Department_Name
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- bonus no10
-- Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name,' ',e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', z.manager_name
FROM  employees e
	LEFT JOIN dept_emp de ON e.emp_no=de.emp_no
	LEFT JOIN departments d ON d.dept_no=de.dept_no
	LEFT JOIN
		(SELECT CONCAT(e.first_name,' ',e.last_name) AS manager_name, dm.dept_no
		FROM dept_manager AS dm
		JOIN employees AS e ON dm.emp_no=e.emp_no
		WHERE dm.to_date='9999-01-01') AS z ON z.dept_no=d.dept_no
WHERE de.to_date='9999-01-01';

-- Find the highest paid employee in each department.
SELECT 
 	CONCAT(e.first_name,' ',e.last_name) AS 'Employee Name', 
 	d.dept_name AS 'Department Name', 
 	ss.Max_Salary_by_Department AS 'Salary'
 
FROM employees e
 	JOIN dept_emp de ON de.emp_no = e.emp_no
 	JOIN departments d ON de.dept_no = d.dept_no 
 	JOIN salaries s ON e.emp_no = s.emp_no
 	JOIN (
 		SELECT max(s.salary) as 'Max_Salary_by_Department', d.dept_name 
 		FROM salaries s
 			JOIN employees e ON e.emp_no = s.emp_no
 			JOIN dept_emp de ON de.emp_no = e.emp_no
 			JOIN departments d ON d.dept_no = de.dept_no
 			GROUP BY d.dept_name
 	) as ss ON ss.dept_name=d.dept_name AND ss.Max_Salary_by_Department=s.salary
 WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01';




