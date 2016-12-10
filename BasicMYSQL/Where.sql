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
    state IS NOT NULL;
    
-- BETWEEN, LIKE, IN, IS NULL
-- Select all products which price is between 10 and 20 (BBTWEEN)
SELECT 
    productName, productLine, buyPrice
FROM
    products
WHERE
    products.buyPrice BETWEEN 10 AND 20;
    
-- Select all customers whose origin city start with letter "s"
SELECT 
    customerName, city
FROM
    customers
WHERE
    city LIKE 's%';
    
-- Select all customers whose origin city is "Paris" or "London"
SELECT 
    customerName, city
FROM
    customers
WHERE
    city IN ('Paris' , 'London');

-- Select all customers whose postalCode is null
SELECT 
    customerName, postalCode
FROM
    customers
WHERE
    customers.postalCode IS NULL;
