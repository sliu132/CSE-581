---- Author LIU,SHOU YUNG
-- Date:10/27/2015
-- Purpose: CSE Lab12 Store procedure

--1. Return Join Two Table
CREATE PROCEDURE dbo.GetFacultyTeachingClassWithEnrollStudent (@facultyId AS VARCHAR(20), @courseId AS INT)
AS 
SELECT Courses.CourseId, Courses.CourseCode, Courses.CourseTitle,Courses.Faculty,Courses.OpenSeats,
		CourseEnrollment.EnrollementId,CourseEnrollment.StudentId,CourseEnrollment.FinalGrade

FROM CourseEnrollment, Courses
WHERE
	 Courses.CourseId = CourseEnrollment.CourseId and 
	 (Courses.Faculty LIKE  '%'+ @facultyId +'%' or Courses.CourseId = @courseId)
ORDER BY
	Courses.CourseId;


