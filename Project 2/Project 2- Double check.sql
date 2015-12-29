-- Double Check before the Submit
-- 2015/12/10
-- LIU
CREATE DATABASE sliu132Database2 ;
CREATE TABLE [State](
	StateId				CHAR(2)				PRIMARY KEY,
	StateName				VARCHAR(30)			NOT NULL
);
CREATE TABLE CityAndState(
	ZipCode				CHAR(10)				PRIMARY KEY,
	City					VARCHAR(30)			NOT NULL,
	[State]				CHAR(2)				FOREIGN KEY REFERENCES [State](StateId)
);
CREATE TABLE [Address](
	AddressId				INT IDENTITY(1,1)		PRIMARY KEY,
	Street1				VARCHAR(200)			NOT NULL,
	Street2				VARCHAR(200),
	ZipCode				CHAR(10)				NOT NULL FOREIGN KEY REFERENCES CityAndState(ZipCode)
);
CREATE TABLE People(
	NTID					VARCHAR(30)			PRIMARY KEY,
	FirstName				VARCHAR(30)			NOT NULL,
	LastName				VARCHAR(30)			NOT NULL,
	SSN					CHAR(10)						,
	IsActive				BIT					NOT NULL
);
CREATE TABLE PeopleAddrresList(
	AddressId				INT					CONSTRAINT fk_Address_PeopleAddressList 
												FOREIGN KEY REFERENCES [Address](AddressId),
	NTID					VARCHAR(30)			CONSTRAINT fk_People_PeopleAddressList 
												FOREIGN KEY REFERENCES [People](NTID),
											CONSTRAINT pk_PeopleAddressList_Id 
												PRIMARY KEY(AddressId,NTID)
);
CREATE TABLE StudentStatus(
	StatusId				INT IDENTITY(1,1)		PRIMARY KEY,
	StatusName			VARCHAR(20)			NOT NULL,
	StatusDescription			VARCHAR(200)
);
CREATE TABLE StudentInformation(
	NTID					VARCHAR(30)			PRIMARY KEY CONSTRAINT fk_StudentInformation_People
												FOREIGN KEY REFERENCES People(NTID),
	StudentId				VARCHAR(10)			NOT NULL,
	[Password]				VARCHAR(200),
	DateOfBirth			VARCHAR(10),
	[Status]				INT					CONSTRAINT fk_StudentInformation_StudentStatus
												FOREIGN KEY REFERENCES StudentStatus(StatusId),
);
CREATE TABLE College(
	CollegeId				CHAR(5)				PRIMARY KEY,
	CollegeName			VARCHAR(200)			NOT NULL,
	CollegeDescription		VARCHAR(1000)
);
CREATE TABLE StudentMajorAndMinorList(
	ListId					INT IDENTITY(1,1)		PRIMARY KEY,
	CollegeId				CHAR(5)				CONSTRAINT fk_College_MajorAndMinorList 
												FOREIGN KEY REFERENCES College(CollegeId),
	NTID					VARCHAR(30)			CONSTRAINT fk_MajorAndMinorList_StudentInfo
												FOREIGN KEY REFERENCES StudentInformation(NTID),
	IsMajor				BIT 					NOT NULL
);
CREATE TABLE EnrollmentStatus(
	StatusId				INT IDENTITY(1,1)		PRIMARY KEY,
	StatusName			VARCHAR(30)			NOT NULL,
	StatusDescription			VARCHAR(200)			NOT NULL
);
CREATE TABLE Grade(
	GradeId				INT IDENTITY(1,1)		PRIMARY KEY,
	GradeName			VARCHAR(10)			NOT NULL
);

