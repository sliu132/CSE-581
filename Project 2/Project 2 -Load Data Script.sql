-- Project 2 Step 2 Load Data
-- Date: 2015/11/17

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
	  ('36101','Montgomery'		,'AL'),
	  ('99801','Juneau'			,'AK'),
	  ('85001','Phoenix'		,'AZ'),
	  ('72201','Liitle Rock'	,'AR'),
	  ('94203','Sacramento'		,'CA'),
	  ('80201','Denver'			,'CO'),
	  ('06101','Hartford'		,'CT'),
	  ('19901','Dover'			,'DE'),
	  ('32301','Tallahassee'	,'FL'),
	  ('30301','Atlanta'		,'GA'),
	  ('96801','Honolulu'		,'HI'),
	  ('83701','Boise'			,'ID'),
	  ('62701','Springfield'	,'IL'),
	  ('46201','Indianapolis'	,'IN'),
	  ('50301','Des Moines'		,'IA'),
	  ('66601','Tpdeka'			,'KS'),
	  ('40601','Frankfort'		,'KY'),
	  ('70801','Baton Rouge'	,'LA'),
	  ('04330','Augusta'		,'ME'),
	  ('21401','Annapolis'		,'MD'),
	  ('02108','Boston'			,'MA'),
	  ('48901','Lansing'		,'MI'),
	  ('55101','St Paul'		,'MN'),
	  ('39201','Jaskson'		,'MS'),
	  ('65101','Jefferson City'	,'MO'),
	  ('59601','Helana'			,'MT'),
	  ('68501','Lincoln'		,'NE'),
	  ('89701','Carson City'	,'NV'),
	  ('03301','Concord'		,'NH'),
	  ('08601','Trenton'		,'NJ'),
	  ('87501','Santa Fe'		,'NM'),
	  ('12201','Albany'			,'NY'),
	  ('27601','Raleigh'		,'NC'),
	  ('58501','Bismarck'		,'ND'),
	  ('43201','Columbus'		,'OH'),
	  ('73101','Oklahoma City'	,'OK'),
	  ('97301','Salem'			,'OR'),
	  ('17101','Harrisburg'		,'PA'),
	  ('02901','Providence'		,'RI'),
	  ('29201','Columbia'		,'SC'),
	  ('57501','Pierre'			,'SD'),
	  ('37201','Nashville'		,'TN'),
	  ('73301','Austin'			,'TX'),
	  ('84101','Salt Lake City'	,'UT'),
	  ('05601','Montpelier'		,'VT'),
	  ('23218','Richmond'		,'VA'),
	  ('98501','Olympia'		,'WA'),
	  ('25301','Charleston'		,'WV'),
	  ('53701','Madison'		,'WI'),
	  ('82001','Cheyenne'		,'WY');
INSERT INTO Address (Street1,Street2,ZipCode)
VALUES 
	('3000 State University',null,'23218'),
	('925 H St'				,null,'98501'),
	('1000 H St'			,null,'98501'),
	('926 J St'				,null,'98501'),
	('1300 H St'			,null,'82001'),
	('90 tremont St'		,null,'82001'),
	('1 Court St'			,null,'53701'),
	('60 School St'			,null,'53701'),
	('15 Beacon St'			,null,'53701');
INSERT INTO People (NTID,FirstName,LastName,SSN,IsActive)
VALUES
	('M00001-Angel','Warren','Kenneth',null,1),
	('M00002-A-Bomb','Richard','Milhouse',null,1),
	('M00003-Black-Bolt','Blackagar','Boltagon',null,1),
	('M00004-Lockjaw','Sparky','Nick',null,1),
	('M00005-Blizzard','Gregor','Shapanka',null,1),
	('M00006-Toro','thomas','Raymond',null,1),
	('M00007-Banshee','Sean','Cassidy',null,1),
	('M00008-X Prof','Charles','Xavier',null,1),
	('M00009-Wolerine','James','Howlett',null,1),
	('M00010-Jean','Jean','Gray',null,1),
	('M00011-Iron Man','Tony','Stark',null,1),
	('M00013-IceMan','Bobby','Drake',null,1),
	('M00014-Scarlet Witch','Wanda','Maximoff',null,1),
	('M00015-Hulk','Bruce','Banner',null,1),
	('M00016-Silver Server','Norrin','Radd',null,1);
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
	('M00003-Black-Bolt'	,'304789790','Syracuse','1989/01/25',3),
	('M00004-Lockjaw'		,'401231232','Syracuse','1990/03/24',4),
	('M00005-Blizzard'		,'512312323','Syracuse','1991/07/11',1),
	('M00006-Toro'			,'604590899','Syracuse','1985/09/17',2),
	('M00007-Banshee'		,'704919822','Syracuse','1974/10/09',3),
	('M00013-IceMan'		,'804912342','Syracuse','1987/12/29',1),
	('M00014-Scarlet Witch'	,'902349124','Syracuse','1985/07/31',1);
