DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(quantity) AS 'Max Quantity in Order'
FROM orderitem;
END //

DELIMITER ;

CALL GetMaxQuantity();