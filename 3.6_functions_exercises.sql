select concat(first_name, " ", last_name)
as full_name
from employees
where concat(first_name, " ", last_name) like 'e%e';

select upper(concat(first_name, " ", last_name))
as full_name
from employees
where concat(first_name, " ", last_name) like 'e%e';

select first_name, last_name, datediff(curdate(),hire_date) as days_with_company
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25'

select
lower(concat(
        	substr(first_name, 1,1),
        	substr(last_name, 1, 4),
        	"_",
        	substr(birth_date, 6,2),
        	substr(birth_date,3,2)
			)
		),
	first_name,
	last_name,
	birth_date
from employees;
