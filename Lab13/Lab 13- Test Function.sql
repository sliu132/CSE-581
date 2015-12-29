---- Author LIU,SHOU YUNG
-- Date:11/3/2015
-- Purpose: CSE Lab13 Function 
-- Function test Script
SELECT dbo.getGradeDescription(1,95)  AS 'Grade Description';

SELECT dbo.getGradeDescription(2,95)  AS 'Grade Description';
			
SELECT dbo.getGradeDescription(2,85)  AS 'Grade Description';


--DROP FUNCTION dbo.getGradeDescription;
DECLARE @CourseId AS INT = 1
DECLARE @gradeValue AS INT = 95
SELECT TOP 3*
		FROM CourseGrade,LetterGrades l
		WHERE 
			CourseGrade.LetterGradeId = l.LetterGradeId and 
			CourseGrade.CourseId	  = @CourseId              and 
			CourseGrade.GradeValue    <= @gradeValue
		ORDER BY 
			CourseGrade.GradeValue DESC;

SELECT * FROM CourseGrade
SELECT * FROM LetterGrades
