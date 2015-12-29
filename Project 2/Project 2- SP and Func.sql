-- Project 2 Step 4 Store Procedure and Function
-- Date: 2015/11/17
--1. SP I RegisterNewStudent
-- Argument: FirstName, LastName, StudentId,Status,DateOfBirth, 
-- Address1,Address2, City, State,ZipCode
-- Check Argument Valid
-- Register Student
IF OBJECT_ID('dbo.RegisterNewStudent','P') IS NOT NULL
	DROP PROCEDURE dbo.RegisterNewStudent;
GO
CREATE PROCEDURE dbo.RegisterNewStudent 
		(@studentId	AS VARCHAR(10) ,@firstName	 AS VARCHAR(30), @SSN		AS VARCHAR(10),
		 @lastName	AS VARCHAR(30) ,@dateOfBirth AS DateTime,	 @city		AS VARCHAR(30),
		 @address1  AS VARCHAR(200),@address2	 AS VARCHAR(200),@zipCode	AS VARCHAR(10),
		 @sStatus	 AS VARCHAR(20),@college	 AS VARCHAR(200),@stateName	AS VARCHAR(30))
AS
	BEGIN 
		-- 1. Verify argument Check Student does not resigter yet.
			IF	EXISTS(SELECT TOP(1)* FROM StudentInformation WHERE StudentId = @studentId)
				BEGIN
					PRINT ('Student is Exists: '+@studentId);
					PRINT ('Please check student Info!');
				END 
			ELSE IF NOT EXISTS (SELECT TOP(1)* FROM [State] WHERE StateName = @stateName)
				BEGIN
					PRINT ('Please verify StateName:'+ @stateName);
				END
			ELSE IF NOT EXISTS (SELECT TOP(1)* FROM StudentStatus WHERE StatusName = @sStatus)
					BEGIN
						PRINT ('Please verify Student Status :'+ @sStatus);
					END
			ELSE IF NOT EXISTS (SELECT TOP(1)* FROM College WHERE CollegeName = @college)
				BEGIN
					PRINT ('PLease verify College Name:'+ @college);
				END
			ELSE
				BEGIN
					DECLARE @newNTID			AS VARCHAR(30) = LEFT(NEWID(),(30))
					DECLARE @dob				AS VARCHAR(10)
					DECLARE @studentStatusId	AS INT 
					DECLARE @collegeId			AS VARCHAR(10) 
					DECLARE @isActive			AS BIT = 1
					DECLARE @stateId			AS VARCHAR(2)
					DECLARE @addId				AS INT
					SELECT @dob = FORMAT(@dateOfBirth,'dd/MM/yyyy','en-US');
					SELECT @studentStatusId = StatusId	FROM StudentStatus	WHERE	StatusName	= @sStatus
					SELECT @collegeId		= CollegeId	FROM College		WHERE	CollegeName	= @college
					SELECT @stateId			= StateId	FROM [State]		WHERE   StateName = @stateName
					-- 2. Register Student
					INSERT INTO People(NTID,FirstName,LastName,SSN,IsActive)
						VALUES (@newNTID,@firstName,@lastName,@SSN,@isActive)

					INSERT INTO StudentInformation (NTID,StudentId,[Password],DateOfBirth,[Status])
						VALUES (@newNTID,@studentId,@studentId,@dob,@studentStatusId)
					
					INSERT INTO StudentMajorAndMinorList (CollegeId,NTID,IsMajor)
						VALUES (@collegeId,@newNTID,1)
					
					IF NOT EXISTS(SELECT TOP(1)* FROM CityAndState WHERE ZipCode = @zipCode )
						BEGIN
							INSERT INTO CityAndState (ZipCode,City,[State])
								VALUES (@zipCode,@city,@stateId)		
						END
					INSERT INTO [Address] (Street1,Street2,ZipCode)
						VALUES (@address1,@address2,@zipCode)
					SELECT @addId = @@IDENTITY ;

					INSERT INTO PeopleAddrresList(AddressId,NTID)
						VALUES (@addId,@newNTID)

					PRINT ('Regier Student "'+ @firstName +' '+ @lastName +'" Success !')
			END
	END; 
