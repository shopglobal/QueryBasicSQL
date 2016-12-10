-- JOIN QUERIES FROM http://www.mysqltutorial.org/mysql-inner-join.aspx

-- COLUMN ALIAS

-- Select and print all the employees' "firstname" and "lastname" in column 'Full Name' 
-- then order by this value
SELECT 
	CONCAT_WS(',', lastname, firstname) AS `Full Name`
FROM
	employees
ORDER BY
	`Full Name`;


-- TABLE ALIAS

-- Select all the customers and all the orders and order them by their total orders
SELECT 
	c.customerName,
    COUNT(o.orderNumber) total
FROM 
	customers c
    INNER JOIN orders o 
		ON c.customerNumber = o.customerNumber
    GROUP BY
		customerName
	ORDER BY
		total DESC;
		
    
-- INNER JOIN

-- Select product code, product name e text description dalle tabelle productlines e products
SELECT
	productCode, productName, textDescription
FROM
   products T1
INNER JOIN productlines T2 ON T1.productline = T2.productline;

-- Select order state and number of order from table 'orders' and 'orderdetails'
SELECT
	o.orderNumber,
    o.status,
    SUM(quantityOrdered * priceEach) total
FROM 
	orders o
    INNER JOIN orderdetails od 
		ON o.orderNumber = od.orderNumber
	GROUP BY
		orderNumber;


-- LEFT JOIN

-- Select all the orders for every client (some could have 0 orders)
SELECT
	c.customerNumber,
    c.customerName,
    o.orderNumber,
    o.status
FROM
	customers c
	LEFT JOIN orders o
		ON o.customerNumber = c.customerNumber;
        
-- Select all the clients that haven't ordered something yet
SELECT
	c.customerNumber,
	c.customerName,
    o.orderNumber,
    o.status
FROM
	customers c
    LEFT JOIN orders o 
		ON o.customerNumber = c.customerNumber
	WHERE
		o.orderNumber IS NULL;
        
        
-- SELF JOIN

-- Obtain the hierarchical organization of the firm (manager reports to employeer?)
SELECT
	CONCAT(m.lastname, ',', m.firstname) Manager,
    CONCAT(e.lastname, ',', e.firstname) `Direct report`
FROM
	employees e
	INNER JOIN employees m 
		ON m.employeeNumber = e.reportsTo
	ORDER BY Manager;
    
-- Obtain the position of the top manager (which obviously, he doesn't reports to anyone)
SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
        LEFT JOIN
    employees m ON m.employeeNumber = e.reportsto
ORDER BY manager DESC;

-- Obtain all the clients that live in the same city
SELECT
	c1.city,
    c1.customerName,
    c2.customerName
FROM
	customers c1
    INNER JOIN customers c2 
		ON c1.city = c2.city AND
			c1.customerName > c2.customerName
		ORDER BY c1.city;