CREATE TABLE Courses(
	CourseId				INT IDENTITY(1,1)		PRIMARY KEY,
	CourseCode			CHAR(5)				NOT NULL,
	CourseNumber			INT					NOT NULL,
	CourseTitle				VARCHAR(50)			NOT NULL,
	CourseDescription		VARCHAR(200),
);
CREATE TABLE CoursePrerequisiteList(
	PreCourseListId			INT IDENTITY(1,1)		PRIMARY KEY,
	CourseId				INT					CONSTRAINT fk_Courses_CourseId 
												FOREIGN KEY REFERENCES Courses(CourseId),
	PreCourseId			INT					CONSTRAINT fk_Courses_PreCourseId
												FOREIGN KEY REFERENCES Courses(CourseId)
);
CREATE TABLE [DayOfWeek](
	WeekDayId			INT IDENTITY(1,1)		PRIMARY KEY,
	[Day]					VARCHAR(10)			NOT NULL
);
CREATE TABLE CourseMeetingList(
	MeetingListId			INT IDENTITY(1,1)		PRIMARY KEY,
	[DayOfWeek]			INT					NOT NULL CONSTRAINT fk_CourseMeetingDay
												FOREIGN KEY REFERENCES [DayOfWeek](WeekDayId),
	CourseStartTime			VARCHAR(10)			NOT NULL,
	CourseEndTime			VARCHAR(10)			NOT NULL
);
CREATE TABLE SemesterTerms(
	TermId				INT IDENTITY(1,1)		PRIMARY KEY,
	Name					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(200) 
);
CREATE TABLE SemesterInformation(
	SemesterInfoId			INT IDENTITY(1,1)		PRIMARY KEY,
	[Year]				VARCHAR(10)			NOT NULL,
	SemesterTerm			INT					NOT NULL 
											CONSTRAINT fk_SemesterTerms_Information
												FOREIGN KEY REFERENCES SemesterTerms(TermId),
	StartDate				VARCHAR(10)			NOT NULL,
	EndDate				VARCHAR(10)			NOT NULL
);
CREATE TABLE Buildings(
	BuildingId				INT IDENTITY(1,1)		PRIMARY KEY,
	BuildingName			VARCHAR(30)
);
CREATE TABLE Equipments(
	EquipmentId			INT IDENTITY(1,1)		PRIMARY KEY,
	Name					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(1000) 
);
CREATE TABLE Classrooms(
	RoomId				INT IDENTITY(1,1)		PRIMARY KEY,
	RoomNumber			SMALLINT			NOT NULL,
	MaximumSeats			TINYINT				NOT NULL,
	Building				INT					NOT NULL 
											CONSTRAINT fk_Classroom_Location
												FOREIGN KEY REFERENCES Buildings(BuildingId),
	Equipment				INT					CONSTRAINT fk_Classrooms_Equipment 
												FOREIGN KEY REFERENCES Equipments(EquipmentId),
	WhiteBoardCount		TINYINT				NOT NULL,
	OtherAVEquipment		INT					CONSTRAINT fk_Classrooms_EquipmentOtherAV 
												FOREIGN KEY REFERENCES Equipments(EquipmentId) 
);
CREATE TABLE CourseSchedule(
	ScheduleId				INT IDENTITY(1,1)		PRIMARY KEY,
	SemesterInformation		INT					NOT NULL
CONSTRAINT fk_Course_SemesterInformation
FOREIGN KEY REFERENCES SemesterInformation(SemesterInfoId),
	InstructorNTID			VARCHAR(30)			CONSTRAINT fk_Courseteaching_Instructor
												FOREIGN KEY REFERENCES People(NTID),
	CourseMeetingTime		INT 					NOT NULL
CONSTRAINT fk_Schedule_MeetingList 
												FOREIGN KEY REFERENCES CourseMeetingList(MeetingListId),
	CourseId				INT 					NOT NULL	
CONSTRAINT fk_Courses_Schedule
												FOREIGN KEY REFERENCES Courses(CourseId),
	RoomId				INT					CONSTRAINT fk_Couese_Room 
												FOREIGN KEY REFERENCES Classrooms(RoomId),
	OpenSeats				INT 					NOT NULL		CHECK(OpenSeats >=0 )
);
CREATE TABLE Enrollments(
	EnrollmentId			INT IDENTITY(1,1)		PRIMARY KEY,
	Grade				INT					CONSTRAINT fk_Enrollment_Student_Grade 
												FOREIGN KEY REFERENCES Grade(GradeId),
	EnrollmentStatus			INT					CONSTRAINT fk_Enrollment_Status 
												FOREIGN KEY REFERENCES EnrollmentStatus(StatusId),
	ScheduleId				INT					CONSTRAINT fk_Enrollment_CourseSchedule 
												FOREIGN KEY REFERENCES CourseSchedule(ScheduleId),
	StudentNTID			VARCHAR(30)			NOT NULL 
											CONSTRAINT fk_Enrollment_StudentNTID 
												FOREIGN KEY REFERENCES StudentInformation(NTID), 
);
CREATE TABLE JobInformation(
	JobId					INT IDENTITY(1,1)		PRIMARY KEY,
	Title					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(200),
	Requirements			VARCHAR(1000),
	MaximumPay			DECIMAL(10,2)			NOT NULL CHECK( MaximumPay >= 0.00 ),
	MinimumPay			DECIMAL(10,2)			NOT NULL CHECK( MinimumPay >= 0.00 ),
	IsUnion				BIT					NOT NULL
);
CREATE TABLE EmployeeInformation(
	NTID					VARCHAR(30)			PRIMARY KEY 
											CONSTRAINT fk_People_Employee 
												FOREIGN KEY REFERENCES People(NTID),
	EmployeeId			VARCHAR(10)			NOT NULL,
	YearlyPay				DECIMAL(10,2)			NOT NULL CHECK (YearlyPay >= 0.00),
	JobType				INT					CONSTRAINT	fk_Employee_JobType 
												FOREIGN KEY REFERENCES JobInformation(JobId)
);
CREATE TABLE BenefitsCostSelection(
	BenefitsCostId			INT IDENTITY(1,1)		PRIMARY KEY,
	SelectionName			VARCHAR(20)			NOT NULL
);
CREATE TABLE BenefitsType(
	TypeId				INT IDENTITY(1,1)		PRIMARY KEY,
	TypeName				VARCHAR(20)			NOT NULL
);
CREATE TABLE BenefitsInformation(
	BenefitsInformationId		INT IDENTITY(1,1)		PRIMARY KEY,
	CostSelection			INT					CONSTRAINT fk_Benefits_CostSelection
												FOREIGN KEY REFERENCES
														BenefitsCostSelection(BenefitsCostId),
	CostType				INT					CONSTRAINT fk_Benefits_Type 
												FOREIGN KEY REFERENCES BenefitsType(TypeId),
	ItemCost				DECIMAL(10,0)			NOT NULL CHECK(ItemCost >= 0.00)
);
CREATE TABLE EmployeeBenefits(
	NTID					VARCHAR(30)			NOT NULL 
											CONSTRAINT fk_EmployeeInformation_Benefits 
												FOREIGN KEY REFERENCES EmployeeInformation(NTID),
	BenefitsInformationId		INT					NOT NULL 
											CONSTRAINT fk_Employee_Benefits 
												FOREIGN KEY REFERENCES 
BenefitsInformation(BenefitsInformationId),
	TotalCost				DECIMAL(10,2)			NOT NULL,
											CONSTRAINT pk_EmployeeInformation_BenefitsInformation
											PRIMARY KEY(NTID, BenefitsInformationId)
);