--2. Sp II- EnrollStudentInCourse
-- Argument:StudentId, CourseId, Year, Term
-- Step 1.Check Student Status is Active
-- Step 2.Check the CourseId is in CourseSchedule
-- Step 3.Check CoursePrerequisite
-- Step 4.Enroll Student
-- Step 4.1 Check Classroom Seats
IF OBJECT_ID('dbo.EnrollStudentInCourse','P') IS NOT NULL
	DROP PROCEDURE dbo.EnrollStudentInCourse;
GO
CREATE PROCEDURE dbo.EnrollStudentInCourse
	(@studentId AS VARCHAR(10), @cCode AS VARCHAR(10), @enrollStatus AS VARCHAR(30),
	@cNumber AS INT, @year AS VARCHAR(10),@termName AS VARCHAR(20))
AS
	BEGIN
		DECLARE @newNTID	AS VARCHAR(30) = NULL
		DECLARE @term		AS VARCHAR(20) = NULL
		DECLARE @isActive	AS BIT 
		DECLARE	@statusId	AS INT = 0
		DECLARE @courseId	AS INT = 0
		DECLARE @scheduleId AS INT = 0
		DECLARE @gradeId	AS INT = 0
		-- Verify Status Term 
		SELECT		@statusId = StatusId 
			FROM	EnrollmentStatus 
			WHERE	StatusName = @enrollStatus
		--Verify Student Status
		SELECT @newNTID = p.NTID,  
				@isActive= p.IsActive
			FROM  Studentinformation si , People p 
			WHERE 
				p.NTID = si.NTID AND 
				si.StudentId = @studentId
		--Verify Course 
		SELECT  @courseId = CourseId
			FROM	Courses
			WHERE 
				CourseCode = @cCode AND 
				CourseNumber = @cNumber
		IF @newNTID IS NULL OR @isActive = 0
			BEGIN
				PRINT ('Student is not "Activate", please check with student office"');
			END
		ELSE IF @statusId = 0
			BEGIN
				PRINT ('Please verify the status " '+ @enrollStatus +' "!');
			END 
		ELSE IF @courseId = 0
			BEGIN
				PRINT ('Please verify the Course, " '+ @cCode +' '+ CAST(@cNumber AS VARCHAR(10)) +' "!');
			END
		ELSE
			BEGIN
				--Verify Course Schedule
				SELECT @scheduleId = ScheduleId
					FROM 
					CourseSchedule cs, SemesterInformation si,
					Semesterterms  st, CoursemeetingList cm	 ,[DayOfWeek] dw 
				WHERE  
					cs.CourseMeetingTime = cm.MeetingListId		AND 
					cm.[DayOfWeek] = dw.WeekDayId				AND
					cs.SemesterInformation = si.SemesterInfoId	AND
					si.SemesterTerm = st.TermId					AND
					st.Name = @termName							AND 
					si.[Year] = @year							AND 
					cs.CourseId = @courseId
				IF @scheduleId = 0
					BEGIN 
						PRINT ('Please verify enroll course information, We could not find the opening Course');
						PRINT ('Couse Code: '		+ @cCode )
						PRINT ('Course Number: '	+ CAST (@cNumber AS vARCHAR(10)))
						PRINT ('Semester Terms: '	+ @termName)
						PRINT ('Year:'				+ @year);
					END
				ELSE
					BEGIN
						--Verify Enrollment record
						IF EXISTS (SELECT TOP(1)* FROM Enrollments
							WHERE ScheduleId = @scheduleId and StudentNTID = @newNTID)
							BEGIN
								PRINT('Student Already enroll this Courses');
							END
						ELSE
							BEGIN
								SELECT @gradeId = GradeId 
									FROM Grade 
									WHERE GradeName= 'N'
								INSERT INTO Enrollments (Grade,EnrollmentStatus,ScheduleId,StudentNTID)
									VALUES (@gradeId,@statusId,@scheduleId,@newNTID)
								PRINT	('Enroll course'+ @cCode+' '+CAST (@cNumber AS VARCHAR(10)) + 'Success');
							END
					END
			END
	END;

