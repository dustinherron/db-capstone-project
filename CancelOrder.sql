DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
DELETE FROM OrderItem WHERE OrderID = order_id;
DELETE FROM Orders WHERE OrderID = order_id;
SELECT CONCAT("Order", order_id, " has been cancelled") as Confirmation;
END //
-- orders 2 and 3 have already been canceled.
CALL CancelOrder(3);