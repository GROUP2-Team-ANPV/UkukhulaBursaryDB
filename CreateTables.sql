CREATE TABLE [dbo].[Status](
	[ID] [int] PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	[Type] [varchar](20) NOT NULL
)
GO

CREATE TABLE [dbo].[Provinces] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [ProvinceName] [varchar](13) NOT NULL
)
GO

CREATE TABLE [dbo].[Race] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [RaceName] [varchar](8) NOT NULL
)
GO

CREATE TABLE [dbo].[DocumentType] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Type] [varchar](20) NOT NULL
)
GO

CREATE TABLE [dbo].[Role] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [RoleType] [varchar](20) NOT NULL
)
GO

CREATE TABLE [dbo].[ContactDetails](
	[ID] [int] Primary Key IDENTITY(1, 1) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[PhoneNumber] [varchar](13) NOT NULL,
)
GO

CREATE TABLE [dbo].[University](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] [varchar](120),
    [ProvinceID] [int] FOREIGN KEY REFERENCES [dbo].[Provinces](ID),    
    [ContactID] [int] FOREIGN KEY REFERENCES [dbo].[ContactDetails](ID)
)
GO

CREATE TABLE [dbo].[UniversityFundRequest](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [UniversityID] [int] FOREIGN KEY REFERENCES [dbo].[University](ID),
    [Motivation] [text],
    [DateCreated] [date] DEFAULT GETDATE(),
    [StatusID] [int] FOREIGN KEY REFERENCES [dbo].[Status](ID),
    [Comment] [varchar](255)
)
GO

CREATE TABLE [dbo].[BBDAllocation](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Budget] [money] NOT NULL,
    [RemainingBudget] [money] NOT NULL,
    [Year] [int],
)
GO

CREATE TABLE [dbo].[UniversityFundAllocation](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Budget] [money],
    [RemainingBudget] [money],
    [UniversityID] [int] FOREIGN KEY REFERENCES [dbo].[University](ID),
    [BBDAllocationID] [int] FOREIGN KEY REFERENCES [dbo].[BBDAllocation](ID)
)
GO

CREATE TABLE [dbo].[User](
    [ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [FirstName] [varchar](120) NOT NULL,
    [LastName] [varchar](120) NOT NULL,
    [ContactID] [int] FOREIGN KEY REFERENCES [dbo].[ContactDetails](ID),
    [RoleID] [int] FOREIGN KEY REFERENCES [dbo].[Role](ID)
)
GO

CREATE TABLE [dbo].[Department](
    [ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] [varchar](120) NOT NULL,
)
GO

CREATE TABLE [dbo].[Program](
    [ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [Name] [varchar](120) NOT NULL,
    [DepartmentID] [int] FOREIGN KEY REFERENCES [dbo].[Department](ID)
)
GO

CREATE TABLE [dbo].[UniversityUser](
    [UniversityID] [int] FOREIGN KEY REFERENCES [dbo].[University](ID),
    [UserID] [int] FOREIGN KEY REFERENCES [dbo].[User](ID),
    [DepartmentID] [int] FOREIGN KEY REFERENCES [dbo].[Department](ID)
)
GO

CREATE TABLE [dbo].[Gender](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY,
    [GenderName] [varchar](8) NOT NULL,
)
GO

CREATE TABLE [dbo].[Student] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY,
    [IDNumber] [char](13) NOT NULL,
    [BirthDate] [date] NOT NULL,
    [Age] AS (CONVERT(tinyint, DATEDIFF(DAY, [BirthDate], GETDATE()) / 365.25)) ,
    [GenderID] [INT] FOREIGN KEY REFERENCES [dbo].[Gender](ID),
    [UserID] [int] FOREIGN KEY REFERENCES [dbo].[User](ID),
    [RaceID] [int] FOREIGN KEY REFERENCES [dbo].[Race](ID),
    [ProgramID] [int] FOREIGN KEY REFERENCES [dbo].[Program](ID)
)
GO

CREATE TABLE [dbo].[UniversityStudentInformation](
    [UniversityID] [int] FOREIGN KEY REFERENCES [dbo].[University](ID),
    [StudentID] [int] FOREIGN KEY REFERENCES [dbo].[Student](ID),
    [DateCreated] [date] DEFAULT GETDATE(),
)
GO

CREATE TABLE [dbo].[StudentFundRequest] (
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Grade] [tinyint] NOT NULL,
    [Amount] [money] NOT NULL,
    [Motivation] [text],
    [ApplicationDate] [date] DEFAULT GETDATE(),
    [StatusID] [int] FOREIGN KEY REFERENCES [dbo].[Status],
    [Comment] [varchar](255) NOT NULL,
    [StudentID] [int] FOREIGN KEY REFERENCES [dbo].[Student](ID)
)
GO

CREATE TABLE [dbo].[Document](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY,
    [Document] [varchar](250) NOT NULL,
    [TypeID] [int] FOREIGN KEY REFERENCES [dbo].[DocumentType](ID),
    [RequestID] [int] FOREIGN KEY REFERENCES [dbo].[StudentFundRequest](ID),
)
GO

CREATE TABLE [dbo].[StudentFundAllocation](
    [ID] [int] IDENTITY(1, 1) PRIMARY KEY,
    [Amount] [money] NOT NULL,
    [Year] [int],
    [UniversityFundID] [int] FOREIGN KEY REFERENCES [dbo].[UniversityFundAllocation](ID),
    [RequestID] [int] FOREIGN KEY REFERENCES [dbo].[StudentFundRequest](ID),
)
GO



