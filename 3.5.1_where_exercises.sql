use employees;

select * from employees where first_name IN ('Irena', 'Vidya', 'Maya');
select * from employees where last_name like ('E%');
select * from employees where (hire_date between "1990-01-01" and "1999-12-31");
select * from employees where (DATE_FORMAT(birth_date, '%m %d') = DATE_FORMAT('1957-12-25', '%m %d'));
select * from employees where (last_name like "%q%" );

select * from employees where first_name = 'Irena' or first_name= 'Vidya' or first_name = 'Maya';
select * from employees where (first_name = 'Irena' or first_name= 'Vidya' or first_name = 'Maya') and gender = 'M';
select * from employees where last_name like ('E%') and last_name like '%E';

select * from employees where (hire_date between "1990-01-01" and "1999-12-31") AND (DATE_FORMAT(birth_date, '%m %d') = DATE_FORMAT('1957-12-25', '%m %d'));

select * from employees where (last_name like "%q%" ) AND (last_name not like "%qu%");
