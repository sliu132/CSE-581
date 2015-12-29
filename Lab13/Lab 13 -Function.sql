---- Author LIU,SHOU YUNG
-- Date:11/3/2015
-- Purpose: CSE Lab13 Function 
CREATE FUNCTION dbo.getGradeDescription (@CourseId AS INT, @gradeValue AS INT)
RETURNS VARCHAR(50) AS
	BEGIN
		DECLARE @description AS VARCHAR(50)
		DECLARE @gradeLetter AS VARCHAR(2) 
		
		SELECT Top 1 
			@gradeLetter = l.LetterGrade,
			@description = l.[Description]

		FROM CourseGrade,LetterGrades l
		WHERE 
			CourseGrade.LetterGradeId = l.LetterGradeId and 
			CourseGrade.CourseId	  =  @CourseId       and 
			CourseGrade.GradeValue    <= @gradeValue
		ORDER BY 
			CourseGrade.GradeValue DESC
		RETURN @description
	END;




