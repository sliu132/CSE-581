-- Author LIU,SHOU YUNG
-- Date:09/012/2015
-- Purpose: CSE Lab5- System Function

--1.List all employee names in the following format: LAST NAME, first name. 
--(Uppercased last name, followed by comma and space, followed by lowercased first name).
SELECT UPPER(LastName)+ ', '+LOWER(FirstName) AS 'Employee Name'
	FROM Employees;

--2.List all company names as well as the length of their name, from the Customers table. 2 Columns – Company Name, Text length.
SELECT CompanyName AS 'Company Name', LEN(CompanyName) AS 'Text Length'
 FROM Customers;

--3.List all shipped dates as well as expected delivery dates from the Orders table WHERE SHIP DATE is present.
-- (Expected delivery date is 5 days from the ship date).

SELECT ShippedDate,DATEADD(DAY,5,ShippedDate) AS 'Expected Delivery Date' 
	FROM Orders
	WHERE ShippedDate is NOT NULL;

--4.List all orders from the Orders table that were shipped in 1998.
SELECT YEAR(Orders.ShippedDate) AS 'Order Shipped in 1998'
FROM Orders 
WHERE (YEAR(Orders.ShippedDate) > 1997) and (YEAR(Orders.ShippedDate) < 1999) ;

--5.List all orders placed on January 1st 1997, from the Orders table.
SELECT * 
	FROM Orders
	WHERE OrderDate > ('19970106') and OrderDate <('19970108');

-- Lecture Introduction
-- System Function
--
-- 1. String
-- STR : Convert from Number to String, 
-- LEN : Get Text Length
-- UPPER: Convert Upper text
-- LOWER: Convert Lower text
-- INITCAP: Upper case for first letter
-- REPLACE: Replace column text
-- 2. Math
-- 3. DateTime 
--	DataAdd
--	Datediff
--	GetDate
--	GetUTCDate
-- YEAR, DAY,HOURS, 
-- OFFSET, TIMESTAMP
-- 4. 
