DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(IN book_date DATE, IN target_table INT) 
BEGIN
IF EXISTS (SELECT * FROM Bookings WHERE BookingDate = book_date AND TableSlot = target_table)
THEN SELECT CONCAT("Table ", target_table, " is already booked.") AS 'Booking Status';
ELSE 
	SELECT CONCAT("Table ", target_table, " is available.") AS 'Booking Status';
END IF;
END //
DELIMITER ;

CALL CheckBooking('2022-10-10', 29);