---- Author LIU,SHOU YUNG
-- Date:11/20/2015
-- Purpose: CSE Lab 17 
-- Index
--Step 1. Create test Table
IF OBJECT_ID ('TestForIndex','U') IS NOT NULL
	DROP TABLE TestForIndex;
GO
CREATE TABLE TestForIndex
(
	TestID INT IDENTITY(1,1) PRIMARY kEY,
	Column1 INT NOT NULL
);
--Step 2. Create Store Procedue to insert 1 million records into table
IF OBJECT_ID ('dbo.InsertTestForIndex','P') IS NOT NULL
	DROP PROCEDURE InsertTestForIndex
GO
CREATE PROCEDURE dbo.InsertTestForIndex 
AS
	BEGIN
		-- 1. Sequence insert > 9 min, so cancel
		--CREATE SEQUENCE TestData
		--AS INT 
		--	START WITH 0
		--	INCREMENT BY 1
		--	MAXVALUE 1000000;
		--DROP SEQUENCE TestData
		--INSERT INTO TestForIndex(Column1)
		--SELECT NEXT VALUE FOR TestData;
		--GO 1000000
		--2. Union  3 sec
		WITH e1(n) AS
		(
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
			SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
		),
		e2(n) AS (SELECT 1 FROM e1 CROSS JOIN e1 AS b),
		e3(n) AS (SELECT 1 FROM e1 CROSS JOIN e2),
		e4(n) AS (SELECT 1 FROM e1 CROSS JOIN e3),
		e5(n) AS (SELECT 1 FROM e1 CROSS JOIN e4),
		e6(n) AS (SELECT 1 FROM e1 CROSS JOIN e5)
		INSERT INTO TestForIndex(Column1)
		SELECT n = ROW_NUMBER() OVER (ORDER BY n) FROM e6 ORDER BY n;

	END;
--Step 3. Execute SP,Verify data inserted correctly
EXEC dbo.InsertTestForIndex;
SELECT * FROM TestForIndex;

--Step 4. Test without index select
SET STATISTICS TIME ON 
SELECT * 
	FROM TestForIndex a,TestForIndex b
	WHERE a.TestID = b.Column1
	SET STATISTICS TIME OFF
GO 10
--Step 5. Create Index on column1 
CREATE INDEX TestColumn1Index 
ON TestForIndex (Column1);

--Step 6. Retest Again
SET STATISTICS TIME ON 
SELECT * 
	FROM TestForIndex a,TestForIndex b
	WHERE a.TestID = b.Column1
	SET STATISTICS TIME OFF
GO 10
--Step 7. Compute difference