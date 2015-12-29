-- Author LIU,SHOU YUNG
-- Date:10/17/2015
-- Purpose: CSE Lab10 Tables

-- Part 1 Insert
INSERT INTO USERS (NTID,FirstName,MiddleInitial,LastName,EmailAddress,Password)
VALUES
	('01-HJPotter','Harry','J','Potter','hp@hw.edu','Hedwig'),
	('02-RBWeasley','Ron','B','Weasley','rw@hw.edu','Scabbers'),
	('03-HJGranger','Hermione','H','Granger','hg@hw.edu','Crookshanks'),
	('10-Rlupin','Remus',NULL,'Lupin','rl@hw.edu','moon'),
	('11-Fflitwick','Filius',NULL,'Flitwick','ff@hw.edu',NULL),
	('16-Rhagrid','Rubeus',NULL,'Hagrid','rh@hw.edu','BuckBEak');

INSERT INTO Courses (COurseCode,CourseTitle,Faculty,OpenSeats)
VALUES 
	('DADA101','Defense Against the Dark Arts BASIC','10-Rlupin',3),
	('DADA201','Defense Against the Dark Arts INTERMEDIATE','10-Rlupin',2),
	('DADA301','Defense Against the Dark Arts ADVANCED','10-Rlupin',1),
	('CHMS101','Charms BASIC','11-Fflitwick',2),
	('CHMS201','Charms INTERMEDIATE','11-Fflitwick',0),
	('CHMS301','Charms ADVANCED','11-Fflitwick',4),
	('HOM101','History of Magic BASIC',NULL,10);

INSERT INTO LetterGrades(LetterGrade,Description)
VALUES
	('O','Outstanding'),
	('E','Exceeds Expectations'),
	('A','Acceptable'),
	('P','Poor'),
	('D','Dreadful'),
	('T','Troll');

INSERT INTO CourseGrade(LetterGradeID,CourseID,GradeValue)
VALUES
	(1,1,95),(2,1,90),(3,1,80),(4,1,70),(5,1,60),(6,1,0),
	(1,2,100),(2,2,90),(3,2,85),(4,2,75),(5,2,64),(6,2,0);

INSERT INTO CourseEnrollment(StudentId,CourseId,FinalGrade)
VALUES
	('01-HJPotter',1,NULL),
	('01-HJPotter',4,NULL),
	('03-HJGranger',1,NULL),
	('03-HJGranger',4,NULL),
	('02-RBWeasley',1,NULL),
	('02-RBWeasley',4,NULL);

--Part 2 Update/Delete
--a.Lupin has been fired. Assign his classes to Hagrid. 
--Remove Lupin from the database.
SELECT * FROM COURSES

UPDATE Courses
SET Faculty = '16-Rhagrid'
WHERE Faculty = '10-Rlupin';

DELETE Users WHERE NTID='10-Rlupin';

--b.Harry has received a final grade of 96 in Defence Against the Dark Arts, 
--and 91 in Charms.

UPDATE CourseEnrollment
	SET FinalGrade = '96'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Harry') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Defense Against the Dark Arts%' );
UPDATE CourseEnrollment
	SET FinalGrade ='91'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Harry') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Charms %' );

--c.Ron has received a final grade of 91 in Defence Against the Dark Arts, and
-- 88 in Charms.
UPDATE CourseEnrollment
	SET FinalGrade = '91'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Ron') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Defense Against the Dark Arts%' );
UPDATE CourseEnrollment
	SET FinalGrade ='88'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Ron') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Charms %' );

--d.Hermione has received a final grade of 92.22 in Defence Against the Dark Arts,
-- and 99 in Charms.

UPDATE CourseEnrollment
	SET FinalGrade = '92.22'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Hermione') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Defense Against the Dark Arts%' );
UPDATE CourseEnrollment
	SET FinalGrade ='99'
	WHERE 
		StudentId IN (SELECT NTID FROM Users WHERE FirstName = 'Hermione') and 
		CourseId IN (SELECT CourseId FROM Courses WHERE CourseTitle Like 'Charms %' );

--e.Enroll Harry in Intermediate Defence Against the Dark Arts.
DECLARE @NTID VARCHAR(20),@CourseId INT;
SELECT @NTID = NTID 
	FROM Users 
	WHERE FirstName = 'Harry';
SELECT @CourseId = CourseId
	FROM Courses 
	WHERE CourseTitle = 'Defense Against the Dark Arts INTERMEDIATE'; 
INSERT INTO CourseEnrollment (StudentId,CourseId)
VALUES (@NTID,@CourseId);

--f.Enroll Hermione in Advanced Charms.
DECLARE @HermioneNTID VARCHAR(20),@CharmsCourseId INT;
SELECT @HermioneNTID = NTID 
	FROM Users 
	WHERE FirstName = 'Hermione';
SELECT @CharmsCourseId = CourseId
	FROM Courses 
	WHERE CourseTitle = 'Charms ADVANCED'; 
INSERT INTO CourseEnrollment (StudentId,CourseId)
VALUES (@HermioneNTID,@CharmsCourseId);
