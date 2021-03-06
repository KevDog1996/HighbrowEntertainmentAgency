USE [master]
GO

/****** Object:  Database [HighbrowEntertainmentAgency]    Script Date: 9/24/2021 9:12:40 PM ******/
CREATE DATABASE [HighbrowEntertainmentAgency]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HighbrowEntertainmentAgency', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighbrowEntertainmentAgency.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HighbrowEntertainmentAgency_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighbrowEntertainmentAgency_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HighbrowEntertainmentAgency].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ARITHABORT OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET  DISABLE_BROKER 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET RECOVERY FULL 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET  MULTI_USER 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET DB_CHAINING OFF 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET QUERY_STORE = OFF
GO

ALTER DATABASE [HighbrowEntertainmentAgency] SET  READ_WRITE 
GO
USE HighbrowEntertainmentAgency
GO

CREATE TABLE Agents
(
AgentID varchar(4) CHECK (AgentID like 'A%') NOT NULL UNIQUE,
AgentFirstName varchar(50) NOT NULL,
AgentLastName varchar(50) NOT NULL,
AgentAddress varchar(50) NOT NULL,
AgentCity varchar(50) NOT NULL,
AgentState varchar(2) NOT NULL,
AgentZip int NOT NULL,
AgentPhone varchar(10) NOT NULL,
DateHired date NOT NULL,
Salary money NOT NULL,
CommissionRate double precision NOT NULL,
CONSTRAINT PK_Agents Primary Key (AgentID),
);
GO

CREATE TABLE Customers
(
CustID varchar(8) CHECK (CustID like 'C%') NOT NULL UNIQUE,
CustFirstName varchar(50) NOT NULL,
CustLastName varchar(50) NOT NULL,
CustAddress varchar(50) NOT NULL,
CustAptNum varchar(50) NULL,
CustState char(2) NOT NULL,
CustAreaCode varchar(10) NOT NULL,
CustPhoneNum varchar(50) NOT NULL,
CONSTRAINT PK_Customers PRIMARY KEY (CustID)
);
GO


CREATE TABLE Groups
( 
GroupID varchar(8) CHECK (GroupID like 'G%') NOT NULL UNIQUE,
GroupStageName char(100) NOT NULL,
GroupSSN varchar(11) UNIQUE NOT NULL,
GroupAddress varchar(100) NOT NULL,
GroupState char(2) NOT NULL,
GroupZip int NOT NULL,
GroupPhone varchar(8) UNIQUE NOT NULL,
GroupPage varchar(50) NULL,
GroupEmail varchar(100) NULL,
GroupDateEntered date NOT NULL,
CONSTRAINT PK_Groups PRIMARY KEY (GroupID)
);
GO

CREATE TABLE Performers
(
PerfID VARCHAR (8) CHECK (PerfID like 'P%') NOT NULL UNIQUE,
PerfFirstName VARCHAR(50) NOT NULL,
PerfLastName VARCHAR(50) NOT NULL,
PerfPhoneNumber VARCHAR(50) NOT NULL,
Gender CHARACTER(1) NOT NULL,
CONSTRAINT PK_Performers primary key (PerfID),
);
GO

CREATE TABLE MusicStyle
(
StyleID varchar(4) CHECK (StyleID like 'M%') NOT NULL UNIQUE,
StyleName varchar(50) NOT NULL,
CONSTRAINT PK_MusicStyle PRIMARY KEY (StyleID)
);
GO

Create Table Engagements
(
EngagementID VARCHAR(8) CHECK (EngagementID like 'EN%') NOT NULL UNIQUE,
StartDate SmallDateTime NOT NULL,
EndDate SmallDateTime NOT NULL,
ContractPrice Money NOT NULL,
CustID VarChar(8) NOT NULL,
AgentID VarChar(4) NOT NULL,
GroupID VarChar(8) NOT NULL,
Constraint PK_Engagements Primary Key(EngagementID),
Constraint FK_Customers Foreign Key(CustID) References Customers(CustID),
Constraint FK_Groups Foreign Key(GroupID) References Groups(GroupID),
Constraint FK_Agents Foreign Key(AgentID) References Agents(AgentID)
);
GO

