SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

SELECT first_name, last_name FROM employees
WHERE hire_date between "1990-01-01" and "1999-12-31" AND birth_date like "%-12-25"
ORDER BY birth_date ASC,  hire_date  DESC  LIMIT 5;

SELECT first_name, last_name FROM employees
WHERE hire_date between "1990-01-01" and "1999-12-31" AND birth_date like "%-12-25" 
ORDER BY birth_date ASC,  hire_date  DESC LIMIT 5 OFFSET 45;
