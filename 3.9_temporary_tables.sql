-- NO 1.
-- Using the example from the lesson, re-create the employees_with_departments table.
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_with_department (
	full_name VARCHAR(256) not null);

INSERT INTO employees_with_department SELECT CONCAT(first_name, ' ', last_name) FROM employees.employees;
SELECT * FROM employees_with_department LIMIT 5;

-- NO 2.
-- Create a temporary table based on the payment table from the sakila database. 
-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. For example, 1.99 should become 199
CREATE TEMPORARY TABLE digitss AS
SELECT amount, FORMAT((100*amount),0) FROM sakila.payment;

select* from digitss;

-- NO 3.
-- Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

-- +--------------------+-----------------+
-- | dept_name          | salary_z_score  | 
-- +--------------------+-----------------+
-- | Customer Service   | -0.065641701345 | 
-- | Development        | -0.060466339473 | 
-- | Finance            | 0.090924841177  | 
-- | Human Resources    | -0.112346685678 | 
-- | Marketing          | 0.111739523864  | 
-- | Production         | -0.057892021023 | 
-- | Quality Management | -0.091237862268 | 
-- | Research           | -0.056918950432 | 
-- | Sales              | 0.233859335317  | 
-- +--------------------+-----------------+




-- NO 4.
-- What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.

-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.

-- +--------------------+-----------------+
-- | years_with_company | salary_z_score  | 
-- +--------------------+-----------------+
-- | 0                  | -0.120126024615 | 
-- | 1                  | -0.191233079206 | 
-- | 2                  | -0.171645037241 | 
-- | 3                  | -0.156153559059 | 
-- | 4                  | -0.131917218919 | 
-- | 5                  | -0.115528505398 | 
-- | 6                  | -0.092492800591 | 
-- | 7                  | -0.068094840473 | 
-- | 8                  | -0.051630370714 | 
-- | 9                  | -0.030267415113 | 
-- | 10                 | -0.006900796634 | 
-- | 11                 | 0.01443330816   | 
-- | 12                 | 0.030400295561  | 
-- | 13                 | 0.054596508615  | 
-- | 14                 | 0.075180034951  | 
-- | 15                 | 0.095192818408  | 
-- +--------------------+-----------------+