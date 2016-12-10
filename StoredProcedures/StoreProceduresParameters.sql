-- STORED PROCEDURES WITH PARAMETERS

-- Selezionare gli uffici che si trovano in un paese passato come parametro dall'utente
DROP PROCEDURE IF EXISTS GetOfficeByCountry;
DELIMITER //
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
	BEGIN
    SELECT * 
    FROM offices
    WHERE country = countryName;
    END //
DELIMITER ;

-- Selezionare in numero di ordini che si trovano in un determinato "status"
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

-- Costruire una procedura che trasformi un numero in ingresso sommandolo con un
-- altro numero che passiamo in ingresso
DROP PROCEDURE IF EXISTS set_counter;
DELIMITER //
CREATE PROCEDURE set_counter(INOUT count INT(4), IN inc INT(4))
BEGIN
	SET count = count + inc;
END //
DELIMITER ;
    
-- Calling procedures

--
CALL GetOfficeByCountry('France');
--

--
CALL CountOrderByStatus('Shipped', @total);
SELECT @total as total_in_shipped;

CALL CountOrderByStatus('in process', @total);
SELECT @total as total_in_process;
--

--
SET @counter = 1;
CALL set_counter(@counter, 1); -- 2
CALL set_counter(@counter, 2); -- 4
CALL set_counter(@counter, 5); -- 9
SELECT @counter;
--