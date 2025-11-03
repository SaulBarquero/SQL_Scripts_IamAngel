USE Northwind

SELECT CustomerID, CompanyName, ContactName
FROM Customers 
WHERE City = 'Berlin'

SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID 
GROUP BY e.EmployeeID, e.FirstName, e.LastName 
ORDER BY TotalSales ASC;

SELECT ProductName, UnitsInStock
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM [Order Details])

SELECT ProductID 
FROM [Order Details]

SELECT ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock > 100

SELECT OrderID, OrderDate, ShipName
FROM Orders
WHERE OrderDate BETWEEN '1997-03-01' AND '1997-03-31';

SELECT OrderID, OrderDate, ShipName
FROM Orders
WHERE OrderDate > '1997-03-01' AND OrderDate < '1997-03-31'
