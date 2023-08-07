SELECT  m.Name
FROM Menu AS m
    INNER JOIN OrderItem AS oi ON oi.MenuItem = m.MenuItemID
	WHERE  oi.Quantity > 2;

