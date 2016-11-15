-- ORDER BY QUERIES FROM http://www.mysqltutorial.org/mysql-where/

-- ORDER BY (asc by default)

-- Sort contacts by last name in ascending order
SELECT 
    contactLastname, contactFirstname
FROM
    customers
ORDER BY contactLastname;
 
 -- Sort contacts by last name in descending order and then by first name in ascending order
SELECT 
    contactLastname, contactFirstname
FROM
    customers
ORDER BY contactLastname DESC , contactFirstname ASC;
 
 -- Calculate the subtotal for each line item and sorts the table by it
SELECT 
    ordernumber,
    orderlinenumber,
    quantityOrdered * priceEach AS subtotal
FROM
    orderdetails
ORDER BY subtotal;

-- Select all orders and their status and sort them by status
SELECT 
    orderNumber, status
FROM
    orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');