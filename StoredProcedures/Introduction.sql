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
DROP PROCEDURE IF EXISTS GetOfficesCodeAndCountry;
DELIMITER //
CREATE PROCEDURE GetOfficesCodeAndCountry()
	BEGIN
    SELECT officeCode, country 
    FROM offices;
    END //
DELIMITER ;
 
CALL GetAllProducts();
CALL GetOfficesCodeAndCountry();



