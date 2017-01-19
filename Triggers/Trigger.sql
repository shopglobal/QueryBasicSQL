-- TRIGGERS

-- Create a trigger that "backup" the record that is updated in the 
-- employee table in a new table called "employee_audit"
DELIMITER $$
CREATE TRIGGER before_employee_update
	before update on employees
    for each row
begin
	insert into employee_audit
    set action = 'update',
		employeeNumber = OLD.employeeNumber,
			lastname = OLD.lastname,
            changedat = NOW();
END $$
DELIMITER ;

UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;

select * from employee_audit;


-- Trigger to control if the balance value is more than 0 on data INSERT
DELIMITER $$

CREATE TRIGGER before_accounts_insert
	BEFORE INSERT ON Accounts FOR EACH ROW
    BEGIN
		IF 
			NEW.balance < 0
        THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot insert record, balance is less than 0';
		END IF;
	END;
$$

-- Trigger to control if the balance value is more than 0 on data UPDATE
CREATE TRIGGER before_accounts_update
	BEFORE UPDATE ON Accounts FOR EACH ROW
    BEGIN
		IF 
			OLD.balance >= 0 AND NEW.balance < 0
		THEN
			SIGNAL sqlstate '45000'
				SET MESSAGE_TEXT = 'Cannot update record, balance is less than 0';
		END IF;
	END;
$$

INSERT INTO Accounts (acctId, balance) VALUES (101, 100);
INSERT INTO Accounts (acctId, balance) VALUES (202, 100);
SELECT * from Accounts;
COMMIT;

UPDATE Accounts SET balance = balance - 100 WHERE acctId = 101;
UPDATE Accounts SET balance = balance + 100 WHERE acctId = 202;
SELECT * from Accounts;

-- -------------------------------------------------------------------------- --


-- MULTIPLE TRIGGERS

-- Trigger to backup change and also annote the user that update data
-- First trigger (backup)
DELIMITER $$

CREATE TRIGGER before_products_update
	BEFORE UPDATE ON products FOR EACH ROW
	BEGIN
		INSERT INTO price_logs(product_code, price)
        VALUES(old.productCode, old.MSRP);
	END;
$$

DELIMITER ;

-- Second trigger (user)
DELIMITER $$

CREATE TRIGGER before_products_update_follows
	BEFORE UPDATE ON products
    FOR EACH ROW FOLLOWS before_products_update
    BEGIN
		INSERT INTO user_change_logs(product_code, updated_by)
        VALUES(old.productCode, user());
	END;
$$

DELIMITER ;


-- TRIGGERS INFORMATION

-- Show all triggers
show triggers;

-- Show triggers from a specific schema
show triggers from classicmodels;

-- Select all the information of a specific trigger from the information_schema database
select 
	*
from 
	information_schema.TRIGGERS
where
	TRIGGER_SCHEMA = 'classicmodels' and TRIGGER_NAME = 'before_products_update';

-- Select all the triggers that involves a specific table from the information_schema database
select
	*
from
	information_schema.TRIGGERS
where
	EVENT_OBJECT_TABLE = 'products';
    
-- Show the execution order of a trigger in the information_schema database
select 
	trigger_name, action_order
from
	information_schema.TRIGGERS
where
	TRIGGER_SCHEMA = 'classicmodels'
order by EVENT_OBJECT_TABLE,
		ACTION_TIMING,
        EVENT_MANIPULATION;
        
-- Remove a trigger
drop trigger before_products_update_follows;