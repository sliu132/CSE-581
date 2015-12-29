
--Test CourseId
EXEC dbo.UpdateOrInsertStudentCourseGrade @facultyId = '16-',@studentId = '', @newGrade = '',@courseId = '12';

--Test FacultyId
EXEC dbo.UpdateOrInsertStudentCourseGrade @facultyId = '16-Rhagri',@studentId = '', @newGrade = 0 ,@courseId = '1';

--Test StudentId
EXEC dbo.UpdateOrInsertStudentCourseGrade @facultyId = '16-Rhagrid',@studentId = '', @newGrade = 0,@courseId = '1';

--Test Student FindalGrade is exist
EXEC dbo.UpdateOrInsertStudentCourseGrade @facultyId = '16-Rhagrid',@studentId = '01-HJPotter', @newGrade = 60 ,@courseId = '1';

--Test Student is not grade
EXEC dbo.UpdateOrInsertStudentCourseGrade @facultyId = '16-Rhagrid',@studentId = '01-HJPotter', @newGrade = 70 ,@courseId = '2';

--Test Return Join Table with various variable
EXEC dbo.GetFacultyTeachingClassWithEnrollStudent @facultyId='$',@courseId = 1;

--Test Return Join Table with various variable
EXEC dbo.GetFacultyTeachingClassWithEnrollStudent @facultyId='1',@courseId = 0;

DROP PROCEDURE dbo.GetFacultyTeachingClassWithEnrollStudent;

DROP PROCEDURE dbo.UpdateOrInsertStudentCourseGrade;
