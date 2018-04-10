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
	NumberOfAttempts			INT NOT NULL,
	ProfilePic					VARCHAR(200) NULL,
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
	BreweryProfileImg			VARCHAR(200) NULL,
	BreweryBackgroundImg		VARCHAR(200) NULL,
	BreweryHeaderImg			VARCHAR(200) NULL
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
	ABV							DECIMAL NULL,
	IBU							DECIMAL NULL,
	DateBrewed					date NOT NULL,
	BeerLabelImg				varchar(200) NULL,
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

/******************************************** GoldHorn Brewery Info ****************************************************************/

INSERT INTO Brewery VALUES ('Goldhorn', '1361 E 55th St.', 'Cleveland', 'OH', 'USA', '44103', 'A local Cleveland staple', '2010', 'http://www.ohiocraftbeer.org/wp-content/uploads/2016/01/Goldhorn_Header2-1.jpg','http://www.ohiocraftbeer.org/wp-content/uploads/2016/01/Goldhorn_Header1.jpg', 'http://www.ohiocraftbeer.org/wp-content/uploads/2015/12/OCBA_simplified_color.png')
INSERT INTO Beer VALUES ('1', 'Lagunitas', Null, 'Piney and resinous with classic West Coast citrus zing', '0', '6.2', '51.5', '2017-01-18', 'https://lagunitas.com/uploads/beers_landing/beer-landing-hitting-selves-waldos.png')
INSERT INTO Beer VALUES ('1', 'Back In Black', Null, 'Brewed like an American IPA but with the addition of rich, dark malts, this beer has all the flavor and hop character you expect with a smooth, mellow finish.', '0', '6.8', '65', '2017-11-18', 'http://21st-amendment.com/assets/backinblack_can_022113-230x409.png')
INSERT INTO Beer VALUES ('1', 'Breakside', Null, 'Golden IPA made with five different hops. Intense grapefruit and dank notes with a crisp finish.', '0', '6.2', '64', '2017-01-19', 'https://res.cloudinary.com/ratebeer/image/upload/w_120,c_limit/beer_139634.jpg')
INSERT INTO Beer VALUES ('1', 'Edward APA', Null, 'Aromatic and flowery, with impressions of citrus and pine', '0', '5.2', '85', '2017-10-01', 'https://i.pinimg.com/736x/0c/09/a3/0c09a3a75d02b72c6a1798013902b946.jpg')
INSERT INTO Beer VALUES ('1', 'Heady Topper', Null, 'Extremely pleasant hoppy taste with a light nodes of citrus. ', '0', '8.0', '75', '2016-01-18', 'https://cdn.beeradvocate.com/im/beers/16814.jpg')
INSERT INTO Beer VALUES ('1', 'Hofbrau Dunkel', Null, 'Pours dark amber, head slow to dissapate. Dark malt flavor is weak, mouthfeel is thin.', '0', '5.5', '62.5', '2017-01-18', 'https://beerconnoisseur.com/sites/default/files/styles/beer_page_245w/public/beer/hofbrau-dunkel-bc.jpg?itok=Xw1DoL1k')
INSERT INTO Beer VALUES ('1', 'Delirium Tremens', Null, 'Slightly malty, a nice touch of alcohol, spicy.', '0', '8.5', '65.5', '2017-01-18', 'https://drizly-products1.imgix.net/ci-delirium-tremens-cc7c777c5292a683.png?auto=format%2Ccompress&fm=jpeg&q=20')

/******************************************** GoldHorn Brewery Info ****************************************************************/



/******************************************** Great Lakes Brewery Info *************************************************************/

INSERT INTO Brewery VALUES ('Great Lakes Brewery', '2516 Market Ave.', 'Cleveland', 'OH', 'USA', '44113', 'Two Irish brothers with limited brewing experience. A city that shuttered its last production brewery in the early 80s. A neighborhood in serious need of a facelift. In 1986 when Patrick and Daniel Conway opened their fledgling operation in Clevelands Ohio City neighborhood, the odds were stacked against them. Fortunately, they surrounded themselves with a staff of passionate, knowledgeable people, and from the start committed themselves to bringing a sophisticated, diverse selection of craft beer to their home state. Two decades, multiple awards, and a whole lot of stories later, Pat and Dan Conway celebrate over two decades of brewing exceptional beer for their adventurous and discerning customers.', '1986', 'https://goo.gl/images/26Anur','https://goo.gl/images/FtYegH', 'https://goo.gl/images/Nxhzin')
INSERT INTO Beer VALUES (2, 'Dortmunder Gold', NULL, 'A smooth, award-winning (and deceptively unassuming) balance of sweet malt and dry hop flavors. Yes, its known for winning medals worldwide. But locally, its known as "Dort," our flagship lager that humbly maintains its smooth, balanced (and charmingly unpretentious) ways.', 1, 5.8, 30, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/dortmunder-fixed_1.png?itok=67hwPAVE')

/******************************************** Great Lakes Brewery Info *************************************************************/
SELECT * FROM Brewery

SELECT * FROM Beer