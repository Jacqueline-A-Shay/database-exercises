select distinct(title) from titles;

select 
last_name from employees where last_name like 'e%e'
group by last_name;

select 
concat(first_name, ' ', last_name) as full_name 
from employees where last_name like 'e%e'
group by full_name;

select first_name, last_name from employees.employees where last_name like 'e%e' group by last_name, first_name;

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

select lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2))) as username, count(*) from employees
                group by username
                having count(*)>1;    

select count(*) as count_all, count(distinct lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2)))) as count_distinct, (count(*) -count(distinct lower(concat(
                substr(first_name, 1,1),
                substr(last_name, 1, 4),
                "_",
                substr(birth_date, 6,2),
                substr(birth_date,3,2)))))as difference  from employees;
-- soln
SELECT COUNT(*) FROM
(SELECT COUNT(*) AS username_count, LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username FROM employees.employees
 GROUP BY username HAVING username_count>1) AS test;
 
