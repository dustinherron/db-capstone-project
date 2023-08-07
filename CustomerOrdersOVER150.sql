SELECT DISTINCT c.CustomerID,
    CONCAT(cd.FirstName, cd.LastName) AS CustomerName, 
    o.OrderID,
    o.TotalPrice,
    m.Category AS MenuName,
    m.Name AS CourseName
FROM Customers AS c
	INNER JOIN ContactDetails cd ON c.contactdetails = cd.contactdetailsID
    INNER JOIN Orders AS o ON c.CustomerID = o.Customer
    INNER JOIN orderitem AS oi ON o.OrderID = oi.OrderID
    INNER JOIN Menu AS m ON oi.MenuItem = m.MenuItemID
WHERE o.TotalPrice > 150
    ORDER BY o.TotalPrice ASC;
