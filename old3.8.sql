CREATE TABLE roles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  role_id INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');

DESCRIBE roles;
SELECT * FROM roles;

INSERT INTO users (name, email, role_id) VALUES
('bob', 'bob@example.com', 1),
('joe', 'joe@example.com', 2),
('sally', 'sally@example.com', 3),
('adam', 'adam@example.com', 3),
('jane', 'jane@example.com', null),
('mike', 'mike@example.com', null);

select * from users;
select * from roles;

SELECT u.name as User_Name, u.email as User_Email, r.name as Position
FROM users as u
LEFT JOIN roles as r ON u.role_id = r.id;
USE employees;
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

-- 3.8
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

-- unDONE 

select * from roles;
SELECT roles.name
FROM roles
LEFT JOIN (SELECT users.role_id, count(*) 
FROM users
GROUP BY users.role_id) as RC
ON roles.id = RC.role_id;




SELECT u.name as Employee_Name, r.name as Position
FROM users as u
LEFT JOIN (
SELECT users.role_id, count(*) 
FROM users
GROUP BY role_id
);


SELECT bk1.book_name,bk1.pub_lang,bk1.book_price 
FROM  book_mast as bk1
JOIN(SELECT pub_lang,MAX(book_price) AS  price          
FROM book_mast           
GROUP BY pub_lang) AS bk2          
ON bk1.pub_lang=bk2.pub_lang AND bk1.book_price=bk2.price;


--  conti
use employees;
select * from departments;
select * from employees;
select * from dept_manager
order by to_date DESC;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.emp_no, dm.dept_no, dm.to_date
FROM employees AS e
JOIN dept_manager as dm 
	ON dm.emp_no = e.emp_no WHERE dm.to_date = '9999-01-01';

SELECTJOIN departments as d 
	ON d.dept_no = dm.dept_no;

select emp_no, dept_no, to_date from dept_manager WHERE to_date = '9999-01-01' ;
dept_no, dept_name from departments;


SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

-- part 2 done
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
