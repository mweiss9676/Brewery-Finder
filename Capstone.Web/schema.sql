CREATE DATABASE BreweryDB;

GO

USE BreweryDB;

GO

BEGIN TRANSACTION

CREATE TABLE [dbo].[Users]
(
    [UserId]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [UserName]		            VARCHAR(MAX) NOT NULL, 
    [PasswordHash]              VARCHAR(MAX) NULL,
	[PasswordSalt]              VARCHAR(MAX) NULL, 
    [SecurityStamp]             VARCHAR(MAX) NULL,
	Role						VARCHAR(100) NOT NULL,
	UserEmail					VARCHAR(50) NOT NULL,
	FirstName					VARCHAR(100) NOT NULL, 
	LastName					VARCHAR(100) NOT NULL,
	UserAddress					VARCHAR(50) NOT NULL,
	UserCity					VARCHAR(50) NOT NULL,
	UserDistrict				VARCHAR(50) NOT NULL,
	UserCountry					VARCHAR(50) NOT NULL,
	UserPostalCode				VARCHAR(50) NOT NULL,
	NumberOfAttempts			int NOT NULL,
	ProfilePic					VARCHAR(50) NULL,
	Password1stAttempt			DATE NULL,
);

CREATE TABLE Role
(
	RoleId						INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Role						VARCHAR(100)          NOT NULL
);

CREATE TABLE [dbo].[UserRoles]
(
	[UserId]					INT,         
	[Role]						INT,        

	CONSTRAINT pk_UserRoles        PRIMARY KEY (UserId, Role),
	CONSTRAINT fk_UserRoles_UserId FOREIGN KEY (UserId) REFERENCES Users(UserId),
	CONSTRAINT fk_UserRoles_Role   FOREIGN KEY (Role)   REFERENCES Role(RoleId)
);

CREATE TABLE Brewery 
(
	BreweryId					INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BreweryName					VARCHAR(100) NOT NULL,
	BreweryAddress				VARCHAR(100) NOT NULL,
	BreweryCity					VARCHAR(100) NOT NULL,
	BreweryDistrict				VARCHAR(50) NOT NULL,
	BreweryCountry				VARCHAR(50) NOT NULL,
	BreweryPostalCode			VARCHAR(50) NOT NULL,
	History						VARCHAR(MAX) NOT NULL,
	YearFounded					INT NOT NULL,
	BreweryProfileImg			VARCHAR(50) NULL,
	BreweryBackgroundImg		VARCHAR(50) NULL,
	BreweryHeaderImg			VARCHAR(50) NULL
);

CREATE TABLE BeerTypes
(
	BeerTypeId					int identity(1,1) PRIMARY KEY,
	BeerType					varchar (50) NOT NULL,
	BeerTypeDescription			varchar(max) NULL,
);

CREATE TABLE Beer 
(
	BeerID						INT IDENTITY(1,1) PRIMARY KEY,
	BreweryId					INT NOT NULL FOREIGN KEY REFERENCES Brewery(BreweryId),
	BeerName					VARCHAR(100) NOT NULL,
	BeerTypeId					INT NULL FOREIGN KEY REFERENCES BeerTypes(BeerTypeId),
	BeerDescription				varchar(max) NULL,
	IsBestSeller				bit NULL,
	ABV							int NULL,
	IBU							int NULL,
	DateBrewed					date NOT NULL,
	BeerLabelImg				varchar(50) NULL,
	--Beer_Img_Name_2		varchar(50) NULL,
	--Beer_Img_Name_3		varchar(50) NULL	
);

CREATE TABLE BeerRating 
(
	BeerId						int FOREIGN KEY REFERENCES Beer(BeerId),
	BeerRating					int NOT NULL,
	BeerReview					varchar(max) NULL,
	UserId						int FOREIGN KEY REFERENCES Users(UserId),
);

CREATE TABLE BreweryRating
(
	UserId						int FOREIGN KEY REFERENCES Users(UserId),
	BreweryId					int FOREIGN KEY REFERENCES Brewery(BreweryId),
	BreweryRating				int NOT NULL,
	BreweryReview				varchar(max)
);

COMMIT TRANSACTION