PREPARE GetOrderDetail FROM "SELECT o.OrderID, oi.Quantity, o.TotalPrice AS Cost
FROM Customers AS c
    INNER JOIN Orders AS o ON c.CustomerID = o.Customer
    INNER JOIN OrderItem AS oi ON oi.OrderID = oi.OrderID

WHERE o.Customer = ?";

SET @id = 15;
EXECUTE GetOrderDetail USING @id;