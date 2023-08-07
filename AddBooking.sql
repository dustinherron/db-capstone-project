DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT,  booking_date DATE, IN table_number INT)
BEGIN
INSERT INTO Bookings(BookingID, Customers, BookingDate, TableSlot) VALUES(booking_id, customer_id, booking_date, table_number);
SELECT CONCAT("New Booking Added.") AS "Confirmation";
END //
DELIMITER ;

-- if testing this customer IDs are 1-32. use any tableslot you want. the value below has probably been used in testing.
CALL AddBooking(5, 12, '2022-10-10', 6);