--Project 2 Test Store Procedure Script
--Date:2015/11/18
--Author:Liu,Shou Yung

--1. Test SP I RegisterNewStudent
DECLARE @dte AS DATETIME
SET @dte = GetDate();
EXEC dbo.RegisterNewStudent
	@studentId = 309866353, @firstName = '123', @lastName = 'LIU',
	@SSN = null,@dateOfBirth = @dte,
	@city = 'Syracuse',
	@address1 = '888 University Ave',@address2 = null,
	@zipCode = '13210',
	@sStatus ='graduate',
	@college = 'LCS College of Engineering & Computer Science',
	@stateName = 'New York'

--2. Test SP procedure II EnrollStudentInCourse
EXEC dbo.EnrollStudentInCourse 
	@studentId = '309866353', @cCode = 'CIS', @cNumber = 675, @enrollStatus = 'Regular',
	@year = 2015 ,@termName = 'fall'

	SELECT * FROM Enrollments
	SELECT * FROM CourseSchedule

SELECT * 
	FROM Courses c, CoursePrerequisiteList cp
	WHERE c.CourseId = cp.CourseId AND c.courseId = 1;
SELECT * FROM Courses

--3. Test FUNCTION I VerifyCoursePrerequisite
SELECT dbo.VerifyCoursePrerequisite (1, 'M00001-Angel')
SELECT dbo.VerifyCoursePrerequisite (3, 'M00001-Angel')

--4. Test SP III UpdateClassroomSeats
SELECT * 
	FROM CourseSchedule cs, Classrooms cl
	WHERE 
		cs.RoomId = cl.RoomId AND 
		ScheduleId = 1
UPDATE CourseSchedule SET OpenSeats = 60 WHERE ScheduleId = 1; 

EXEC dbo.UpdateClassroomSeats @courseScheduleId = 1,@usedSeats = -1;

EXEC dbo.UpdateClassroomSeats @courseScheduleId = 10,@usedSeats = -1;

EXEC dbo.UpdateClassroomSeats @courseScheduleId = 1,@usedSeats = -60;