CREATE TABLE GroupMemberList
(
GroupID varchar(8) CHECK (GroupID like 'G%') NOT NULL,
PerfID varchar(8) CHECK (PerfID like 'P%') NOT NULL,
Status int NOT NULL,
CONSTRAINT PK_GroupMemberList PRIMARY KEY(GroupID, PerfID),
CONSTRAINT FK_Groups2 FOREIGN KEY(GroupID) REFERENCES Groups(GroupID),
CONSTRAINT FK_Performers FOREIGN KEY(PerfID)  REFERENCES Performers(PerfID)
);
GO

CREATE TABLE MusicalPreferences
(
CustID varchar(8) CHECK (CustID like 'C%') NOT NULL,
StyleID varchar(4) CHECK (StyleID like 'M%') NOT NULL,
PreferenceRating int NOT NULL,
CONSTRAINT PK_MusicalPreferences PRIMARY KEY(CustID, StyleID),
CONSTRAINT FK_Customers2 FOREIGN KEY(CustID) REFERENCES Customers(CustID),
CONSTRAINT FK_MusicStyle FOREIGN KEY(StyleID) REFERENCES MusicStyle(StyleID)
);
GO

CREATE TABLE GroupByStyle
(
GroupID varchar(8) CHECK (GroupID like 'G%') NOT NULL,
StyleID varchar(4) CHECK (StyleID like 'M%') NOT NULL,
StyleStrength int NOT NULL,
CONSTRAINT PK_GroupByStyle PRIMARY KEY (GroupID,StyleID),
CONSTRAINT FK_Groups3 FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
CONSTRAINT FK_MusicStyle2 FOREIGN KEY (StyleID) REFERENCES MusicStyle(StyleID)

);
GO
Insert into Agents(AgentID,AgentFirstName,AgentLastName,AgentAddress,AgentCity,AgentState,AgentZip,AgentPhone,DateHired,Salary,CommissionRate)
Values
('A001','William','Thompson','122 Spring River Drive','Redmond','WA','98053','555-2681','1997-05-15',35000,0.04),
('A002','Scott','Bishop','66 Spring Valley Drive','Seattle','WA','98125','555-2666','1998-02-05',27000,0.04),
('A003','Carol','Viescas','667 Red River Road','Bellevue','WA','98006','555-2571','1997-11-19',30000,0.05),
('A004','Karen','Smith','30301 - 166th Ave. N.E.','Seattle','WA','98125','555-2551','1998-03-05',22000,0.055),
('A005','Marianne','Wier','908 W. Capital Way','Tacoma','WA','98413','555-2606','1998-02-02',24500,0.045),
('A006','John','Kennedy','16679 NE 41st Court','Seattle','WA','98125','555-2621','1997-05-15',33000,0.06),
('A007','Caleb','Viescas','4501 Wetland Road','Redmond','WA','98052','555-0037','1998-02-16',22100,0.035),
('A008','Maria','Patterson','3445 Cheyenne Road','Bellevue','WA','98006','555-2291','1997-09-03',30000,0.04),
('A009','Darryl','Mars','1234 Main Street','Kirkland','WA','98033','555-1234','2000-02-05',50,0.01)
Go

Insert into MusicStyle
Values
('M001','40''s Ballroom Music'),
('M002','50''s Music'),
('M003','60''s Music'),
('M004','70''s Music'),
('M005','80''s Music'),
('M006','Country'),
('M007','Classical'),
('M008','Classic Rock & Roll'),
('M009','Rap'),
('M010','Contemporary'),
('M011','Country Rock'),
('M012','Elvis'),
('M013','Folk'),
('M014','Chamber Music'),
('M015','Jazz'),
('M016','Karaoke'),
('M017','Motown'),
('M018','Modern Rock'),
('M019','Rhythm and Blues'),
('M020','Show Tunes'),
('M021','Standards'),
('M022','Top 40 Hits'),
('M023','Variety'),
('M024','Salsa'),
('M025','90''s Music')

