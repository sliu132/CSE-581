SELECT * FROM CourseEnrollment

--Test CourseId
EXEC dbo.Lab12ModifyTransactionTest @facultyId = '16-',@studentId = '', @newGrade = '',@courseId = '12';

--Test FacultyId
EXEC dbo.Lab12ModifyTransactionTest @facultyId = '16-Rhagri',@studentId = '', @newGrade = 0 ,@courseId = '1';

--Test StudentId
EXEC dbo.Lab12ModifyTransactionTest @facultyId = '16-Rhagrid',@studentId = '', @newGrade = 0,@courseId = '1';

UPDATE CourseEnrollment SET FinalGrade = 61 WHERE EnrollementId = 3
UPDATE CourseEnrollment SET FinalGrade = 61 WHERE EnrollementId = 5

--Test Student FindalGrade is exist
EXEC dbo.Lab12ModifyTransactionTest 
@facultyId = '16-Rhagrid',
@studentId = '03-HJGranger', 
@newGrade = 70 ,
@courseId = '1';

SELECT * FROM CourseEnrollment WHERE CourseId='1'

--Test Student grade change success
EXEC dbo.Lab12ModifyTransactionTest 
@facultyId = '16-Rhagrid',
@studentId = '01-HJPotter', 
@newGrade = 70 ,@courseId = '2';
