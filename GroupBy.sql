-- GROUP BY QUERIES FROM http://www.mysqltutorial.org/mysql-group-by.aspx

-- GROUP BY

-- Select all the orders status and group them by clause "status"
SELECT 
    status
FROM
    orders
GROUP BY status;

-- Return the number of orders foreach status 
SELECT 
    status, COUNT(*) `N. Orders`
FROM
    orders
GROUP BY status;

-- Return the total amount approximated of all orders by order status
SELECT 
    status, ROUND(SUM(quantityOrdered * priceEach)) AS amount
FROM
    orders
        INNER JOIN
    orderdetails USING (orderNumber)
GROUP BY status;

-- Return the number of orders per order status and sort them by descending order
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status DESC;

-- Return the order number, the number of items sold and total sales per order 
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach) AS total
FROM
    orderdetails
GROUP BY ordernumber;

-- Return the numbers of orders per year
SELECT 
    YEAR(orderDate) AS year, COUNT(orderNumber) AS `N. orders`
FROM
    orders
GROUP BY year;

-- Return the total sales for each year for "shipped" orders
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
        INNER JOIN
    orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY YEAR(orderDate);


-- GROUP BY and HAVING clause

-- Return the total sales for each year for "shipped" orders from 2004 up now
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
        INNER JOIN
    orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY year
HAVING year > 2003;

-- Return the order number, the number of items sold and total sales per order 
-- having total sales > 1000$
SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING total > 1000;

-- Return all the orders that have sales greater than 1500$ and are "shipped"
SELECT 
    a.ordernumber, SUM(priceeach) total, status
FROM
    orderdetails a
        INNER JOIN
    orders b ON b.ordernumber = a.ordernumber
GROUP BY ordernumber
HAVING b.status = 'Shipped' AND total > 1500;