-- STORED PROCEDURES WITHOUT PARAMETERS

-- Select all the products from the "products" table
DROP PROCEDURE IF EXISTS GetAllProducts;
DELIMITER //
CREATE PROCEDURE GetAllProducts()
	BEGIN
    SELECT * FROM products;
    END //
DELIMITER ;

-- Select office code and country of all the office from the "offices" table 
DROP PROCEDURE IF EXISTS GetOffices;
DELIMITER //
CREATE PROCEDURE GetOfficesCodeAndCountry()
	BEGIN
    SELECT officeCode, country 
    FROM offices;
    END //
DELIMITER ;
    
DROP PROCEDURE IF EXISTS GetOfficeByCountry;
DELIMITER //
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
	BEGIN
    SELECT * 
    FROM offices
    WHERE country = countryName;
    END //
DELIMITER ;

DROP PROCEDURE IF EXISTS CountOrderByStatus;
DELIMITER //
CREATE PROCEDURE CountOrderByStatus(
	IN orderStatus VARCHAR(25),
    OUT total int)
BEGIN
    SELECT count(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS set_counter;
DELIMITER //
CREATE PROCEDURE set_counter(INOUT count INT(4), IN inc INT(4))
BEGIN
	SET count = count + inc;
END //
DELIMITER ;
    
    
CALL `classicmodels`.`GetOfficeByCountry`('France');
CALL `classicmodels`.`CountOrderByStatus`('Shipped', @total);
SELECT @total;

CALL `classicmodels`.`CountOrderByStatus`('in process', @total);
SELECT @total as total_in_process;