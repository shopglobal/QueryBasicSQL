-- WHERE QUERIES FROM http://www.mysqltutorial.org/mysql-where/

-- WHERE

-- Find all customers in office 1 with jobtitle as 'Sales Rep' 
SELECT 
    lastname, firstname, jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND officeCode = 1;
   
-- Find all customers in office 1 whose jobtitle is NOT 'Sales Rep'
SELECT 
    lastname, firstname, jobtitle
FROM
    employees
WHERE
    jobtitle <> 'Sales Rep';
    
-- Find all customers that has an origin state
SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL