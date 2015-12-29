-- Author LIU,SHOU YUNG
-- Date:09/05/2015
-- Purpose: CSE Lab2-Select practice

BEGIN

-- Select all the Data from Order Details Table
SELECT * 
FROM [Order Details];

--Select all the Data from Customors Table,Order by Contact Name
SELECT *
FROM Customers
ORDER BY ContactName;

--Select all the Data from Orders Table Order by OrderDate Oldest Date on top
SELECT *
FROM Orders
ORDER BY OrderDate ASC;

--Select all the Data from Orders Tables Order by ShippedDate, Newest Date on top
SELECT * 
FROM Orders
ORDER by ShippedDate DESC;

--Select all the Data from Orders Tables where Order has not shipped yet
SELECT *
FROM Orders
WHERE ShippedDate is Null;

--Select CompanyName,Contact Name and Contact Title from the Customers Table, where Company Name Starts with D
SELECT CompanyName, ContactName, ContactTitle
FROM Customers
WHERE CompanyName Like 'D%'; 

--Select EmployeeId, FirstName,LastName and Title from the Employees Table, where last name starts with 'D','E',or 'F'
SELECT EmployeeId,FirstName,LastName,Title
FROM Employees
WHERE 
	LastName Like ('D%') OR LastName Like('E%') OR LastName Like ('F%');

--Select numbers of records from supplier table
SELECT COUNT(*) AS 'Suppiler Record Count'
	FROM Suppliers;

END







