DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN target_table INT)
BEGIN
DECLARE Booked INT DEFAULT 0;
SELECT COUNT(1) INTO Booked FROM bookings WHERE BookingDate = booking_date AND TableSlot = target_table;
START TRANSACTION;
SET autocommit = 0;
INSERT INTO Bookings(BookingDate, TableSlot) VALUES(booking_date, target_table);
IF Booked > 0 THEN
	SELECT CONCAT("Table ", target_table, " is already booked. -Booking CANCELED.") AS "Booking Status";
	ROLLBACK;
ELSE
	SELECT CONCAT("Table ", target_table, " has been booked for ", booking_date) AS "Booking Status";
    COMMIT;
END IF;
SET autocommit = 1;
END //
DELIMITER ;
CALL AddValidBooking('2022-10-10', 1)