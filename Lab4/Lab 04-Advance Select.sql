-- Author LIU,SHOU YUNG
-- Date:09/012/2015
-- Purpose: CSE Lab4-Advance Select search

--1.	List all company names and number of orders they placed, for companies that placed more than 5 orders.
SELECT  
		Customers.CompanyName, 
		COUNT(Orders.OrderId) AS OrderCount 
	FROM Customers 
	JOIN Orders 
		ON Customers.CustomerID = Orders.CustomerID
	GROUP BY Customers.CompanyName
	HAVING COUNT(Orders.OrderId) >5;

	Select CustomerId, Count(*) from Orders 
	GROUP BY CustomerId
	HAVING COUNT(*) > 5;
--2.	List all employees (names and IDs only) and their corresponding managers (names only).
SELECT 
	 emp.EmployeeID, emp.FirstName+' '+emp.LastName AS 'Employee Name',
	 mgmt.FirstName+' '+ mgmt.LastName AS 'Respond To' 
FROM Employees emp
	LEFT JOIN Employees mgmt 
		ON emp.ReportsTo = mgmt.EmployeeID
ORDER BY 'Respond To';


-- Only for SQL Server Function
-- 1. ROLLUP
-- add summary row to each category
-- cannot to use distinct
-- Practice GROUP BY  WITH ROLLUUP
-- Add summary for each CustomerId 
	SELECT CustomerID, YEAR(Orders.OrderDate) AS OrderDate ,COUNT(OrderID) AS OrderCount
	FROM Orders
	GROUP BY CustomerID, YEAR(Orders.OrderDate) WITH ROLLUP;
-- 2. CUBE
-- add summary row into data-for each set of the group as well as summary row
-- cannot use distinct
-- Practice CUBE with GROUP BY
-- Summary data with each Categgory,like OrderDate, Order Count
	SELECT Orders.CustomerID,YEAR(Orders.OrderDate),COUNT(Orders.OrderID)
	FROM Orders
	GROUP BY Orders.CustomerID, YEAR(Orders.OrderDate) WITH CUBE; 
-- 3. GROUPING SETS
-- Works similary to ROLLUP/CUBE -creates a summary row for each specific group
-- cannot use distinct
-- Simultaneously run different Group By
	SELECT CustomerID, YEAR(OrderDate) AS OrderDate, COUNT(OrderID) AS OrderCount
	FROM Orders
	GROUP BY GROUPING SETS( CustomerID,YEAR(OrderDate));

-- 4. OVER clause, partitionning and ordering of the rowset before the associate function is applied
-- Partition by
-- Order by
-- Row of Range  
	SELECT CustomerID, YEAR(OrderDate) AS OrederYear , COUNT(OrderID) OVER( PARTITION BY YEAR(OrderDate) ) AS OrderCount
	FROM Orders