-- Insert Data
INSERT INTO [State]	(StateId,StateName)
VALUES	
	  ('AL','Alaboma'			),	
		('AK','Alsaka'			),
		('AZ','Arizona'			),
		('AR','Arkansas'		),
		('CA','California'		),
		('CO','Colorado'		),
		('CT','Connecticut'		),
		('DE','Delaware'		),
		('FL','Florida'			),
		('GA','Georgia'			),
		('HI','Hawaii'			),
		('ID','Idaho'			),
		('IL','Illinois'		),
		('IN','Indinan'			),
		('IA','IOWA'			),
		('KS','Kansas'			),
		('KY','Kentucky'		),
		('LA','Louisana'		),
		('ME','Maine'			),
		('MD','Maryland'		),
		('MA','Massachusetts'	),
		('MI','Michigan'		),
		('MN','Minnesota'		),
		('MS','Mississippi'		),
		('MO','MIssouri'		),
		('MT','Montana'			),
		('NE','Nebraska'		),
		('NV','Nevada'			),
		('NH','New Hampshire'	),
		('NJ','New Jersey'		),
		('NM','New Mexico'		),
		('NY','New York'		),
		('NC','North Carolina'	),
		('ND','North Dakata'	),
		('OH','Ohio'			),
		('OK','Oklahoma'		),
		('OR','Oregon'			),
		('PA','Pennsylvania'	),
		('RI','Rhode Island'	),
		('SC','South Carolina'	),
		('SD','South Dakota'	),
		('TN','Tennessee'		),
		('TX','Texas'			),
		('UT','Utah'			),
		('VT','Vermont'			),
		('VA','Virginia'		),
		('WA','Washington'		),
		('WV','West Virginia'	),
		('WI','Wisconsin'		),
		('WY','Wyoming'			);
INSERT INTO CityAndState (ZipCode,City,[State])
VALUES 
	  ('36101','Montgomery'	,'AL'),
	  ('99801','Juneau'		,'AK'),
	  ('85001','Phoenix'		,'AZ'),
	  ('72201','Liitle Rock'		,'AR'),
	  ('94203','Sacramento'		,'CA'),
	  ('80201','Denver'		,'CO'),
	  ('06101','Hartford'		,'CT'),
	  ('19901','Dover'		,'DE'),
	  ('32301','Tallahassee'		,'FL'),
	  ('30301','Atlanta'		,'GA'),
	  ('96801','Honolulu'		,'HI'),
	  ('83701','Boise'			,'ID'),
	  ('62701','Springfield'		,'IL'),
	  ('46201','Indianapolis'	,'IN'),
	  ('50301','Des Moines'	,'IA'),
	  ('66601','Tpdeka'		,'KS'),
	  ('40601','Frankfort'		,'KY'),
	  ('70801','Baton Rouge'	,'LA'),
	  ('04330','Augusta'		,'ME'),
	  ('21401','Annapolis'		,'MD'),
	  ('02108','Boston'		,'MA'),
	  ('48901','Lansing'		,'MI'),
	  ('55101','St Paul'		,'MN'),
	  ('39201','Jaskson'		,'MS'),
	  ('65101','Jefferson City'	,'MO'),
	  ('59601','Helana'		,'MT'),
	  ('68501','Lincoln'		,'NE'),
	  ('89701','Carson City'	,'NV'),
	  ('03301','Concord'		,'NH'),
	  ('08601','Trenton'		,'NJ'),
	  ('87501','Santa Fe'		,'NM'),
	  ('12201','Albany'		,'NY'),
	  ('27601','Raleigh'		,'NC'),
	  ('58501','Bismarck'		,'ND'),
	  ('43201','Columbus'		,'OH'),
	  ('73101','Oklahoma City'	,'OK'),
	  ('97301','Salem'		,'OR'),
	  ('17101','Harrisburg'		,'PA'),
	  ('02901','Providence'		,'RI'),
	  ('29201','Columbia'		,'SC'),
	  ('57501','Pierre'			,'SD'),
	  ('37201','Nashville'		,'TN'),
	  ('73301','Austin'		,'TX'),
	  ('84101','Salt Lake City'	,'UT'),
	  ('05601','Montpelier'		,'VT'),
	  ('23218','Richmond'		,'VA'),
	  ('98501','Olympia'		,'WA'),
	  ('25301','Charleston'		,'WV'),
	  ('53701','Madison'		,'WI'),
	  ('82001','Cheyenne'		,'WY');
