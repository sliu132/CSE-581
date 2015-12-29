-- Date:11/9/2015
-- Purpose: CSE Lab15 
-- Function Cursor
USE sliu132Database
IF  OBJECT_ID('dbo.calculateStudentGrade') IS NOT NULL
	DROP FUNCTION dbo.calculateStudentGrade
GO
CREATE FUNCTION dbo.calculateStudentGrade (@studentId AS VARCHAR(20))
RETURNS DECIMAL(10,3) AS
	BEGIN 
		DECLARE @sumGrade AS DECIMAL = 0.00, @finalGrade AS DECIMAL = 0.00, @gradeCount AS INT  = 0
		DECLARE studentCursor CURSOR FOR SELECT FinalGrade FROM CourseEnrollment WHERE StudentId = @studentId

		OPEN studentCursor
			FETCH NEXT FROM studentCursor INTO @finalGrade
			WHILE @@FETCH_STATUS = 0
			BEGIN
				-- need to check the @gradeValue is not null
				IF @finalGrade is NULL 
					BEGIN
						SET @finalGrade = 0
					END
				SET @gradeCount  = @gradeCount + 1
				SET @sumGrade = @sumGrade +@finalGrade
				FETCH NEXT FROM studentCursor INTO @finalGrade
			END
		CLOSE studentCursor
		DEALLOCATE studentCursor
		RETURN ( @sumGrade / @gradeCount)
	END;
