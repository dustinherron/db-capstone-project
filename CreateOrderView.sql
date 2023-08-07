DROP VIEW IF EXISTS OrdersView;
CREATE VIEW OrdersView AS
SELECT  o.OrderID, oi.Quantity, o.TotalPrice AS Cost
FROM Orders AS o
    INNER JOIN OrderItem AS oi ON o.OrderID = oI.OrderID
WHERE oi.Quantity > 2;

