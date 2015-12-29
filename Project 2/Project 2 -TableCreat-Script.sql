--IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME ='sliu132Database')

-- CREATE TABLE 
--DROP DATABASE sliu132Database
--/* Delete Database Backup and Restore History from MSDB System Database */ 
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'sliu132Database' 
GO
 --/* Query to Get Exclusive Access of SQL Server Database before Dropping the Database */ 
 USE [master]
 GO 
 ALTER DATABASE sliu132Database SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
 GO 
 --/* Query to Drop Database in SQL Server */
 DROP DATABASE sliu132Database;
 GO
CREATE DATABASE sliu132Database;
USE sliu132Database
CREATE TABLE [State](
	StateId					VARCHAR(2)			PRIMARY KEY,
	StateName				VARCHAR(30)			NOT NULL
);
CREATE TABLE CityAndState(
	ZipCode					VARCHAR(10)			PRIMARY KEY,
	City					VARCHAR(30)			NOT NULL,
	[State]					VARCHAR(2)			FOREIGN KEY REFERENCES [State](StateId)
);
CREATE TABLE [Address](
	AddressId				INT IDENTITY(1,1)	PRIMARY KEY,
	Street1					VARCHAR(200)		NOT NULL,
	Street2					VARCHAR(200),
	ZipCode					VARCHAR(10)			NOT NULL FOREIGN KEY REFERENCES CityAndState(ZipCode)
);
CREATE TABLE People(
	NTID					VARCHAR(30)			PRIMARY KEY,
	FirstName				VARCHAR(30)			NOT NULL,
	LastName				VARCHAR(30)			NOT NULL,
	SSN						VARCHAR(10),
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
	StatusId				INT IDENTITY(1,1)	PRIMARY KEY,
	StatusName				VARCHAR(20)			NOT NULL,
	StatusDescription		VARCHAR(200)
);

CREATE TABLE StudentInformation(
	NTID					VARCHAR(30)			PRIMARY KEY CONSTRAINT fk_StudentInformation_People
												FOREIGN KEY REFERENCES People(NTID),
	StudentId				VARCHAR(10)			NOT NULL,
	[Password]				VARCHAR(200),
	DateOfBirth				VARCHAR(10),
	[Status]				INT					CONSTRAINT fk_StudentInformation_StudentStatus
												FOREIGN KEY REFERENCES StudentStatus(StatusId),
);
CREATE TABLE College(
	CollegeId				VARCHAR(10)			PRIMARY KEY,
	CollegeName				VARCHAR(200)			NOT NULL,
	CollegeDescription		VARCHAR(1000)
);
CREATE TABLE StudentMajorAndMinorList(
	ListId					INT IDENTITY(1,1)	PRIMARY KEY,
	CollegeId				VARCHAR(10)			CONSTRAINT fk_College_MajorAndMinorList 
												FOREIGN KEY REFERENCES College(CollegeId),
	NTID					VARCHAR(30)			CONSTRAINT fk_MajorAndMinorList_StudentInfo
												FOREIGN KEY REFERENCES StudentInformation(NTID),
	IsMajor					BIT NOT NULL
);
CREATE TABLE EnrollmentStatus(
	StatusId				INT IDENTITY(1,1)	PRIMARY KEY,
	StatusName				VARCHAR(30)			NOT NULL,
	StatusDescription		VARCHAR(200)		NOT NULL
);
CREATE TABLE Grade(
	GradeId					INT IDENTITY(1,1)	PRIMARY KEY,
	GradeName				VARCHAR(10)			NOT NULL
);