Insert into Customers(CustID,CustFirstName,CustLastName,CustAddress,CustState,CustAreaCode,CustPhoneNum)
Values
('C000001','Doris','Hartwig','4726 - 11th Ave. N.E. Seattle','WA','98105','555-2671'),
('C000002','Deb','Waldal','908 W. Capital Way Tacoma','WA','98413','555-2496'),
('C000003','Peter','Brehm','722 Moss Bay Blvd. Kirkland','WA','98033','555-2501'),
('C000004','Dean','McCrae','4110 Old Redmond Rd. Redmond','WA','98052','555-2506'),
('C000005','Elizabeth','Hallmark','Route 2, Box 203B Auburn','WA','98002','555-2521'),
('C000006','Matt','Berg','908 W. Capital Way Tacoma','WA','98413','555-2581'),
('C000007','Liz','Keyser','13920 S.E. 40th Street Bellevue,','WA','98006','555-2556'),
('C000008','Darren','Gehring','2601 Seaview Lane Kirkland','WA','98033','555-2616'),
('C000009','Sarah','Thompson','2222 Springer Road Bellevue','WA','98006','555-2626'),
('C000010','Zachary','Ehrlich','12330 Kingman Drive Kirkland','WA','98033','555-2721'),
('C000011','Joyce','Bonnicksen','2424 Thames Drive Bellevue','WA','98006','555-2726'),
('C000012','Kerry','Patterson','777 Fenexet Blvd Redmond','WA','98052','555-0399'),
('C000013','Estella','Pundt','2500 Rosales Lane Bellevue','WA','98006','555-9938'),
('C000014','Mark','Rosales','323 Advocate Lane Bellevue','WA','98006','555-2286'),
('C000015','Carol','Viescas','754 Fourth Ave Seattle','WA','98115','555-2296');

Go

Insert into Groups(GroupID,GroupStageName,GroupSSN,GroupAddress,GroupState,GroupZip,GroupPhone,GroupPage,GroupEmail,GroupDateEntered)
Values
('G001','Carol Peacock Trio','888-90-1121','4110 Old Redmond Rd. Redmond','WA','98052','555-2691','www.cptrio.com','carolp@cptrio.com','1997-05-24'),
('G002','Topazz','888-50-1061','16 Maple Lane Auburn','WA','98002','555-2591','www.topazz.com','','1996-02-14'),
('G003','JV & the Deep Six','888-18-1013','15127 NE 24th #383 Redmond','WA','98052','555-2511','www.jvd6.com','jv@myspring.com','1998-03-18'),
('G004','Jim Glynn','888-26-1025','13920 S.E. 40th Street Bellevue','WA','98009','555-2531','','','1996-04-01'),
('G005','Jazz Persuasion','888-30-1031','233 West Valley Hwy Bellevue','WA','98005','555-2541','www.jazzper.com','','1997-05-12'),
('G006','Modern Dance','888-66-1085','Route 2 Box 203B Woodinville','WA','98072','555-2631','www.moderndance.com','mikeh@moderndance.com','1995-05-16'),
('G007','Coldwater Cattle Company','888-38-1043','4726 - 11th Ave. N.E. Seattle','WA','98105','555-2561','www.coldwatercows.com','','1995-11-30'),
('G008','Country Feeling','888-98-1133','PO Box 223311 Seattle','WA','98125','555-2711','','','1996-02-28'),
('G009','Katherine Ehrlich','888-61-1103','777 Fenexet Blvd Woodinville','WA','98072','555-0399','','ke@mzo.com','1998-09-13'),
('G010','Saturday Revue','888-64-1109','3887 Easy Street Seattle','WA','98125','555-0039','www.satrevue.com','edz@coolness.com','1995-01-20'),
('G011','Julia Schnebly','888-65-1111','2343 Harmony Lane Seattle','WA','99837','555-9936','','','1996-04-12'),
('G012','Susan McLain','888-70-1121','511 Lenora Ave Bellevue','WA','98006','555-2301','www.greensleeves.com','susan@gs.com','1998-10-12'),
('G013','Caroline Coie Cuartet','888-71-1123','298 Forest Lane Auburn','WA','98002','555-2306','','carolinec@willow.com','1997-07-11');

Go

