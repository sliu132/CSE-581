-- Author LIU,SHOU YUNG
-- Date:09/05/2015
-- Purpose: CSE Lab3-Join practice
--1. List all orders and their corresponding order details.
SELECT * 
	FROM Orders,[Order Details]
	WHERE Orders.OrderID = [Order Details].OrderID;

--2. List all orders (OrderID) and all customers (Company Name), matching records appropriately.
SELECT Orders.OrderID, Customers.CompanyName
	FROM Orders FULL OUTER JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID
	ORDER BY ORDERID ASC;
		
--3. List orders (OrderID) and corresponding customers (Company Name), only where the records match up.
SELECT Orders.OrderID, Customers.CompanyName
	FROM Orders,Customers 
	WHERE Orders.CustomerID = Customers.CustomerID;

--4. List all orders (OrderID) and matching customers (Company Name).
SELECT Orders.OrderId, Customers.CompanyName
	FROM Orders LEFT OUTER JOIN Customers 
	ON Orders.CustomerID = Customers.CustomerID;

--5.List matching orders (OrderID) and all customers (Company Name).
SELECT Orders.OrderId, Customers.CompanyName 
	FROM Orders RIGHT OUTER JOIN Customers 
	ON Orders.CustomerID = Customers.CustomerID;



