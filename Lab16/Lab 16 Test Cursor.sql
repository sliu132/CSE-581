-- Date:11/9/2015
-- Purpose: CSE Lab15 
-- Function Test Cursor
SELECT dbo.calculateStudentGrade ('01-HJPotter')

--Interesting thing, System Function would ignore the NULL VALUE
SELECT  AVG(FinalGrade) FROM CourseEnrollment WHERE StudentId ='01-HJPotter'

SELECT * FROM CourseEnrollment

INSERT INTO CourseEnrollment (StudentId,CourseId,FinalGrade)
VALUES ('01-HJPotter', 1, NULL)


