---- Author LIU,SHOU YUNG
-- Date:11/21/2015
-- Purpose: CSE Lab18 Transaction
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
-- Use transaction to update change
-- If all students are graded, then calculate average
-- IF the grade too low, then roww back the insert value
IF OBJECT_ID ('dbo.Lab12ModifyTransactionTest','P') IS NOT NULL
	DROP PROCEDURE dbo.Lab12ModifyTransactionTest;
GO

CREATE PROCEDURE dbo.Lab12ModifyTransactionTest 
	(@facultyId AS VARCHAR(20), @studentId AS VARCHAR(20), 
	@newGrade AS INT, @courseId AS INT) AS
DECLARE @enrollementStudentId	AS VARCHAR(20) 
DECLARE @teachingFacultyId		AS VARCHAR(20)
DECLARE @oldGradedValue			AS INT = 0
DECLARE @enrollmentId			AS INT = 0
DECLARE @count					AS INT = 0
DECLARE @avgGrade				AS INT = 0
DECLARE @gradeCountAfterInsert  AS INT = 0
-- Storeprocedure Argument
	-- Check input argument is not empty
	BEGIN TRANSACTION TransTest;

	SELECT @count = Count(*) 
		FROM COURSES 
		WHERE CourseId = @courseId
	IF @count <> 0
		BEGIN
			-- 1. Confirm faculty is teaching the course.
			SELECT @teachingFacultyId = Courses.Faculty   
			FROM Courses
			WHERE CourseId = @courseId 
			IF (@teachingFacultyId  <> @facultyId)
				BEGIN
					PRINT ('Error: You are not allow to assign grades for this class')
					ROLLBACK TRANSACTION TransTest;
				END
			ELSE 
			--2.Confirm student enrolled in the class.
				BEGIN
					SELECT 
						@enrollmentId = CE.EnrollementId,
						@oldGradedValue = CE.FinalGrade
					FROM 
						CourseEnrollment CE
					WHERE 
						CE.StudentId = @studentId AND 
						CE.CourseId =@courseId 
				IF @enrollmentId > 0
					BEGIN
						-- 3.Confirm student final grade value 
						IF	@oldGradedValue >0
							-- c.If oldgradeValue > 0 means course has been graded, Update CourseEnrollment
							BEGIN
								-- Update CouseEnrollment
								UPDATE CourseEnrollment
									SET FinalGrade = @newGrade
									WHERE EnrollementId = @enrollmentId AND StudentId = @studentId
								PRINT ('Success, warning - Student’s existing grade '+ CAST(@oldGradedValue AS VARCHAR(10))
									+' was changed to ' + CAST(@newGrade AS VARCHAR(20)))
							END
						ELSE 
							--d. If oldgradeValue = 0 means course has not grade yet, then insert new grade into CourseEnrollment
							BEGIN
								-- Update CouseEnrollment
								UPDATE CourseEnrollment
									SET FinalGrade = @newGrade
									WHERE 
									EnrollementId = @enrollmentId AND 
										StudentId = @studentId
								PRINT ('Success')
							END
						-- Calculate Average
						SELECT @count = COUNT(1) FROM CourseEnrollment 
									WHERE CourseId = @courseId; 

						SELECT @gradeCountAfterInsert = COUNT(1) 
							FROM CourseEnrollment 
									WHERE  
										  CourseId = @courseId AND
										   FinalGrade IS NOT NULL;

						IF @count = @gradeCountAfterInsert
							BEGIN
										SELECT @avgGrade = AVG (FinalGrade) 
											FROM CourseEnrollment 
											WHERE  
												CourseId = @courseId;

									IF @avgGrade < 50
										BEGIN
											PRINT ('Error:Your grade average is too low,please check the grades to make sure you have inserted the correct value');
											ROLLBACK TRANSACTION TransTest;
										END
									ELSE
										BEGIN
											PRINT 'Average Grade is :'+CAST (@avgGrade AS VARCHAR(10))
											COMMIT TRANSACTION TransTest;
										END
									END		
						ELSE 
								BEGIN
										PRINT('The student has courses not graded yet.');
										ROLLBACK TRANSACTION TranTest;
									END
								
					END	
				ELSE
					BEGIN
						PRINT('Error: The student is not taking the course you specified.')
						ROLLBACK TRANSACTION TransTest;
					END
			END
		END
	ELSE
		BEGIN
			PRINT ('The courseId you input is not exist')
			ROLLBACK TRANSACTION TransTest;
		END;

	
