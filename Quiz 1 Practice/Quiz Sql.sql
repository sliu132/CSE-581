-- a.	List all order data (Orders table) placed by Customer ID AROUT or BERGS or BLAUS
SELECT * 
FROM Orders
WHERE 
	CustomerId = 'AROUT'or 
	CustomerId ='BERGS'or 
	CustomerId='BLAUS'
ORDER BY CustomerId;

--b.	Select all data from the Orders table, ordered by OrderDate, oldest date on top, 
--		for orders placed between August 1998 and February 1999.
SELECT * 
	FROM Orders 
	ORDER BY orderdate DESC;

SELECT * 
	FROM Orders
	WHERE CONVERT (DATETIME,OrderDate) >=  CONVERT(DATETIME,'1998-08-01') and
	      CONVERT (DATETIME,OrderDate) <=  CONVERT(DATETIME,'1999-02-01') 
	ORDER BY 
		OrderDate DESC;

--c.	List all orders and their corresponding order details.

SELECT * 
	FROM Orders o
	JOIN [Order Details] d on o.OrderID = d.OrderID

--d.	List all company names, and the number of orders that company placed, as long as the company placed more than 5 orders.

SELECT c.CompanyName,COUNT(o.OrderID) AS 'OrderCount'
FROM Orders o 
	JOIN Customers c 
	on o.CustomerID = c.CustomerID
GROUP BY c.CompanyName 
HAVING COUNT(o.OrderID) >5;


--e.	Select all data from the Orders table, 
--		ordered by OrderDate, oldest date on top, 
--		for orders placed between August 1998 and February 1999.
-- Repeat at b

--f.	List all orders and their corresponding order details.
--repeat with c

--g.	List all data from Orders table for orderId 10253
SELECT * 
	FROM Orders
	WHERE OrderId = '10253';


--h.	Select all data from the Orders table, 
--		ordered by OrderDate, oldest date on top, 
--		for orders placed between March 1998 and April 1999.
SELECT * 
FROM Orders
WHERE 
	CONVERT(DATETIME, OrderDate) >= CONVERT(DATETIME,'1998-03-01') and 
	CONVERT(DATETIME, OrderDate) <= CONVERT(DATETIME,'1999-04-01')
ORDER BY 
	Orderdate DESC;

--i.	List all orders (OrderID) and all customers (Company Name), matching records appropriately.
SELECT * 
	FROM Orders
	RIGHT OUTER JOIN 
		Customers 
	ON Orders.CustomerId = Customers.CustomerId;

--j.	Select all data from the Orders table, ordered by OrderDate, oldest date on top, for orders placed between March 1998 and April 1999.
--repeat with h

--k.	Select EmployeeID, FirstName, LastName and Title from the Employees table, where last name starts with A, B, C or D.
SELECT * 
	FROM Employees
	WHERE 
		LastName Like 'A%' or 
		LastName like 'B%' or 
		LastName like 'C%' or 
		LastName like 'D%'
	ORDER BY LastName;
--l.	Select all data from the Orders table, ordered by ShippedDate, newest date on top.
SELECT * 
FROM Orders
ORDER BY ShippedDate DESC ;

--m.	List all employees (names and IDs only) and their corresponding managers (names only).
SELECT 
	e.Title, e.EmployeeID, 
	e.FirstName + ' ' + e.LastName AS 'Employees Name',
	e.ReportsTo, Mgmt.FirstName+ ' ' +Mgmt.LastName AS 'Supervisor Name'
FROM EMPLOYEES e
LEFT JOIN 
	EMPLOYEES Mgmt ON e.ReportsTo = Mgmt.EmployeeID
ORDER BY 
	e.ReportsTo;