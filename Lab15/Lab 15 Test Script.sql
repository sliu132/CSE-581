-- Date:11/9/2015
-- Purpose: CSE Lab15 
-- Function Test Trigger

SELECT * FROM CourseEnrollment
WHERE StudentId = '01-HJPotter'

SELECT * FROM Courses

INSERT INTO CourseEnrollment(StudentId, CourseId)
VALUES ('01-HJPotter',3);

DELETE CourseEnrollment
WHERE EnrollementId = 10;

UPDATE CourseEnrollment 
SET CourseId = 3
WHERE StudentId ='01-HJPotter'  and CourseId = 2;




