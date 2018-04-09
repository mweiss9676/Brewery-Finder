CREATE DATABASE BreweryDB;

GO

USE BreweryDB;

GO

BEGIN TRANSACTION

CREATE TABLE [dbo].[Users]
(
    [UserId]		             INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [UserName]		             VARCHAR(MAX) NOT NULL, 
    [PasswordHash]               VARCHAR(MAX) NULL,
	[PasswordSalt]               VARCHAR(MAX) NULL, 
    [SecurityStamp]              VARCHAR(MAX) NULL,
	Role VARCHAR(100)            NOT NULL,
	User_Email VARCHAR(50)       NOT NULL,
	FirstName VARCHAR(100)       NOT NULL, 
	LastName  VARCHAR(100)       NOT NULL,
	User_Address VARCHAR(50)     NOT NULL,
	User_City VARCHAR(50)        NOT NULL,
	User_District VARCHAR(50)    NOT NULL,
	User_Country VARCHAR(50)     NOT NULL,
	User_PostalCode VARCHAR(50)  NULL,
	NumberOfAttempts int         NOT NULL,
	ProfilePic VARCHAR(50)       NULL,
	Password1stAttempt DATE      NULL,
);

CREATE TABLE Role
(
	RoleId INT IDENTITY(1,1)     NOT NULL PRIMARY KEY,
	Role   VARCHAR(100)          NOT NULL
);

CREATE TABLE [dbo].[UserRoles]
(
	[UserId] INT,         
	[Role]   INT,        

	CONSTRAINT pk_UserRoles        PRIMARY KEY (UserId, Role),
	CONSTRAINT fk_UserRoles_UserId FOREIGN KEY (UserId) REFERENCES Users(UserId),
	CONSTRAINT fk_UserRoles_Role   FOREIGN KEY (Role)   REFERENCES Role(RoleId)
);

CREATE TABLE Brewery 
(
	BreweryId INT IDENTITY(1,1)       NOT NULL PRIMARY KEY,
	Brewery_Name VARCHAR(100)         NOT NULL,
	Brewery_Address VARCHAR(100)      NOT NULL,
	Brewery_District VARCHAR(50)      NOT NULL,
	Brewery_Country VARCHAR(50)       NOT NULL,
	Brewery_PostalCode VARCHAR(50)    NOT NULL,
	History VARCHAR(MAX)              NOT NULL,
	Year_Founded VARCHAR(50)          NOT NULL,
	Brew_Img_Name_1 VARCHAR(50)       NULL,
	Brew_Img_Name_2 VARCHAR(50)       NULL,
	Brew_Img_Name_3 VARCHAR(50)       NULL
);

CREATE TABLE BeerTypes
(
	BeerTypeId		int identity(1,1) PRIMARY KEY,
	BeerType		varchar (50) NOT NULL,
	Description		varchar(max) NULL,
);

CREATE TABLE Beer 
(
	BeerID              INT IDENTITY(1,1) PRIMARY KEY,
	BreweryId           INT NOT NULL FOREIGN KEY REFERENCES Brewery(BreweryId),
	Beer_Name           VARCHAR(100) NOT NULL,
	BeerTypeId			INT NULL FOREIGN KEY REFERENCES BeerTypes(BeerTypeId),
	Description			varchar(max) NULL,
	IsBestSeller		bit NULL,
	ABV					int NULL,
	IBU					int NULL,
	DateBrewed			date NOT NULL,
	Beer_Img_Name_1		varchar(50) NULL,
	Beer_Img_Name_2		varchar(50) NULL,
	Beer_Img_Name_3		varchar(50) NULL	
);

CREATE TABLE Ratings 
(
	RatingId		INT IDENTITY(1,1) PRIMARY KEY,
	BeerId			int FOREIGN KEY REFERENCES Beer(BeerId),
	Rating			int NULL,
	Review			varchar(max) NULL,
	UserId			int FOREIGN KEY REFERENCES Users(UserId),
);

COMMIT TRANSACTION