Insert into Performers(PerfID,PerfFirstName,PerfLastName,PerfPhoneNumber,Gender)
Values
('P001','David','Hamilton','555-2701','M'),
('P002','Suzanne','Viescas','555-2686','F'),
('P003','Gary','Hallmark','555-2676','M'),
('P004','Jeffrey','Smith','555-2596','M'),
('P005','Robert','Brown','555-2491','M'),
('P006','Mariya','Sergienko','555-2526','F'),
('P007','Sara','Sheskey','555-2566','F'),
('P008','Rachel','Patterson','555-2546','F'),
('P009','David','Viescas','555-2661','M'),
('P010','Manuela','Seidel','555-2641','F'),
('P011','Kathryn','Patterson','555-2651','F'),
('P012','Kendra','Bonnicksen','555-2716','F'),
('P013','Steve','Pundt','555-9938','M'),
('P014','George','Chavez','555-9930','M'),
('P015','Joe','Rosales','555-2281','M'),
('P016','Angel','Kennedy','555-2311','M'),
('P017','Luke','Patterson','555-2316','M'),
('P018','Janice','Galvin','555-2691','F'),
('P019','John','Viescas','555-2511','M'),
('P020','Michael','Hernandez','555-2711','M'),
('P021','Katherine','Ehrlich','555-0399','F'),
('P022','Julia','Schnebly','555-9936','F'),
('P023','Susan','McLain','555-2301','F'),
('P024','Caroline','Coie','555-2306','F'),
('P025','Jim','Glynn','555-2531','M');

Go

Insert into GroupMemberList(GroupID,PerfID,Status)
Values
('G001','P006',1),
('G001','P007',1),
('G001','P018',2),
('G002','P020',2),
('G002','P021',1),
('G003','P002',1),
('G003','P003',1),
('G003','P004',1),
('G003','P009',1),
('G003','P017',1),
('G003','P019',2),
('G004','P025',2),
('G005','P016',1),
('G005','P020',2),
('G005','P021',1),
('G006','P004',1),
('G006','P013',1),
('G006','P018',1),
('G006','P020',2),
('G007','P001',1),
('G007','P002',1),
('G007','P005',1),
('G007','P007',2),
('G007','P010',1),
('G008','P003',1),
('G008','P005',1),
('G008','P011',1),
('G008','P014',2),
('G008','P015',1),
('G009','P021',2),
('G010','P008',1),
('G010','P012',2),
('G010','P023',1),
('G010','P024',1),
('G011','P022',2),
('G012','P023',2),
('G013','P012',1),
('G013','P014',1),
('G013','P017',1),
('G013','P024',2);

GO 

Insert into MusicalPreferences(CustId,StyleId,PreferenceRating)
Values
('C000015','M010', 2 ),
('C000015','M022', 1 ),
('C000015','M003', 1 ),
('C000008','M008', 2 ),
('C000008','M017', 2 ),
('C000004','M019', 1 ),
('C000004','M015', 1 ),
('C000002','M021', 2 ),
('C000002','M007', 2 ),
('C000001','M014', 1 ),
('C000001','M013', 2 ),
('C000005','M023', 1 ),
('C000005','M004', 2 ),
('C000013','M008', 1 ),
('C000013','M019', 3 ),
('C000011','M010', 1 ),
('C000011','M021', 2 ),
('C000011','M006', 2 ),
('C000012','M011', 1 ),
('C000012','M018', 3 ),
('C000007','M015', 2 ),
('C000007','M019', 1 ),
('C000007','M024', 3 ),
('C000014','M001', 2 ),
('C000014','M007', 3 ),
('C000014','M021', 1 ),
('C000006','M010', 2 ),
('C000006','M020', 1 ),
('C000003','M015', 1 ),
('C000003','M024', 2 ),
('C000009','M005', 3 ),
('C000009','M018', 2 ),
('C000009','M022', 1 ),
('C000010','M001', 3 ),
('C000010','M020', 2 ),
('C000010','M021', 1 );

Go

