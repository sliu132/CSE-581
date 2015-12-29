-- Author LIU,SHOU YUNG
-- Date:10/11/2015
-- Purpose: CSE Lab9 Tables
CREATE TABLE Users(
	NTID			VARCHAR(20) PRIMARY KEY,
	FirstName		VARCHAR(50) NOT NULL,
	MiddleInitial	VARCHAR(1),
	LastName		VARCHAR(50) NOT NULL,
	EmailAddress	VARCHAR(50),
	[Password]		VARCHAR(50)
);
CREATE TABLE Courses(
	CourseId		INT Identity(1,1) PRIMARY KEY,
	CourseCode		VARCHAR(10) NOT NULL,
	CourseTitle		VARCHAR(50) NOT NULL,
	Faculty			VARCHAR(20)	FOREIGN KEY REFERENCES Users(NTID),
	OpenSeats		TINYINT NOT NULL, 
);

CREATE TABLE LetterGrades(
	LetterGradeId	INT IDENTITY(1,1) PRIMARY KEY,
	LetterGrade		VARCHAR(2)	NOT NULL,
	[Description]	VARCHAR(50)
);

CREATE TABLE CourseGrade(
	GradingScaleId	INT IDENTITY(1,1) PRIMARY KEY,
	LetterGradeId	INT			NOT NULL 
						CONSTRAINT	fk_LetterGrades_CourseGrade
						FOREIGN KEY REFERENCES LetterGrades(LetterGRadeId),
	CourseId		INT			NOT NULL
						CONSTRAINT fk_Courses_CourseGrade 
						FOREIGN KEY REFERENCES Courses(CourseId),
	GradeValue		INT			NOT NULL CHECK(GradeValue > = 0), 
);

CREATE TABLE CourseEnrollment(
	EnrollementId	INT IDENTITY(1,1) PRIMARY KEY,
	StudentId		VARCHAR(20) NOT NULL
						CONSTRAINT fk_Users_CourseEnrollement 
						FOREIGN KEY REFERENCES Users(NTID),
	CourseId		INT			NOT NULL 
						CONSTRAINT fk_Courses_CourseEnrollement
						FOREIGN KEY REFERENCES Courses(CourseId),
	FinalGrade DECIMAL(5,2) CHECK( FinalGrade>= 0.00 and FinalGrade <= 100.00)
);

SELECT * FROM Courses
SELECT * FROM CourseGrade
SELECT * FROM CourseEnrollment
SELECT * FROM LetterGrades
SELECT * FROM Users

