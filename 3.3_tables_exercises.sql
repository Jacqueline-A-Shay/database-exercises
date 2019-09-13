USE employees;
SHOW TABLES;

SELECT *FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='employees'; 

DESCRIBE employees;
-- employees contains int(11) as pk, date, varchar(14)(16, enum('M','F')

DESCRIBE current_dept_emp;
-- current_dept_emp contain int char date

DESCRIBE departments;
-- char varchar

DESCRIBE dept_emp;
-- int char date

DESCRIBE dept_emp_latest_date;
-- int date

DESCRIBE  dept_manager;
-- int, char, date

DESCRIBE  salaries;
-- int, date
DESCRIBE titles;
-- int varchar date

-- table contain numeric: employees, current_dept_emp, dept_emp,dept_emp_latest_date, salaries, titles

-- table contain string: employees, current_dept_emp, departments, dept_emp, dept_manager, titles

-- table contain date; current_dept_emp, dept_emp, dept_emp_latest_date, dept_manager, salaries, title

-- relationship between employees and departments linked by another table: dept_emp
-- if joining the 2 tables we'll be able to know what department does each employee belong to 

-- show SQL that created dept_manager
SHOW CREATE TABLE dept_manager;




USE employees;
SHOW TABLES;
SHOW CREATE TABLE employees;
SELECT * FROM employees;
SELECT * FROM departments;
SHOW CREATE TABLE dept_manager;
