-- Project 2 Step 3 Create View
-- Date: 2015/11/17
--1. View-StudentCourseEnrollment
IF OBJECT_ID ('StudentCourseEnrollment','V') IS NOT NULL
	DROP VIEW dbo.StudentCourseEnrollment;
GO
CREATE VIEW dbo.StudentCourseEnrollment 
AS 
	SELECT  si.StudentId							AS 'SutentId', 
			ps.FirstName	+' '+ ps.LastName		AS 'Student Name',
			es.StatusName							AS 'Status', 
			c.CourseTitle							AS 'Course Name', 
			p.FirstName		+' '+	p.LastName		AS 'Instructor',
			g.GradeName								AS 'Grade'
		FROM 
			Enrollments			en,EnrollmentStatus	es,Grade	g,Courses c,
			StudentInformation	si,CourseSchedule	cs,People	p,People ps
			
		WHERE 
			en.EnrollmentStatus = es.StatusId	AND 
			en.Grade			= g.GradeId		AND
			en.ScheduleId		= cs.ScheduleId AND
			en.StudentNTID		= si.NTID		AND
			cs.InstructorNTID	= p.NTID		AND
			cs.CourseId			= c.CourseId	AND
			si.NTID				= ps.NTID;
--2. View-CourseScheduleDetail
IF OBJECT_ID ('CoursesScheduleDetail','V') IS NOT NULL
	DROP VIEW dbo.CoursesScheduleDetail;
GO
CREATE VIEW dbo.CoursesScheduleDetail
AS
	SELECT	si.[Year]		+' '+st.[Name]									AS	'Term Type',
			c.CourseCode	+' '+CAST(c.CourseNumber AS VARCHAR(10))		AS	'Course Number',
			c.CourseTitle													AS	'Course Name',
			p.FirstName		+' '+p.LastName									AS	'Instructor',
			dw.[Day]		+' '+cm.CourseStartTime +'-'+cm.CourseEndTime	AS	'Meeting Time',
			b.BuildingName	+' '+CAST(cl.RoomNumber	AS VARCHAR(20))			AS	'Location'
		FROM 
			CourseSchedule	cs,	CourseMeetingList	cm, Courses			c, 
			[DayOfWeek]		dw, SemesterInformation si,	SemesterTerms	st,
			Classrooms		cl,	People				p,	Buildings		b
		WHERE 
			cs.SemesterInformation	= si.SemesterInfoId	AND
			si.SemesterTerm			= st.TermId			AND
			cs.RoomId				= cl.RoomId			AND
			cs.CourseMeetingTime	= cm.MeetingListId	AND
			cm.[DayOfWeek]			= dw.WeekDayId		AND 
			cs.CourseId				= c.CourseId		AND
			cs.InstructorNTID	    = p.NTID			AND
			cl.Building				= b.BuildingId;

--3. View-StudentContactInformation Get Student Detail Information
IF OBJECT_ID ('StudentContactInformation','V') IS NOT NULL
	DROP VIEW dbo.StudentContactInformation;
GO
CREATE VIEW dbo.StudentContactInformation
AS 
	SELECT 
		p.FirstName +' '+ p.LastName		AS 'Student Name',
		st.StudentId						AS 'Student Identiy',
		ss.StatusName						AS 'Student Status',
		a.Street1 +','+ 
		CAST (CASE 
			WHEN a.Street2 IS NULL 
				THEN '' END AS VARCHAR(1)) + 
			','+ cas.City+',' +s.StateName	AS 'Address',
		co.CollegeName						AS 'College',
		CAST(CASE 
			WHEN sm.IsMajor =1	
				THEN	'Major' 
			ELSE	'Minor' 
			END AS VARCHAR(10))				AS 'Major or Minor'
	FROM 
		StudentInformation			st, People			p,	StudentStatus ss,
		StudentMajorAndMinorList	sm, College			co,	PeopleAddrresList pa,
		[Address]					a,	CityAndState	cas,[State] s
	WHERE
		st.NTID			= p.NTID		AND 
		st.[Status]		= ss.StatusId	AND
		sm.NTID			= st.NTID		AND
		sm.CollegeId	= co.CollegeId	AND
		p.NTID			= pa.NTID		AND
		pa.AddressId	= a.AddressId	AND 
		a.ZipCode		= cas.ZipCode	AND
		S.StateId		= cas.[State]

--4. View-EmployeeInformation
IF OBJECT_ID ('EmployeeInformationDetail','V') IS NOT NULL
	DROP VIEW dbo.EmployeeInformationDetail;
GO
CREATE VIEW dbo.EmployeeInformationDetail
AS
	SELECT 
			ei.NTID				AS	'NTID', 
			ei.EmployeeId		AS	'Employee Id', 
			ei.YearlyPay		AS	'Salary', 
			ji.Title			AS	'Employee Title',
			IIF (ji.IsUnion = 1,'YES','NO')	
								AS	'Union', 
			eb.TotalCost		AS	'Benefits Cost',
			bc.SelectionName	AS	'Benefits Selection', 
			bt.TypeName			AS	'Benefits Type'	,
			bi.ItemCost			AS	'Original Cost'
	FROM 
		People				p,	EmployeeInformation		ei,EmployeeBenefits eb,JobInformation ji, 
		BenefitsInformation bi,	BenefitsCostSelection	bc,BenefitsType		bt
	WHERE
		p.NTID						= ei.NTID					AND 
		ei.NTID						= eb.NTID					AND 
		bi.CostType					= bt.TypeId					AND 
		ei.JobType					= ji.JobId					AND
		eb.BenefitsInformationId	= bi.BenefitsInformationId	AND
		bi.CostSelection			= bc.BenefitsCostId;