INSERT INTO Address (Street1,Street2,ZipCode)
VALUES 
	  ('3000 State University'	,null,'23218'),
	  ('925 H St'			,null,'98501'),
	  ('1000 H St'			,null,'98501'),
	  ('926 J St'			,null,'98501'),
	  ('1300 H St'			,null,'82001'),
	  ('90 tremont St'			,null,'82001'),
	  ('1 Court St'			,null,'53701'),
	  ('60 School St'			,null,'53701'),
	  ('15 Beacon St'			,null,'53701');
INSERT INTO People (NTID,FirstName,LastName,SSN,IsActive)
VALUES
	  ('M00001-Angel','Warren','Kenneth',		null,1),
	  ('M00002-A-Bomb','Richard','Milhouse',	null,1),
	  ('M00003-Black-Bolt','Blackagar','Boltagon',	null,1),
	  ('M00004-Lockjaw','Sparky','Nick',		null,1),
	  ('M00005-Blizzard','Gregor','Shapanka',	null,1),
	  ('M00006-Toro','thomas','Raymond',		null,1),
	  ('M00007-Banshee','Sean','Cassidy',		null,1),
	  ('M00008-X Prof','Charles','Xavier',		null,1),
	  ('M00009-Wolerine','James','Howlett',		null,1),
	  ('M00010-Jean','Jean','Gray',			null,1),
	  ('M00011-Iron Man','Tony','Stark',		null,1),
	  ('M00013-IceMan','Bobby','Drake',		null,1),
	  ('M00014-Scarlet Witch','Wanda','Maximoff',null,1),
	  ('M00015-Hulk','Bruce','Banner',			null,1),
	  ('M00016-Silver Server','Norrin','Radd',	null,1);
INSERT INTO PeopleAddrresList (AddressId,NTID)
VALUES 
	  (1,'M00001-Angel'),
	  (2,'M00002-A-Bomb'),
	  (3,'M00003-Black-Bolt'),
	  (4,'M00004-Lockjaw'),
	  (5,'M00005-Blizzard'),
	  (6,'M00006-Toro'),
	  (7,'M00007-Banshee');
INSERT INTO StudentStatus(StatusName,StatusDescription)
VALUES 
	  ('UnderGraduate','Undergraduate'),
	  ('Graduate','Graduate'),
	  ('Non-Matriculate','non-Matriculate'),
	  ('Graduated','Graduated');
INSERT INTO StudentInformation (NTID,StudentId,[Password],DateOfBirth,[Status])
VALUES 
	('M00001-Angel'			,'102966353','Syracuse','1987/06/01',1),
	('M00002-A-Bomb'		,'204809878','Syracuse','1988/07/01',2),
	('M00003-Black-Bolt'		,'304789790','Syracuse','1989/01/25',3),
	('M00004-Lockjaw'		,'401231232','Syracuse','1990/03/24',4),
	('M00005-Blizzard'		,'512312323','Syracuse','1991/07/11',1),
	('M00006-Toro'			,'604590899','Syracuse','1985/09/17',2),
	('M00007-Banshee'		,'704919822','Syracuse','1974/10/09',3),
	('M00013-IceMan'		,'804912342','Syracuse','1987/12/29',1),
	('M00014-Scarlet Witch'	,'902349124','Syracuse','1985/07/31',1);
