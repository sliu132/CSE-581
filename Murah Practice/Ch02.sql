Create Table Terms
(
	TermsID INT PRIMARY KEY auto_increment,
	TermsDescription NVARCHAR(100),
	TermsDueDays DATETIME,
);
Create TAble GLAccounts
(
	
);
Create Table Vendors
(
	VendorID INT IDENTITY(1,1) primary key not null,
	VendorName NVARCHAR(100),
	VendorAddress1 NVARCHAR(MAX),
	VendorAddress2 NVARCHAR(MAX),
	VendorCity VARCHAR(100),
	VendorState VARCHAR(100),
	VendorZipCode VARCHAR(20),
	VendorPhone VARCHAR(12),
	VendorContactLName VARCHAR(10),
	VendorContactFName VARCHAR(20),
	DefaultTermsID INT FOREIGN KEY REFERENCES Terms(TermsID),
	DefaultAccountNo INT
);
