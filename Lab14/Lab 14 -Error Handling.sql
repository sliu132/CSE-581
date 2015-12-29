---- Author LIU,SHOU YUNG
-- Date:11/3/2015
-- Purpose: CSE Lab14 Error Handling 
-- Function Error handling practice
CREATE PROCEDURE dbo.errorHandling(@dividend AS INT, @divisor AS INT, @result AS DECIMAL(3,1) OUT)
AS
BEGIN
	DECLARE @tempDividend AS INT = @dividend
	DECLARE @tempDivisor AS INT = @divisor
	BEGIN TRY
		SELECT @result = @tempDividend / @tempDivisor 
	RETURN
	END TRY
	BEGIN CATCH
		PRINT ('An error has occured')
		SELECT @result = -1
	END CATCH
END;