INSERT INTO College (CollegeId,CollegeName,CollegeDescription)
VALUES 
	('ECS','LCS College of Engineering & Computer Science','L.C. Smith College 
of Engineering and computer science Investment club. Open to all LCS students as well as guests.'),
	('LAW','College of LAW','College of LAW'),
	('NEW','NewHouse School of Public Communications','New House'),
	('EDU','School of Education','Eduction'),
	('MGM','School of Management','Management'),
	('ISC','iSchool of Information Studies','iSchool');
INSERT INTO StudentMajorAndMinorList (CollegeId,NTID,IsMajor)
VALUES 
	('ECS','M00001-Angel'		,1),
	('LAW','M00002-A-Bomb'	,1),
	('NEW','M00003-Black-Bolt'	,1),
	('EDU','M00004-Lockjaw'	,0),
	('ECS','M00005-Blizzard'	,0),
	('EDU','M00006-Toro'		,1),
	('LAW','M00007-Banshee'	,1);
INSERT INTO EnrollmentStatus (StatusName,StatusDescription)
VALUES 
	('Regular','In prograss'),
	('Pass','Pass the course'),
	('Fail','Fail to complete'),
	('Audit','Check the status');
INSERT INTO Grade(GradeName)
VALUES
	 ('A'),('B'),('C'),('D'),('E'),('N'),('F');
INSERT INTO Courses(CourseCode,CourseNumber,CourseTitle,CourseDescription)
VALUES 
	('CIS','675','Design And Alalysis of Algorithm',	null),
	('CIS','623','Structure Programming And Formal method', null),
	('CIS','607','Mathematics in Computing',null),
	('CSE','775','Distribute Object', null),
	('CIS','681','Software Modeling And Alalysis', null),
	('CIS','776','Design Pattern', null),
	('CSE','581','Introduction Database and Management System',null),
	('LAW','814','Technology transfer', null),
	('LAW','903','Criminal Law Clinic', null),
	('LAW','581','Introduction Database and Management System',null),
	('COM','107','Communications and Society',null),
	('NEW','205','News writing',null),
	('BDJ','204','News in Multimedia World',null),
	('ADV','206','Advertising Practice',null),
	('EDU','603','Introduction to Qulitative Research',null),
	('EDU','616','Understanding Education Research',null),
	('EEE','600','International Entrepreneurship',null),
	('MAS','261','Satistic for Mgmt',null),
	('IST','659','Data Admin Concepts & Db Mgmt',null),
	('IST','654','Information Systems Analysis',null)
INSERT INTO CoursePrerequisiteList (CourseId,PreCourseId)
VALUES
	(1,3),(4,5),(6,5),(2,3);
INSERT INTO [DayOfWeek] ([Day])
VALUES
	('Monday'),('Tuesday'),('Wednesday'),('Thursday'),('Friday'),('Saturday'),('Sunday');
INSERT INTO CourseMeetingList([DayOfWeek],CourseStartTime,CourseEndTime)
VALUES
	(1,'8:00','9:20'),(1,'9:30','11:00'),(1,'11:00','12:20'),(1,'13:20','14:00'),(1,'14:20','16:00'),(1,'16:20','18:00'),(1,'18:20','19:00'),
	(2,'8:00','9:20'),(2,'9:30','11:00'),(2,'11:00','12:20'),(2,'13:20','14:00'),(2,'14:20','16:00'),(2,'16:20','18:00'),(2,'18:20','19:00'),
	(3,'8:00','9:20'),(3,'9:30','11:00'),(3,'11:00','12:20'),(3,'13:20','14:00'),(3,'14:20','16:00'),(3,'16:20','18:00'),(3,'18:20','19:00');
INSERT INTO SemesterTerms (Name,[Description])
VALUES 
	('FALL','September to December'),
	('SPRING','Jan to May'),
	('Summer I','May to Jun'),
	('Summer II','Jun to Aug');
INSERT INTO SemesterInformation ([Year],SemesterTerm,StartDate,EndDate) 
VALUES
	('2015',1,'08/31','12/10'),
	('2015',2,'01/19','05/02'),
	('2016',3,'05/11','06/30'),
	('2016',4,'07/01','08/10');
INSERT INTO Buildings(BuildingName)
VALUES 
	('Life Science Building'),('Hinds Hall'),
	('Lyman Hall'),('Whiteman Building'),
	('New House I'),('New House II'),
	('New House III'),('Education Building');
INSERT INTO Equipments (Name,[Description])
VALUES 
	('Projector-s','Small class room-Less then 30 people'),
	('Projector-m','Medium class room- 30-70 room fit'),
	('Projector-l','Large class room-Auditorium '),
	('Microphone-wire','Wire Micro Phone'),
	('Microphone-wireless','Wireless'),
	('Projector-Line','Audio cable');
INSERT INTO Classrooms (RoomNumber,MaximumSeats,Building,Equipment,WhiteBoardCount,OtherAVEquipment)
VALUES 
	(306,70	,1,2,1,null),
	(671,30	,2,2,1,null),
	(402,100	,3,2,1,null),
	(201,50	,5,2,0,null),
	(788,50	,7,2,1,null),
	(239,60	,8,2,0,null);
INSERT INTO CourseSchedule(SemesterInformation,InstructorNTID,CourseMeetingTime,CourseId,RoomId,OpenSeats)
VALUES 
	(1,'M00010-Jean'	,	1,1,1,60),
	(1,'M00009-Wolerine',	2,2,2,30),
	(1,'M00008-X Prof'	,	3,3,1,70),
	(1,'M00008-X Prof'	,	4,4,3,80),
	(2,'M00010-Jean'	,	6,3,3,90),
	(2,'M00008-X Prof'	,	5,7,4,50),
	(2,'M00011-Iron Man',	2,5,5,50),
	(2,'M00011-Iron Man',	3,6,6,50);
INSERT INTO Enrollments(Grade,EnrollmentStatus,ScheduleId,StudentNTID)
VALUES
	(6,1,1,'M00013-IceMan'),
	(6,1,1,'M00014-Scarlet Witch'),
	(6,1,2,'M00001-Angel'),
	(6,1,2,'M00002-A-Bomb'),
	(1,2,1,'M00007-Banshee'),
	(6,3,3,'M00007-Banshee');
INSERT INTO JobInformation(Title,[Description],Requirements,MaximumPay,MinimumPay,IsUnion)
VALUES 
	('Assistent Professor'	,'Level 1 mutant',null,70000.00,50000.00,0),
	('Adjunct Professor'	,'Level 2 mutant',null,80000.00,50000.00,0),
	('Associate professor'	,'Level 3 mutant',null,85000.00,50000.00,0),
	('Professor'			,'Level 4 mutant',null,90000.00,50000.00,0),
	('Tenure Professor'	,'Level 5 mutant',null,90000.00,50000.00,0);
INSERT INTO EmployeeInformation(NTID,EmployeeId ,YearlyPay,JobType)
VALUES
	('M00008-X Prof'		,'E00001',89722.65,5),
	('M00009-Wolerine'	,'E00002',59722.65,4),
	('M00010-Jean'		,'E00003',79722.65,5),
	('M00011-Iron Man'	,'E00004',69722.65,2),
	('M00015-Hulk'		,'E00005',69722.65,4),
	('M00016-Silver Server','E00006',59722.65,3);
INSERT INTO BenefitsCostSelection(SelectionName)
VALUES	
('Single'),('Family'),('op-out');
INSERT INTO BenefitsType(TypeName)
VALUES	
('Health'),('Vision'),('Dental');
INSERT INTO BenefitsInformation(CostSelection,CostType,ItemCost)
VALUES	
	(1,1,1000.00),(1,2,1500.00),(1,3,500.00),
	(2,1,500.00),(2,2,1500.00),(2,3,400.00),
	(3,1,800.00),(3,2,1600.00),(3,3,200.00);
INSERT INTO EmployeeBenefits(NTID,BenefitsInformationId,TotalCost)
VALUES	
	('M00008-X Prof'		,1,1080.00),
	('M00009-Wolerine'	,3,540.00),
	('M00009-Wolerine'	,4,540.00),
	('M00011-Iron Man'	,5,1620.00),
	('M00015-Hulk'		,6,423.00),
	('M00015-Hulk'		,7,864.00);

-- View 1.
IF OBJECT_ID ('StudentCourseEnrollment','V') IS NOT NULL
	DROP VIEW dbo.StudentCourseEnrollment;
GO
CREATE VIEW dbo.StudentCourseEnrollment 
AS 
	SELECT  si.StudentId							AS 'SutentId', 
			ps.FirstName 	+'  '+ ps.LastName		AS 'Student Name',
				es.StatusName 						AS 'Status', 
			c.CourseTitle						AS 'Course Name', 
			p.FirstName	+'  '+p.LastName		AS 'Instructor',
			g.GradeName						AS 'Grade'
		FROM 
			Enrollments		en,EnrollmentStatus	es,Grade	g,Courses c,
			StudentInformation	si,CourseSchedule	cs,People	p,People ps
		WHERE 
				en.EnrollmentStatus 	= es.StatusId	AND 
				en.Grade			= g.GradeId	AND
				en.ScheduleId		= cs.ScheduleId 	AND
				en.StudentNTID		= si.NTID		AND
				cs.InstructorNTID	= p.NTID		AND
				cs.CourseId			= c.CourseId	AND
				si.NTID			= ps.NTID;

--View 2.
CREATE VIEW dbo.CoursesScheduleDetail
AS
	SELECT	si.[Year]		+' '+	st.[Name]								AS	'Term Type',
			c.CourseCode	+' '+	CAST(c.CourseNumber AS VARCHAR(10))		AS	'Course Number',
			c.CourseTitle											AS	'Course Name',
			p.FirstName	+' '+	p.LastName							AS	'Instructor',
			dw.[Day]		+' '+	cm.CourseStartTime +'-'+cm.CourseEndTime		AS	'Meeting Time',
			b.BuildingName	+' '+	CAST(cl.RoomNumber	AS VARCHAR(20))		AS	'Location'
		FROM 
			CourseSchedule	cs,	CourseMeetingList	cm, 	Courses		c, 
			[DayOfWeek]	dw, 	SemesterInformation 	si,	SemesterTerms	st,
			Classrooms		cl,	People			p,	Buildings	b
		WHERE 
			cs.SemesterInformation	= si.SemesterInfoId	AND
			si.SemesterTerm		= st.TermId			AND
			cs.RoomId			= cl.RoomId		AND
			cs.CourseMeetingTime	= cm.MeetingListId	AND
			cm.[DayOfWeek]		= dw.WeekDayId		AND 
			cs.CourseId			= c.CourseId		AND
			cs.InstructorNTID	 = p.NTID			AND
			cl.Building			= b.BuildingId;
--View 3.
CREATE VIEW dbo.StudentContactInformation
AS
		SELECT 
			p.FirstName +' '+ p.LastName			AS 'Student Name',
			st.StudentId						AS 'Student Identiy',
			ss.StatusName						AS 'Student Status',
			a.Street1 +','+ 
			CAST (CASE 
				WHEN a.Street2 IS NULL 
				THEN '' END AS VARCHAR(1)) + 
				','+ cas.City+',' +s.StateName			AS 'Address',
			co.CollegeName						AS 'College',
			CAST(CASE 
			WHEN sm.IsMajor =1	
				THEN	'Major' 
			ELSE			'Minor' 
			END AS VARCHAR(10))				AS 'Major or Minor'
		FROM 
			StudentInformation		st, People			p,	StudentStatus ss,
			StudentMajorAndMinorList	sm, College			co,	PeopleAddrresList pa,
			[Address]				a,	CityAndState	cas,	[State] s
		WHERE
			st.NTID		= p.NTID		AND 
			st.[Status]		= ss.StatusId	AND
			sm.NTID		= st.NTID		AND
			sm.CollegeId	= co.CollegeId	AND
			p.NTID		= pa.NTID		AND
			pa.AddressId	= a.AddressId	AND
			a.ZipCode		= cas.ZipCode	AND
			S.StateId		= cas.[State]

-- View 4. 
CREATE VIEW dbo.EmployeeInformationDetail
AS
		SELECT 
			ei.NTID			AS	'NTID', 
			ei.EmployeeId		AS	'Employee Id', 
			ei.YearlyPay		AS	'Salary', 
			ji.Title			AS	'Employee Title',
			IIF (ji.IsUnion = 1,'YES','NO')	
							AS	'Union', 
			eb.TotalCost		AS	'Benefits Cost',
			bc.SelectionName	AS	'Benefits Selection', 
			bt.TypeName		AS	'Benefits Type'	,
			bi.ItemCost			AS	'Original Cost'
		FROM 
			People			p,	EmployeeInformation	ei,EmployeeBenefits 	eb,JobInformation ji, 
			BenefitsInformation 	bi,	BenefitsCostSelection	bc,BenefitsType		bt
		WHERE
			p.NTID				= ei.NTID				AND 
			ei.NTID				= eb.NTID				AND 
			bi.CostType			= bt.TypeId				AND 
			ei.JobType				= ji.JobId				AND
			eb.BenefitsInformationId	= bi.BenefitsInformationId	AND
			bi.CostSelection			= bc.BenefitsCostId;
--Sp 1. 
--1. SP I RegisterNewStudent
-- Argument: FirstName, LastName, StudentId,Status,DateOfBirth, Address1,Address2, City, State,ZipCode
-- Step 1.Check Argument Valid
-- Step 2. Register Student
IF OBJECT_ID('dbo.RegisterNewStudent','P') IS NOT NULL
	DROP PROCEDURE dbo.RegisterNewStudent;
GO
CREATE PROCEDURE dbo.RegisterNewStudent
 	(@studentId	AS VARCHAR(10) , 	@firstName	AS VARCHAR(30), @SSN		AS VARCHAR(10),
@lastName  	AS VARCHAR(30) ,	@dateOfBirth   AS DateTime,	   @city		AS VARCHAR(30),
@address1     AS VARCHAR(200),	@address2	 	AS VARCHAR(200),@zipCode	AS VARCHAR(10),
	@sStatus	 	AS VARCHAR(20),	@college	 	AS VARCHAR(200),@stateName	AS VARCHAR(30))
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
				DECLARE @newNTID		AS VARCHAR(30) = LEFT(NEWID(),(30))
				DECLARE @dob			AS VARCHAR(10)
				DECLARE @studentStatusId		AS INT 
				DECLARE @collegeId			AS VARCHAR(10)
				DECLARE @isActive			AS BIT = 1
				DECLARE @stateId			AS VARCHAR(2)
				DECLARE @addId			AS INT
				SELECT 	@dob = FORMAT (@dateOfBirth,'dd/MM/yyyy','en-US');
				SELECT 	@studentStatusId = StatusId	FROM StudentStatus	WHERE  StatusName	 	= @sStatus
				SELECT 	@collegeId	   	= CollegeId	FROM College		WHERE  CollegeName 	= @college
				SELECT 	@stateId	   	= StateId	FROM [State]		WHERE  StateName		= @stateName
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
					SELECT 	@addId = @@IDENTITY ;

					INSERT INTO PeopleAddrresList(AddressId,NTID)
						VALUES (@addId,@newNTID)

					PRINT ('Regier Student "'+ @firstName +' '+ @lastName +'" Success !')
				END
			END; 
--Sp 2. 
CREATE PROCEDURE dbo.EnrollStudentInCourse
	(@studentId AS VARCHAR(10), @cCode AS VARCHAR(10), @enrollStatus AS VARCHAR(30),
	@cNumber AS INT, @year AS VARCHAR(10),@termName AS VARCHAR(20))
AS
	BEGIN
		DECLARE @newNTID	AS VARCHAR(30) = NULL
		DECLARE @term		AS VARCHAR(20) = NULL
		DECLARE @isActive		AS BIT 
		DECLARE	@statusId		AS INT = 0
		DECLARE @courseId		AS INT = 0
		DECLARE @scheduleId 	AS INT = 0
		DECLARE @gradeId		AS INT = 0
		-- Verify Status Term 
		SELECT		@statusId 		= StatusId 
			FROM	EnrollmentStatus 
			WHERE	StatusName 	= @enrollStatus
		--Verify Student Status
		SELECT 		@newNTID = p.NTID,  
					@isActive= p.IsActive
			FROM  	Studentinformation si , People p 
			WHERE 
					p.NTID = si.NTID AND 
					si.StudentId = @studentId
		--Verify Course 
		SELECT  		@courseId = CourseId
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
					Semesterterms  st, CoursemeetingList 	cm,	[DayOfWeek] dw 
				WHERE  
					cs.CourseMeetingTime = cm.MeetingListId	AND
					cm.[DayOfWeek] 	= dw.WeekDayId		AND
					cs.SemesterInformation= si.SemesterInfoId	AND
					si.SemesterTerm 	= st.TermId			AND
					st.Name 			= @termName		AND
					si.[Year]			= @year			AND
					cs.CourseId 		= @courseId
				IF @scheduleId = 0
					BEGIN 
						PRINT ('Please verify enroll course information, We could not find the opening Course');
						PRINT ('Couse Code: '		+ @cCode )
						PRINT ('Course Number: '	+ CAST (@cNumber AS vARCHAR(10)))
						PRINT ('Semester Terms: '	+ @termName)
						PRINT ('Year:'			+ @year);
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
									VALUES 			(@gradeId,@statusId,@scheduleId,@newNTID)
								PRINT('Enroll course'+ @cCode +' '+ 
CAST (@cNumber AS VARCHAR(10)) + 'Success');
							END
					END
			END
	END;

--Sp 3.
--3. PROCEDURE III-UpdateClassroomSeats
-- Argument: CourseId,CourseSchedule Id, Seats number
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
		DECLARE @result			AS VARCHAR(200) = NULL
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
					SELECT  @originalOpenSeats 	= OpenSeats, 
							@maximumSeats	   	= MaximumSeats
					FROM	CourseSchedule cs, Classrooms cl
					WHERE 
						cs.RoomId		= cl.RoomId		AND 
						cs.ScheduleId	= @courseScheduleId
					SET @updateSeats 	= @originalOpenSeats + @usedSeats
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
					SET		OpenSeats 	= @updateSeats 
					WHERE	ScheduleId = @courseScheduleId
					SET @result = 'Success, Seats count set to '+CAST (@updateSeats AS VARCHAR(10)) +'.'
				END
			PRINT @result
	END;

-- FUNC 1.
--4. FUN I -VerifyCoursePrerequisite
-- Argument:CourseId,Student 
-- return: VARCHAR(200)-Result
-- If the course has no prerequisite then return NULL
-- If the course has prerequisite then check student has enrolled in the class or not?
-- If student has already took the class, then he has the permission to enroll, otherwise return "Prerequisite course list"
IF OBJECT_ID ('dbo.VerifyCoursePrerequisite','FN') IS NOT NULL
	DROP FUNCTION dbo.VerifyCoursePrerequisite;
GO
CREATE FUNCTION dbo.VerifyCoursePrerequisite (@courseId AS INT,	@studentNTID AS VARCHAR(30))
RETURNS VARCHAR(200)AS
	BEGIN
	DECLARE @result 			AS VARCHAR(200) = NULL
	DECLARE @preCourseId 		AS INT = 0
	DECLARE @scheduleId 		AS INT
	DECLARE @enrollPassedCount 	AS INT = 0
	DECLARE @preCourseCount 	AS INT = 0
		SELECT		@preCourseId = PreCourseId 
			FROM 	Courses c, CoursePrerequisiteList cp 
			WHERE 	c.CourseId = cp.CourseId AND c.courseId = @courseId;
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
						s.ScheduleId 	= cs.ScheduleId	AND 
						s.Grade 		= g.GradeId	AND
						s.StudentNTID 	= @studentNTID	AND 
						cs.CourseId 	= @preCourseId	AND
						g.GradeName IN ('A','B','C')
				IF (@preCourseCount <> @enrollPassedCount)
					-- Not pass all the prerequisite
					BEGIN
						SET @result = 'The student are not passed all the prerequisite';
					END
			END
		RETURN @result;
	END;	
