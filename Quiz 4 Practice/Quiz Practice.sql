
--Function Ungraded Practice
SELECT u.FirstName +' ' +u.LastName,COUNT(*)
FROM CourseEnrollment ce , Courses c, Users u
WHERE ce.CourseId = c.CourseId AND c.Faculty = u.NTID
GROUP BY 
	u.FirstName +' ' +u.LastName;


--Error Handling
SELECT * FROM Courses WHERE Facutly = '11-Fflitwick';

SELECT * FROM CourseEnrollment;