--3. Procedure III-UpdateClassroomSeats
-- Argument: RoomNumber, CourseId,CourseSchedule Id, Seats number
-- Return Success or Fail
-- Step 1. If can't find the course schedule then return "fail"-error message
-- Step 2. If schedule open seats count more then maxium seats, show "fail" -seats not enough
-- Step 3. If openseats smaller then 0, then set the seats to zero
-- Step 4. ELSE show success 
IF OBJECT_ID ('dbo.UpdateClassroomSeats','P') IS NOT NULL
	DROP PROCEDURE dbo.UpdateClassroomSeats;
GO
CREATE PROCEDURE dbo.UpdateClassroomSeats ( @courseScheduleId AS INT, @usedSeats AS INT)
AS
	BEGIN
		DECLARE @result				AS VARCHAR(200) = NULL
		DECLARE @originalOpenSeats	AS INT = 0;
		DECLARE @updateSeats		AS INT = 0;
		DECLARE @maximumSeats		AS INT = 0;
		DECLARE @courseCount		AS INT = 0;
		SELECT  @courseCount = COUNT(1) 
			FROM  CourseSchedule 
			WHERE ScheduleId = @courseScheduleId 
			IF @courseCount = 0
				BEGIN 
					SET @result = 'Fail- No such course schedule'
				END
			ELSE
				BEGIN
					SELECT  @originalOpenSeats	= OpenSeats, 
							@maximumSeats		= MaximumSeats
					FROM	CourseSchedule cs,	Classrooms cl
					WHERE 
						cs.RoomId	  = cl.RoomId		AND 
						cs.ScheduleId = @courseScheduleId
					SET @updateSeats  = @originalOpenSeats + @usedSeats
					IF @updateSeats > @maximumSeats 
						BEGIN
						-- open seats = maximumseats
							SET  @updateSeats = @maximumSeats;
						END
					ELSE IF @updateSeats < 0
						BEGIN
							SET @updateSeats = 0;
						END
					ELSE
						BEGIN
							SET @result = 'Fail- logic error'
						END
					UPDATE	CourseSchedule 
					SET		OpenSeats =  @updateSeats 
					WHERE	ScheduleId = @courseScheduleId
					SET @result = 'Success, Seats count set to '+CAST (@updateSeats AS VARCHAR(10)) +'.'
				END
			PRINT @result
	END;
--4. FUN I -VerifyCoursePrerequisite
-- Argument:CourseId,Student 
-- return: VARCHAR(200)-Result
-- If the course has no prerequisite then return NULL
-- If the course has prerequisite then check student has enrolled in the class or not?
-- If student has already took the class, then he has the permission to enroll, otherwise return "Prerequisite course list"
IF OBJECT_ID ('dbo.VerifyCoursePrerequisite','FN') IS NOT NULL
	DROP FUNCTION dbo.VerifyCoursePrerequisite;
GO
CREATE FUNCTION dbo.VerifyCoursePrerequisite (@courseId AS INT,@studentNTID AS VARCHAR(30))
RETURNS VARCHAR(200)AS
	BEGIN
	DECLARE @result AS VARCHAR(200) = NULL
	DECLARE @preCourseId AS INT = 0
	DECLARE @scheduleId AS INT
	DECLARE @enrollPassedCount AS INT = 0
	DECLARE @preCourseCount AS INT = 0
		SELECT	@preCourseId = PreCourseId 
			FROM Courses c, CoursePrerequisiteList cp 
			WHERE c.CourseId = cp.CourseId AND c.courseId = @courseId;
		IF(@preCourseId = 0 )
			BEGIN
				RETURN @result;
			END
		ELSE
			BEGIN
				SET  @preCourseCount = (SELECT	COUNT(1) 
											FROM Courses c, CoursePrerequisiteList cp 
											WHERE c.CourseId = cp.CourseId AND c.courseId = @courseId)
				SELECT @enrollPassedCount = Count(*) 
					FROM Enrollments s, CourseSchedule cs,Grade g
					WHERE 
						s.ScheduleId = cs.ScheduleId	AND 
						s.Grade = g.GradeId				AND
						s.StudentNTID = @studentNTID	AND 
						cs.CourseId = @preCourseId		AND
						g.GradeName IN ('A','B','C')
				IF (@preCourseCount <> @enrollPassedCount)
					-- Not pass all the prerequisite
					BEGIN
						SET @result = 'The student are not passed all the prerequisite';
					END
			END
		RETURN @result;
	END;	