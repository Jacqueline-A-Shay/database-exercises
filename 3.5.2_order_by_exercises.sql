use employees;

select * from employees where first_name IN ('Irena', 'Vidya', 'Maya') order by first_name;
select * from employees where first_name IN ('Irena', 'Vidya', 'Maya') order by first_name, last_name;
select * from employees where last_name like ('%E') order by emp_no;
select * from employees where last_name like ('E%') order by emp_no;

select * from employees where first_name IN ('Irena', 'Vidya', 'Maya') 
order by first_name DESC, last_name DESC;
select * from employees where last_name like ('%E%') order by emp_no DESC;

select * from employees 
WHERE (hire_date between "1990-01-01" and "1999-12-31") AND birth_date like "%-12-25" 
ORDER BY hire_date  DESC, birth_date ASC;