INSERT INTO College (CollegeId,CollegeName,CollegeDescription)
VALUES 
	('ECS','LCS College of Engineering & Computer Science','L.C. Smith College of Engineering and computer science Investment club. Open to all LCS students as well as guests.'),
	('LAW','College of LAW','College of LAW'),
	('NEW','NewHouse School of Public Communications','New House'),
	('EDU','School of Education','Eduction'),
	('MGM','School of Management','Management'),
	('ISC','iSchool of Information Studies','iSchool');
INSERT INTO StudentMajorAndMinorList (CollegeId,NTID,IsMajor)
VALUES 
	('ECS','M00001-Angel'		,1),
	('LAW','M00002-A-Bomb'		,1),
	('NEW','M00003-Black-Bolt'	,1),
	('EDU','M00004-Lockjaw'		,0),
	('ECS','M00005-Blizzard'	,0),
	('EDU','M00006-Toro'		,1),
	('LAW','M00007-Banshee'		,1);
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
	('CIS','675','Design And Alalysis of Algorithm',null),
	('CIS','623','Structure Programming And Formal method',null),
	('CIS','607','Mathematics in Computing',null),
	('CSE','775','Distribute Object',null),
	('CIS','681','Software Modeling And Alalysis',null),
	('CIS','776','Design Pattern',null),
	('CSE','581','Introduction Database and Management System',null),
	('LAW','814','Technology transfer',null),
	('LAW','903','Criminal Law Clinic',null),
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
	(402,100,3,2,1,null),
	(201,50	,5,2,0,null),
	(788,50	,7,2,1,null),
	(239,60	,8,2,0,null);
INSERT INTO CourseSchedule(SemesterInformation,InstructorNTID,CourseMeetingTime,CourseId,RoomId,OpenSeats)
VALUES 
	(1,'M00010-Jean'	,1,1,1,60),
	(1,'M00009-Wolerine',2,2,2,30),
	(1,'M00008-X Prof'	,3,3,1,70),
	(1,'M00008-X Prof'	,4,4,3,80),
	(2,'M00010-Jean'	,6,3,3,90),
	(2,'M00008-X Prof'	,5,7,4,50),
	(2,'M00011-Iron Man',2,5,5,50),
	(2,'M00011-Iron Man',3,6,6,50);
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
	('Tenure Professor'		,'Level 5 mutant',null,90000.00,50000.00,0);
INSERT INTO EmployeeInformation(NTID,EmployeeId ,YearlyPay,JobType)
VALUES
	('M00008-X Prof'		,'E00001',89722.65,5),
	('M00009-Wolerine'		,'E00002',59722.65,4),
	('M00010-Jean'			,'E00003',79722.65,5),
	('M00011-Iron Man'		,'E00004',69722.65,2),
	('M00015-Hulk'			,'E00005',69722.65,4),
	('M00016-Silver Server'	,'E00006',59722.65,3);
INSERT INTO BenefitsCostSelection(SelectionName)
VALUES	('Single'),('Family'),('op-out');
INSERT INTO BenefitsType(TypeName)
VALUES	('Health'),('Vision'),('Dental');
INSERT INTO BenefitsInformation(CostSelection,CostType,ItemCost)
VALUES	
	(1,1,1000.00),(1,2,1500.00),(1,3,500.00),
	(2,1,500.00),(2,2,1500.00),(2,3,400.00),
	(3,1,800.00),(3,2,1600.00),(3,3,200.00);
INSERT INTO EmployeeBenefits(NTID,BenefitsInformationId,TotalCost)
VALUES	
	('M00008-X Prof'	,1,1080.00),
	('M00009-Wolerine'	,3,540.00),
	('M00009-Wolerine'	,4,540.00),
	('M00011-Iron Man'	,5,1620.00),
	('M00015-Hulk'		,6,423.00),
	('M00015-Hulk'		,7,864.00);
