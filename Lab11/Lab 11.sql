---- Author LIU,SHOU YUNG
-- Date:10/17/2015
-- Purpose: CSE Lab11 Views

--1. 1.	Create a view that will display all of the following columns, joining tables as appropriate: 
--a)	Student First Name
--b)	Student Last Name
--c)	Course Title

CREATE VIEW StudentEnrollment ([StudentFirstName],[Student LastName],[Course Title])
AS
SELECT Users.FirstName, Users.LastName ,Courses.CourseTitle
FROM Users, Courses,CourseEnrollment
WHERE
	CourseEnrollment.CourseId = Courses.CourseId and 
    CourseEnrollment.StudentId = Users.NTID;

--2.	Create a view that will display all of the following columns, joining tables as appropriate:
--a.	Student First Name
--b.	Student Last Name
--c.	Course Title
--d.	Course Faculty First Name
--e.	Course Faculty Last Name
--f.	Final Grade (number)
CREATE VIEW CourseEnrollmentWithGrade 
	([Student FirstName],[Student LastName],[Course Title],
	[Faculty FirstName],[Faculty LastName],[Grade])
AS
	SELECT 
			u.FirstName,u.LastName, c.CourseTitle, p.FirstName,
			p.LastName,e.FinalGrade
		FROM CourseEnrollment e, Courses c, Users u,Users p
		WHERE 
			e.CourseId = c.CourseId and  
			e.StudentId = u.NTID and
			c.Faculty = p.NTID;

--3.	Select data from the 2nd view, for Harry’s classes only
SELECT * 
	FROM CourseEnrollmentWithGrade
	WHERE [Student FirstName] = 'Harry';




