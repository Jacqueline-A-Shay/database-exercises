USE join_example_db;

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
JOIN roles as r ON r.id = u.role_id;

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
LEFT JOIN roles as r ON r.id = u.role_id;

SELECT u.name as Employee_Name, r.name as Position
FROM users as u
RIGHT JOIN roles as r ON r.id = u.role_id;

select roles.name, count(*)
from roles
RIGHT JOIN users ON users.role_id = roles.id
GROUP BY roles.name;
-----------------------------------------------------------------------------------

-- no2
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name, departments.dept_name as Department_Name
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01';

-- no 3

SELECT departments.dept_name as Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE e.gender = 'F' AND dm.to_date = '9999-01-01'
ORDER BY Department_Name;

-- no4 
SELECT t.title AS Title, count(title) as Count
FROM titles as t
JOIN dept_emp as de ON de.emp_no = t.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE dept_name = 'Customer Service' AND t.to_date='9999-01-01'
GROUP BY title;

-- no5
SELECT departments.dept_name as Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name, s.salary
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY dept_name;

-- no6
SELECT de.dept_no, d.dept_name, count(e.emp_no)
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees AS e ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no;


-- no7
SELECT d.dept_name, avg(s.salary) as highest_salary
FROM departments as d
JOIN dept_emp as de ON d.dept_no = de.dept_no
JOIN salaries as s ON s.emp_no = de.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

-- no8
SELECT e.first_name, e.last_name
FROM employees as e
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN dept_emp as de ON de.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Marketing' AND  s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;


-- no9
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Manager_Full_Name, s.salary, departments.dept_name as Department_Name
FROM employees AS e
JOIN dept_manager as dm ON dm.emp_no = e.emp_no
JOIN salaries as s ON s.emp_no = e.emp_no
JOIN departments ON departments.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;
