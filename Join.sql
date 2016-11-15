-- JOIN QUERIES FROM http://www.mysqltutorial.org/mysql-inner-join.aspx

-- INNER JOIN

-- Select product code, product name e text description dalle tabelle productlines e products
SELECT
	productCode, productName, textDescription
FROM
   products T1
INNER JOIN productlines T2 ON T1.productline = T2.productline;

--