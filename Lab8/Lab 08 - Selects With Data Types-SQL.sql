-- Author LIU,SHOU YUNG
-- Date:10/11/2015
-- Purpose: CSE Lab8- System Function

--1.	Select all data from the Orders table,
--		ordered by OrderDate, newest date on top, 
--		for orders shipped between January 1997 and August 1997.
SELECT * 
	FROM Orders
	WHERE 
		YEAR(ShippedDate) = 1997 and 
		(MONTH(ShippedDate) > =1 and MONTH(shippedDate) <=8)
	ORDER BY 
		OrderDate DESC;

--2.	Select all data from the Orders table, 
--		ordered by OrderDate, newest date on top, 
--		for orders placed between July 1996 and January 1997.
SELECT * 
	FROM Orders
	WHERE 
		(YEAR(OrderDate) = 1996 and MONTH(OrderDate) >= 7 ) or 
		(YEAR(OrderDate) = 1997 and MONTH(OrderDate) <=1)
	ORDER BY 
		OrderDate DESC;

--3.	Select all data from the Orders table, 
--		for orders placed in January 1998.
SELECT *
	FROM Orders
	WHERE 
		YEAR(OrderDate) = 1998 and Month(OrderDate) = 1;

--4.	Select count of Orders shipped in 1996, 1997 and 1998. 
--		(one query containing all values) -> 2 columns (count and year), 3 rows (1 row per year)
--		Question about if the sql use without where clause, there will be more then one null row
SELECT COUNT(ShippedDate) AS 'Count',YEAR(ShippedDate) AS'Year'
	FROM Orders
	WHERE 
		YEAR(ShippedDate) = 1996 or
		YEAR(ShippedDate) = 1997 or
		YEAR(ShippedDate) = 1998
	GROUP BY YEAR(ShippedDate)
	ORDER BY YEAR(ShippedDate);