CREATE TABLE Courses(
	CourseId				INT IDENTITY(1,1)	PRIMARY KEY,
	CourseCode				VARCHAR(10)			NOT NULL,
	CourseNumber			INT					NOT NULL,
	CourseTitle				VARCHAR(50)			NOT NULL,
	CourseDescription		VARCHAR(200),
);
CREATE TABLE CoursePrerequisiteList(
	PreCourseListId			INT IDENTITY(1,1)	PRIMARY KEY,
	CourseId				INT					CONSTRAINT fk_Courses_CourseId 
												FOREIGN KEY REFERENCES Courses(CourseId),
	PreCourseId				INT					CONSTRAINT fk_Courses_PreCourseId
												FOREIGN KEY REFERENCES Courses(CourseId)
);
CREATE TABLE [DayOfWeek](
	WeekDayId				INT IDENTITY(1,1)	PRIMARY KEY,
	[Day]					VARCHAR(10)			NOT NULL
);
CREATE TABLE CourseMeetingList(
	MeetingListId			INT IDENTITY(1,1)	PRIMARY KEY,
	[DayOfWeek]				INT					NOT NULL CONSTRAINT fk_CourseMeetingDay
												FOREIGN KEY REFERENCES [DayOfWeek](WeekDayId),
	CourseStartTime			VARCHAR(10)			NOT NULL,
	CourseEndTime			VARCHAR(10)			NOT NULL
);
CREATE TABLE SemesterTerms(
	TermId					INT IDENTITY(1,1)	PRIMARY KEY,
	Name					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(200) 
);
CREATE TABLE SemesterInformation(
	SemesterInfoId			INT IDENTITY(1,1)	PRIMARY KEY,
	[Year]					VARCHAR(10)			NOT NULL,
	SemesterTerm			INT					NOT NULL 
												CONSTRAINT fk_SemesterTerms_Information
												FOREIGN KEY REFERENCES SemesterTerms(TermId),
	StartDate				VARCHAR(10)			NOT NULL,
	EndDate					VARCHAR(10)			NOT NULL
);
CREATE TABLE Buildings(
	BuildingId				INT IDENTITY(1,1)	PRIMARY KEY,
	BuildingName			VARCHAR(30)
);
CREATE TABLE Equipments(
	EquipmentId				INT IDENTITY(1,1)	PRIMARY KEY,
	Name					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(1000) 
);
CREATE TABLE Classrooms(
	RoomId					INT IDENTITY(1,1)	PRIMARY KEY,
	RoomNumber				SMALLINT			NOT NULL,
	MaximumSeats			TINYINT				NOT NULL,
	Building				INT					NOT NULL 
												CONSTRAINT fk_Classroom_Location
												FOREIGN KEY REFERENCES Buildings(BuildingId),
	Equipment				INT					CONSTRAINT fk_Classrooms_Equipment 
												FOREIGN KEY REFERENCES Equipments(EquipmentId),
	WhiteBoardCount			TINYINT				NOT NULL,
	OtherAVEquipment		INT					CONSTRAINT fk_Classrooms_EquipmentOtherAV 
												FOREIGN KEY REFERENCES Equipments(EquipmentId) 
);
CREATE TABLE CourseSchedule(
	ScheduleId				INT IDENTITY(1,1)	PRIMARY KEY,
	SemesterInformation		INT NOT NULL		CONSTRAINT fk_Course_SemesterInformation
												FOREIGN KEY REFERENCES SemesterInformation(SemesterInfoId),
	InstructorNTID			VARCHAR(30)			CONSTRAINT fk_Courseteaching_Instructor
												FOREIGN KEY REFERENCES People(NTID),
	CourseMeetingTime		INT NOT NULL		CONSTRAINT fk_Schedule_MeetingList 
												FOREIGN KEY REFERENCES CourseMeetingList(MeetingListId),
	CourseId				INT NOT NULL		CONSTRAINT fk_Courses_Schedule
												FOREIGN KEY REFERENCES Courses(CourseId),
	RoomId					INT					CONSTRAINT fk_Couese_Room 
												FOREIGN KEY REFERENCES Classrooms(RoomId),
	OpenSeats				INT NOT NULL		CHECK(OpenSeats >=0 )
);
CREATE TABLE Enrollments(
	EnrollmentId			INT IDENTITY(1,1)	PRIMARY KEY,
	Grade					INT					CONSTRAINT fk_Enrollment_Student_Grade 
												FOREIGN KEY REFERENCES Grade(GradeId),
	EnrollmentStatus		INT					CONSTRAINT fk_Enrollment_Status 
												FOREIGN KEY REFERENCES EnrollmentStatus(StatusId),
	ScheduleId				INT					CONSTRAINT fk_Enrollment_CourseSchedule 
												FOREIGN KEY REFERENCES CourseSchedule(ScheduleId),
	StudentNTID				VARCHAR(30)			NOT NULL 
												CONSTRAINT fk_Enrollment_StudentNTID 
												FOREIGN KEY REFERENCES StudentInformation(NTID), 
);
CREATE TABLE JobInformation(
	JobId					INT IDENTITY(1,1)	PRIMARY KEY,
	Title					VARCHAR(20)			NOT NULL,
	[Description]			VARCHAR(200),
	Requirements			VARCHAR(1000),
	MaximumPay				DECIMAL(10,2)		NOT NULL CHECK( MaximumPay >= 0.00 ),
	MinimumPay				DECIMAL(10,2)		NOT NULL CHECK( MinimumPay >= 0.00 ),
	IsUnion					BIT					NOT NULL
);
CREATE TABLE EmployeeInformation(
	NTID					VARCHAR(30)			PRIMARY KEY 
												CONSTRAINT fk_People_Employee 
												FOREIGN KEY REFERENCES People(NTID),
	EmployeeId				VARCHAR(10)			NOT NULL,
	YearlyPay				DECIMAL(10,2)		NOT NULL CHECK (YearlyPay >= 0.00),
	JobType					INT					CONSTRAINT	fk_Employee_JobType 
												FOREIGN KEY REFERENCES JobInformation(JobId)
);
CREATE TABLE BenefitsCostSelection(
	BenefitsCostId			INT IDENTITY(1,1)	PRIMARY KEY,
	SelectionName			VARCHAR(20)			NOT NULL
);
CREATE TABLE BenefitsType(
	TypeId					INT IDENTITY(1,1)	PRIMARY KEY,
	TypeName				VARCHAR(20)			NOT NULL
);
CREATE TABLE BenefitsInformation(
	BenefitsInformationId	INT IDENTITY(1,1)	PRIMARY KEY,
	CostSelection			INT					CONSTRAINT fk_Benefits_CostSelection 
													FOREIGN KEY REFERENCES BenefitsCostSelection(BenefitsCostId),
	CostType				INT					CONSTRAINT fk_Benefits_Type 
													FOREIGN KEY REFERENCES BenefitsType(TypeId),
	ItemCost				DECIMAL(10,0)		NOT NULL CHECK(ItemCost >= 0.00)
);
CREATE TABLE EmployeeBenefits(
	NTID					VARCHAR(30)			NOT NULL 
												CONSTRAINT fk_EmployeeInformation_Benefits 
												FOREIGN KEY REFERENCES EmployeeInformation(NTID),
	BenefitsInformationId	INT					NOT NULL 
												CONSTRAINT fk_Employee_Benefits 
												FOREIGN KEY REFERENCES BenefitsInformation(BenefitsInformationId),
	TotalCost				DECIMAL(10,2)		NOT NULL,
	CONSTRAINT pk_EmployeeInformation_BenefitsInformation
	PRIMARY KEY(NTID, BenefitsInformationId)
);


