-- SELECT QUERIES FROM http://www.mysqltutorial.org/mysql-select-statement-query-data.aspx

-- SELECT

-- Select all columns from employees table
SELECT 
    *
FROM
    employees;
    
-- Select lastname, firstname and jobtitle from employees table
SELECT 
    lastname, firstname, jobtitle
FROM
    employees;
  

-- SELECT and LIMIT

-- Select all columns from employees table, number of record limited at 10
SELECT 
    *
FROM
    employees
LIMIT
	10;

    
-- SELECT and DISTINCT

-- Select lastname without duplicates
SELECT DISTINCT
    lastname
FROM
    employees
ORDER BY lastname;

-- Select city and state from customers table. Combination of state and city
-- shouldn't be repeated 
SELECT DISTINCT
    state, city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY state , city;

-- Count the unique states of customers in the USA
SELECT 
    COUNT(DISTINCT state)
FROM
    customers
WHERE
    country = 'USA';