Insert Into Engagements(EngagementID,StartDate,EndDate,ContractPrice,CustID,AgentID,GroupID)
Values
('EN0002','09/02/2017 13:00:00','09/06/2017 15:00:00',200,'C000006','A004','G004'),
('EN0003','09/11/2017 13:00:00','09/16/2017 15:00:00',590,'C000001','A003','G005'),
('EN0004','09/12/2017 20:00:00','09/18/2017 00:00:00',470,'C000007','A003','G004'),
('EN0005','09/12/2017 16:00:00','09/15/2017 19:00:00',1130,'C000006','A005','G003'),
('EN0006','09/11/2017 15:00:00','09/15/2017 21:00:00',2300,'C000014','A007','G008'),
('EN0007','09/12/2017 17:00:00','09/19/2017 20:00:00',770,'C000004','A004','G002'),
('EN0008','09/19/2017 20:00:00','09/26/2017 23:00:00',1850,'C000006','A003','G007'),
('EN0009','09/19/2017 19:00:00','09/29/2017 21:00:00',1370,'C000010','A002','G010'),
('EN0010','09/18/2017 13:00:00','09/27/2017 17:00:00',3650,'C000005','A003','G003'),
('EN0011','09/16/2017 18:00:00','09/17/2017 00:00:00',950,'C000005','A004','G008'),
('EN0012','09/19/2017 18:00:00','09/27/2017 22:00:00',1670,'C000014','A008','G001'),
('EN0013','09/18/2017 20:00:00','09/21/2017 23:00:00',770,'C000003','A001','G006'),
('EN0014','09/25/2017 16:00:00','09/30/2017 22:00:00',2750,'C000001','A001','G008'),
('EN0015','09/25/2017 17:00:00','09/30/2017 19:00:00',770,'C000007','A001','G013'),
('EN0016','10/03/2017 20:00:00','10/07/2017 01:00:00',1550,'C000010','A005','G013'),
('EN0017','09/30/2017 18:00:00','10/03/2017 20:00:00',530,'C000002','A008','G010'),
('EN0019','09/30/2017 20:00:00','10/06/2017 23:00:00',365,'C000009','A008','G004'),
('EN0021','10/01/2017 12:00:00','10/04/2017 16:00:00',1490,'C000005','A001','G003'),
('EN0022','10/01/2017 12:00:00','10/06/2017 15:00:00',590,'C000004','A005','G002'),
('EN0023','10/01/2017 20:00:00','10/01/2017 00:00:00',290,'C000012','A004','G013'),
('EN0024','10/02/2017 12:00:00','10/08/2017 18:00:00',1940,'C000001','A004','G001'),
('EN0026','10/10/2017 17:00:00','10/15/2017 22:00:00',950,'C000001','A006','G002'),
('EN0027','10/08/2017 12:00:00','10/13/2017 16:00:00',2210,'C000015','A007','G003'),
('EN0028','10/07/2017 17:00:00','10/16/2017 22:00:00',3800,'C000003','A004','G007'),
('EN0030','10/07/2017 17:00:00','10/09/2017 22:00:00',275,'C000009','A005','G011'),
('EN0031','10/08/2017 16:00:00','10/17/2017 20:00:00',2450,'C000002','A008','G010'),
('EN0032','10/08/2017 13:00:00','10/17/2017 15:00:00',1250,'C000010','A007','G013'),
('EN0034','10/15/2017 16:00:00','10/21/2017 18:00:00',680,'C000004','A008','G005'),
('EN0035','10/15/2017 19:00:00','10/16/2017 23:00:00',410,'C000005','A008','G001'),
('EN0036','10/14/2017 18:00:00','10/24/2017 22:00:00',710,'C000014','A003','G011'),
('EN0037','10/14/2017 14:00:00','10/20/2017 19:00:00',2675,'C000006','A003','G008'),
('EN0038','10/15/2017 14:00:00','10/19/2017 20:00:00',1850,'C000013','A004','G006'),
('EN0041','10/21/2017 18:00:00','10/29/2017 21:00:00',860,'C000013','A003','G002'),
('EN0042','10/21/2017 17:00:00','10/27/2017 22:00:00',2150,'C000002','A001','G013'),
('EN0043','10/22/2017 14:00:00','10/22/2017 16:00:00',140,'C000001','A008','G001'),
('EN0044','10/23/2017 14:00:00','10/27/2017 19:00:00',1925,'C000006','A003','G008'),
('EN0045','10/22/2017 14:00:00','10/29/2017 18:00:00',530,'C000015','A001','G012'),
('EN0046','10/29/2017 15:00:00','11/06/2017 17:00:00',1400,'C000009','A004','G008'),
('EN0048','11/06/2017 16:00:00','11/07/2017 22:00:00',950,'C000002','A001','G007'),
('EN0049','11/14/2017 12:00:00','11/20/2017 14:00:00',680,'C000014','A005','G001'),
('EN0051','11/14/2017 20:00:00','11/15/2017 01:00:00',650,'C000013','A003','G013'),
('EN0052','11/14/2017 16:00:00','11/15/2017 21:00:00',650,'C000010','A003','G006'),
('EN0053','11/12/2017 17:00:00','11/13/2017 19:00:00',350,'C000002','A005','G007'),
('EN0055','11/20/2017 20:00:00','11/27/2017 02:00:00',770,'C000002','A003','G011'),
('EN0056','11/26/2017 14:00:00','11/29/2017 19:00:00',1550,'C000010','A003','G007'),
('EN0058','12/02/2017 17:00:00','12/05/2017 23:00:00',770,'C000001','A002','G002'),
('EN0059','12/02/2017 15:00:00','12/05/2017 19:00:00',290,'C000004','A006','G012'),
('EN0060','12/03/2017 13:00:00','12/05/2017 17:00:00',230,'C000010','A008','G004'),
('EN0061','12/04/2017 17:00:00','12/11/2017 20:00:00',410,'C000015','A008','G011'),
('EN0062','12/10/2017 20:00:00','12/11/2017 01:00:00',500,'C000003','A002','G005'),
('EN0063','12/19/2017 14:00:00','12/22/2017 16:00:00',650,'C000009','A003','G008'),
('EN0064','12/26/2017 14:00:00','01/04/2018 16:00:00',1250,'C000007','A003','G013'),
('EN0066','12/23/2017 20:00:00','12/30/2017 02:00:00',2930,'C000005','A005','G006'),
('EN0068','12/25/2017 16:00:00','12/30/2017 22:00:00',1670,'C000009','A001','G005'),
('EN0069','12/23/2017 15:00:00','12/24/2017 18:00:00',500,'C000004','A007','G008'),
('EN0070','12/24/2017 13:00:00','12/27/2017 15:00:00',410,'C000010','A006','G001'),
('EN0071','12/23/2017 14:00:00','12/28/2017 17:00:00',1670,'C000002','A001','G003'),
('EN0072','12/23/2017 20:00:00','01/02/2018 01:00:00',875,'C000012','A004','G011'),
('EN0073','12/30/2017 19:00:00','01/08/2018 22:00:00',1400,'C000014','A005','G001'),
('EN0074','01/02/2018 13:00:00','01/07/2018 15:00:00',590,'C000004','A001','G005'),
('EN0075','01/02/2018 17:00:00','01/12/2018 20:00:00',2525,'C000001','A007','G007'),
('EN0076','12/31/2017 16:00:00','01/04/2018 22:00:00',500,'C000005','A007','G012'),
('EN0077','12/31/2017 17:00:00','01/05/2018 20:00:00',1670,'C000015','A005','G003'),
('EN0078','01/02/2018 16:00:00','01/04/2018 20:00:00',770,'C000010','A004','G010'),
('EN0079','12/31/2017 12:00:00','01/04/2018 17:00:00',1550,'C000006','A008','G006'),
('EN0080','01/01/2018 17:00:00','01/02/2018 21:00:00',650,'C000002','A005','G008'),
('EN0081','01/02/2018 13:00:00','01/10/2018 17:00:00',1130,'C000013','A004','G002'),
('EN0082','01/09/2018 20:00:00','01/10/2018 01:00:00',950,'C000014','A008','G003'),
('EN0083','01/07/2018 13:00:00','01/11/2018 15:00:00',650,'C000010','A002','G006'),
('EN0084','01/07/2018 17:00:00','01/12/2018 19:00:00',230,'C000007','A003','G012'),
('EN0085','01/07/2018 14:00:00','01/09/2018 19:00:00',1175,'C000015','A004','G008'),
('EN0087','01/05/2018 16:00:00','01/07/2018 19:00:00',275,'C000007','A006','G008'),
('EN0088','01/08/2018 12:00:00','01/18/2018 14:00:00',1370,'C000004','A008','G013'),
('EN0089','01/07/2018 14:00:00','01/08/2018 16:00:00',290,'C000003','A008','G010'),
('EN0090','01/09/2018 20:00:00','01/09/2018 02:00:00',320,'C000006','A005','G001'),
('EN0091','01/06/2018 13:00:00','01/13/2018 19:00:00',770,'C000009','A003','G004'),
('EN0092','01/13/2018 19:00:00','01/17/2018 00:00:00',1925,'C000012','A006','G008'),
('EN0095','01/16/2018 20:00:00','01/19/2018 01:00:00',1550,'C000010','A006','G007'),
('EN0096','01/23/2018 15:00:00','02/01/2018 17:00:00',950,'C000009','A006','G005'),
('EN0097','01/20/2018 17:00:00','01/20/2018 21:00:00',110,'C000012','A008','G004'),
('EN0098','01/21/2018 20:00:00','01/28/2018 02:00:00',2930,'C000012','A002','G010'),
('EN0099','01/23/2018 14:00:00','02/23/2018 20:00:00',14105,'C000005','A006','G008'),
('EN0100','01/20/2018 12:00:00','01/24/2018 18:00:00',1850,'C000015','A003','G006'),
('EN0101','01/23/2018 14:00:00','01/31/2018 18:00:00',1670,'C000004','A005','G001'),
('EN0102','01/23/2018 12:00:00','02/01/2018 15:00:00',2300,'C000013','A005','G007'),
('EN0103','01/22/2018 12:00:00','01/28/2018 17:00:00',575,'C000010','A004','G011'),
('EN0104','01/29/2018 13:00:00','02/02/2018 16:00:00',1400,'C000010','A006','G003'),
('EN0105','01/28/2018 12:00:00','02/02/2018 17:00:00',1850,'C000002','A004','G013'),
('EN0106','01/30/2018 15:00:00','02/02/2018 18:00:00',770,'C000003','A006','G006'),
('EN0107','01/30/2018 16:00:00','01/31/2018 21:00:00',200,'C000007','A004','G004'),
('EN0108','02/03/2018 18:00:00','02/05/2018 00:00:00',320,'C000004','A005','G012'),
('EN0109','02/12/2018 13:00:00','02/16/2018 19:00:00',1850,'C000014','A005','G010'),
('EN0110','02/12/2018 15:00:00','02/20/2018 19:00:00',1670,'C000006','A008','G001'),
('EN0111','02/13/2018 15:00:00','02/15/2018 18:00:00',185,'C000012','A001','G004'),
('EN0112','02/20/2018 18:00:00','02/25/2018 22:00:00',410,'C000015','A007','G011'),
('EN0114','02/20/2018 12:00:00','03/01/2018 17:00:00',1550,'C000005','A001','G002'),
('EN0115','02/20/2018 12:00:00','02/23/2018 18:00:00',1490,'C000007','A005','G013'),
('EN0116','02/17/2018 14:00:00','02/26/2018 19:00:00',800,'C000003','A006','G012'),
('EN0118','02/19/2018 19:00:00','02/19/2018 00:00:00',350,'C000014','A001','G010'),
('EN0119','02/20/2018 18:00:00','03/01/2018 21:00:00',500,'C000012','A002','G004'),
('EN0120','02/18/2018 20:00:00','02/21/2018 23:00:00',950,'C000002','A007','G008'),
('EN0121','02/17/2018 17:00:00','02/23/2018 23:00:00',2570,'C000004','A003','G006'),
('EN0122','02/25/2018 15:00:00','02/28/2018 19:00:00',1010,'C000014','A005','G010'),
('EN0123','02/26/2018 16:00:00','03/01/2018 20:00:00',770,'C000013','A001','G001'),
('EN0124','02/24/2018 14:00:00','03/03/2018 17:00:00',1850,'C000006','A001','G008'),
('EN0125','02/24/2018 13:00:00','03/01/2018 15:00:00',1130,'C000001','A003','G003'),
('EN0126','02/25/2018 18:00:00','03/04/2018 20:00:00',1010,'C000009','A006','G006'),
('EN0127','02/25/2018 20:00:00','03/01/2018 22:00:00',500,'C000010','A004','G005'),
('EN0128','02/27/2018 19:00:00','03/01/2018 01:00:00',320,'C000003','A004','G011'),
('EN0129','02/25/2018 17:00:00','03/06/2018 21:00:00',2450,'C000004','A005','G013'),
('EN0131','03/04/2018 15:00:00','03/13/2018 17:00:00',1850,'C000014','A001','G003');

insert into GroupByStyle
Values
('G001','M010',2),
('G001','M020',1),
('G001','M021',3),
('G002','M017',2),
('G002','M019',1),
('G002','M023',3),
('G003','M003',1),
('G003','M008',2),
('G004','M013',1),
('G005','M015',3),
('G005','M019',1),
('G005','M024',2),
('G006','M022',3),
('G006','M023',1),
('G006','M024',2),
('G007','M006',2),
('G007','M011',1),
('G008','M003',2),
('G008','M006',1),
('G009','M007',2),
('G009','M014',1),
('G009','M021',3),
('G010','M004',2),
('G010','M021',3),
('G010','M001',1),
('G011','M007',2),
('G011','M014',1),
('G011','M020',3),
('G012','M007',2),
('G012','M013',1),
('G013','M010',2),
('G013','M015',1)