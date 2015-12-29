---- Author LIU,SHOU YUNG
-- Date:11/3/2015
-- Purpose: CSE Lab14 Error Handling 
-- Function Error handling practice-Test
DECLARE @result AS DECIMAL(3,1)

EXEC dbo.errorHandling @dividend = 10 , @divisor = 2, @result =  @result OUT;

PRINT (@result);

EXEC dbo.errorHandling @dividend = 10 , @divisor = 0, @result =  @result OUT; 

PRINT (@result);


