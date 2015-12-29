---- Author LIU,SHOU YUNG
-- Date:10/27/2015
-- Purpose: CSE Lab11 Views
--1.	Create a stored procedure. Input for the stored procedure will be FacultyId, Student Id, Course Id and a Numerical Grade. 
--		The stored procedure will attempt to assign a grade to the student, 
--		for the class that they are enrolled in, 
--		assuming it is legal to do so. 
--		The stored procedure will do the following
--a)	If the user attempting to assign the grade (FacultyId) is not the faculty teaching the course, print a message that says “Error: You are not allowed to assign grades for this course.”, and quit.
--b)	Assuming A passed, and if the student is not enrolled in the class, print a message that says “Error: The student is not taking the course you specified.”, and quit.
--c)	Assuming B passed, and if the student already has a grade for that class, change it to the new grade, and print a message that says 
--					“Success, with a warning - Student’s existing grade OLD_GRADE was changed to NEW_GRADE.” 
--					Please replace the OLD_GRADE with the existing grade, and the NEW_GRADE with the new grade. Then quit.
--d)	Assuming B passed and C did not execute (the student does not have a grade for the course yet)
--					insert the new grade and print a message “Success.”,
-- then quit.
CREATE PROCEDURE dbo.AddGrade 
	(@facultyId AS VARCHAR(20), @studentId AS VARCHAR(20), 
	 @courseId AS INTEGER,		@gradeValue AS INTEGER) AS

DECLARE @finalGrade AS INT = 0
DECLARE @enrollementStudentId AS VARCHAR(20)
DECLARE @teachingFacultyId  AS VARCHAR(20)
DECLARE @oldGradeValue AS INT = 0
DECLARE @courseGradedId AS INT = 0
DECLARE @enrollmentId AS INT = 0

SELECT  @enrollmentStudentId = CourseEnrollment.StudentId,
		@finalGrade = CourseEnrollment.FinalGrade,
		@teachingFacultyId = Course.Fauculty, 
		@courseGradedId = CourseGradeId,
		@enrollmentId = CourseEnrollment.EnrollmentId
	FROM CourseEnrollment , Courses ,CourseGrade
	WHERE 
		CourseEnrolment.CourseId = @courseId and 
		Courses.CourseId = @courseId and 
		CourseGrade.CourseId = @courseId and CourseGrade.LetterGradedId = EnrollmentId and
		Courses.FacultyId = @facultyId and CourseEnrollment.StudentId = @studentId
	IF @teachingFacultyId = @facultId 
		BEGIN
			IF	@enrollmentStudentId = @studentId
				BEGIN
					IF	@finalGrade >0
						BEGIN
							UPDATE CourseEnrollment
								SET FinalGrade = @gradeValue
								WHERE StudentId = @studentid
							UPDATE CourseGrade
								SET GradeValue = @gradeValue
								WHERE GradingScaleId = courseGradedId
							PRINT ('Success, with a warning - Student’s existing grade'+@finalGrade+'was changed to' +@gradeValue +'.')
							PRINT ('Please replace the OLD_GRADE with the existing grade, and the NEW_GRADE with the new grade')
						END
					ELSE
						BEGIN
							INSERT INTO CourseGrade(LEtterGradedId,CourseId,GradeValue)
							VALUES(@enrollmentId,@courseId,@gradeValue)
							PRINT('Success')
						END
				END
			ELSE
				BEGIN
					PRINT('The student is not taking the course you specified')
				END
		END
	ELSE
		BEGIN
			PRINT ('Error:You are not allow to assign grades for this class')
		END

Select * from Courses;
Select * from CourseEnrollment;
Select * from CourseGrade;