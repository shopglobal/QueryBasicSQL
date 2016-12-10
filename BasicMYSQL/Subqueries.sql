-- SUBQUERIES FROM http://www.mysqltutorial.org/mysql-subquery/

SELECT 
    lastname, firstname
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');
                        					
-- Select the customer whit the maximum payment
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount = (SELECT 
            MAX(amount)
        FROM
            payments);

-- Select the customers whose payments are greater than the avarage payment
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            payments)
ORDER BY amount;

-- Select the maximum, minimum and avarage number of items in sale orders
SELECT 
    MAX(items) AS 'MASSIMO',
    MIN(items) AS 'MINIMO',
    FLOOR(AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        orderdetails
    GROUP BY orderNumber) AS lineitems;


-- IN and NOT IN operators

-- Select all the customers that haven't ordered any products yet
SELECT 
    customername
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);

