DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
DELETE FROM Bookings WHERE BookingID = booking_id;
SELECT CONCAT("Bookking ", booking_id, " canceled.") AS "Confirmation";
END //
DELIMITER ;

CALL CancelBooking(5);