select distinct(title) from titles;

select 
last_name from employees where last_name like 'e%e'
group by last_name;

select 
concat(first_name, ' ', last_name) as full_name 
from employees where last_name like 'e%e'
group by full_name;

select last_name from employees where (last_name like "%q%" ) AND (last_name not like "%qu%") group by last_name;

select 
concat(first_name, ' ', last_name) as full_name, count(*)
from employees
group by full_name
order by count(*);

select gender, count(*)
from employees
where first_name IN ('Irena', 'Vidya', 'Maya') 
group by gender;

select gender, count(*)
from employees
where first_name IN ('Irena', 'Vidya', 'Maya') or last_name IN ('Irena', 'Vidya', 'Maya')
group by gender;

select lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2))) as username from employees
                group by username;
