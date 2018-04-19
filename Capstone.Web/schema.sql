CREATE DATABASE BreweryDB;

GO

USE BreweryDB;

GO

BEGIN TRANSACTION

CREATE TABLE [dbo].[Users]
(
    [UserId]					UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY, 
    [UserName]		            VARCHAR(MAX) NOT NULL, 
    [PasswordHash]              VARCHAR(MAX) NULL,
	[PasswordSalt]              VARCHAR(MAX) NULL, 
    [SecurityStamp]             VARCHAR(MAX) NULL,	
	Password1stAttempt			DATE NULL,
    NumberOfAttempts			INT NULL,
);

CREATE TABLE [dbo].[UserRoles]
(
	[UserId]					UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Users(UserId), 
	[Role]						VARCHAR(100)		NOT NULL,        
);

CREATE TABLE Brewery 
(
	BreweryId					INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UserId						UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Users(UserId),
	BreweryName					VARCHAR(100) NOT NULL,
	BreweryAddress				VARCHAR(100) NOT NULL,
	BreweryCity					VARCHAR(100) NOT NULL,
	BreweryDistrict				VARCHAR(50) NOT NULL,
	BreweryCountry				VARCHAR(50) NOT NULL,
	BreweryPostalCode			VARCHAR(50) NOT NULL,
	History						VARCHAR(MAX) NOT NULL,
	YearFounded					INT NOT NULL,
	HoursOfOperation			VARCHAR(MAX) NOT NULL,
	Email						VARCHAR(200) NOT NULL,
	Phone						VARCHAR(20) NOT NULL,
	BreweryProfileImg			VARCHAR(200) NULL,
	BreweryBackgroundImg		VARCHAR(200) NULL,
	BreweryHeaderImg			VARCHAR(200) NULL,
	BreweryLatitude             VARCHAR(20)	NULL,
	BreweryLongitude			VARCHAR(20) NULL
);

CREATE TABLE BeerTypes
(
	BeerTypeId					int identity(1,1) NOT NULL PRIMARY KEY,
	BeerType					varchar (50) NOT NULL,
	BeerTypeDescription			varchar(max) NULL,
);

CREATE TABLE Beer 
(
	BeerID						INT IDENTITY(1,1) PRIMARY KEY,
	BreweryId					INT NOT NULL FOREIGN KEY REFERENCES Brewery(BreweryId),
	BeerName					VARCHAR(100) NOT NULL,
	BeerTypeId					INT NOT NULL FOREIGN KEY REFERENCES BeerTypes(BeerTypeId),
	BeerDescription				varchar(max) NULL,
	IsBestSeller				bit NULL,
	ABV							DECIMAL (10,1) NULL,
	IBU							INT NULL,
	DateBrewed					date NULL,
	BeerLabelImg				varchar(200) NULL,
);

CREATE TABLE BeerRating 
(
	BeerId						int FOREIGN KEY REFERENCES Beer(BeerId),
	BeerRating					int NOT NULL,
	UserId						uniqueidentifier FOREIGN KEY REFERENCES Users(UserId),
);

CREATE TABLE BreweryRating
(
	UserId						uniqueidentifier FOREIGN KEY REFERENCES Users(UserId),
	BreweryId					int FOREIGN KEY REFERENCES Brewery(BreweryId),
	BreweryRating				int NULL,
);

COMMIT TRANSACTION

/**********************************************Users Table Inserts*******************************************************************/

INSERT INTO Users VALUES(CAST('ADA6646D-0B7D-4046-BC40-262AE935DCA9' AS UNIQUEIDENTIFIER), 'Enthusiast@email.com', 'AOzBbhpRPO8vFLAnAO+XJNQEvO1xOjRe568Bo9vvLaqB5SIpcjsysqIdlgbVu5TkIg==', NULL, '05fbf182-729d-4bef-9d38-85b7f5223386', NULL, NULL);
INSERT INTO Users VALUES(CAST('7EB3ACB7-3EAF-4CFE-91AD-12C8551F4B65' AS UNIQUEIDENTIFIER), 'brewer@email.com', 'AGUEftvxi0cgNpIG6oaqabsTdY5c4Y0XR7D1tB7ZkKWselt2rzb3FyX51zw+nNLzug==', NULL, '016c150a-7b11-4450-9b10-9ba0076ce42a', NULL, NULL);
INSERT INTO Users VALUES(CAST('2BF6CE16-54D4-463D-8CA3-AF223ABC1AC6' AS UNIQUEIDENTIFIER), 'brewer2@email.com', 'AHt9DuPNSYc2R+QFMzAlI0XrEwEm2oqJ15pd3ogehPYN9sC0LJptEROyFuII7ZDM7g==', NULL, 'e2ce4bd4-f69e-425a-ad04-72c181df50b0', NULL, NULL);
INSERT INTO Users VALUES(CAST('B6CA7E03-DB49-4DE2-9D76-0E5C19E311B7' AS UNIQUEIDENTIFIER), 'brewer3@email.com', 'AEWJK5qvoPBAj1/JiUKrivsKKS47tBkhfMMgq1H8qicVMNjsWwO7mg/bgJRmZLON0A==', NULL, 'b37ee4fd-a2cd-4d03-91f5-08c3d29e79e1', NULL, NULL);
INSERT INTO Users VALUES(CAST('2CFDFB56-A764-4AC3-B869-CFB602A0253E' AS UNIQUEIDENTIFIER), 'admin@email.com', 'ANywu2sUIuRuX6Fo+nczT1vBr/IdxEHCZcN5zIjbghgZ+YRk+AdL6WGRLWnYdAKVgA==', NULL, '5f3a729b-cf11-4a3c-afa0-3185377baa13', NULL, NULL);

INSERT INTO UserRoles VALUES ('ADA6646D-0B7D-4046-BC40-262AE935DCA9', 'Enthusiast')
INSERT INTO UserRoles VALUES ('7EB3ACB7-3EAF-4CFE-91AD-12C8551F4B65', 'Brewer')
INSERT INTO UserRoles VALUES ('2BF6CE16-54D4-463D-8CA3-AF223ABC1AC6', 'Brewer')
INSERT INTO UserRoles VALUES ('B6CA7E03-DB49-4DE2-9D76-0E5C19E311B7', 'Brewer')
INSERT INTO UserRoles VALUES ('2CFDFB56-A764-4AC3-B869-CFB602A0253E', 'Admin')

/**********************************************Users Table Inserts*******************************************************************/

/******************************************** BeerTypes Table Inserts **************************************************************/
INSERT INTO BeerTypes VALUES ('Altbier','Altbier is usually a dark copper colour. It is fermented at a moderate temperature using a top-fermenting yeast which gives its flavour some fruitiness, but matured at a cooler temperature, which gives it a cleaner and crisper taste more akin to lager beer styles than is the norm for top-fermented beers, such as British pale ale')
INSERT INTO BeerTypes VALUES ('Amber Ale','Amber Ale is a term used in Australia, France and North America for pale ales brewed with a proportion of amber malt and sometimes crystal malt to produce an amber color generally ranging from light copper to light brown. A small amount of crystal or other colored malt is added to the basic pale ale base to produce a slightly darker color, as in some Irish and British pale ales. In France the term "ambrée" is used to signify a beer, either cold or warm fermented, which is amber in color; the beer, as in Pelforth Ambrée and Fischer Amber, may be a Vienna lager, or it may be a Bière de Garde as in Jenlain Ambrée. In North America, American-variety hops are used in varying degrees of bitterness, although very few examples are particularly hoppy. In Australia the most popular Amber Ale is from Malt Shovel Brewery, branded James Squire in honour of Australias first brewer, who first brewed beer in Sydney in 1794')
INSERT INTO BeerTypes VALUES ('Blonde Ale','Blonde ales are very pale in color. The term "blonde" for pale beers is common in Europe and South America – particularly in France, Belgium, the UK, and Brazil – though the beers may not have much in common, other than color. Blondes tend to be clear, crisp, and dry, with low-to-medium bitterness and aroma from hops, and some sweetness from malt. Fruitiness from esters may be perceived. A lighter body from higher carbonation may be noticed. In the United Kingdom, golden or summer ales were developed in the late 20th century by breweries to compete with the pale lager market. A typical golden ale has an appearance and profile similar to that of a pale lager. Malt character is subdued and the hop profile ranges from spicy to citrus; common hops include Styrian Golding and Cascade. Alcohol is in the 4% to 5% abv range.')
INSERT INTO BeerTypes VALUES ('Bock','Bock is a strong lager of German origin. Several substyles exist, including maibock (helles bock, heller bock), a paler, more hopped version generally made for consumption at spring festivals; doppelbock (double bock), a stronger and maltier version; and eisbock, a much stronger version made by partially freezing the beer and removing the ice that forms. Originally a dark beer, a modern bock can range from light copper to brown in colour')
INSERT INTO BeerTypes VALUES ('Brown Ale','Brown ale is a style of beer with a dark amber or brown colour. The term was first used by London brewers in the late 17th century to describe their products, such as mild ale,[1] though the term had a rather different meaning than it does today. 18th-century brown ales were lightly hopped and brewed from 100% brown malt.')
INSERT INTO BeerTypes VALUES ('Cream Ale','Cream ale is a style of American and Canadian beer, of which examples are often light in color and are well attenuated')
INSERT INTO BeerTypes VALUES ('Doppelbock','Doppelbock or double bock is a stronger version of traditional bock that was first brewed in Munich by the Paulaner Friars, a Franciscan order founded by St. Francis of Paula. Historically, doppelbock was high in alcohol and sweet, thus serving as "liquid bread" for the Friars during times of fasting, when solid food was not permitted. Today, doppelbock is still strong—ranging from 7%–12% or more by volume. It isnt clear, with color ranging from dark gold, for the paler version, to dark brown with ruby highlights for darker version. It has a large, creamy, persistent head (although head retention may be impaired by alcohol in the stronger versions). The aroma is intensely malty, with some toasty notes, and possibly some alcohol presence as well; darker versions may have a chocolate-like or fruity aroma. The flavor is very rich and malty, with toasty notes and noticeable alcoholic strength, and little or no detectable hops (16–26 IBUs).')
INSERT INTO BeerTypes VALUES ('Dunkel','Dunkel, or Dunkles, is a word used for several types of dark German lager. Dunkel is the German word meaning dark, and dunkel beers typically range in color from amber to dark reddish brown. They are characterized by their smooth malty flavor. In informal terms, such as when ordering at a bar, "dunkel" is likely to mean whatever dark beer the bar has on tap, or sells most of; in much of north and western Germany, especially near Düsseldorf, this may be altbier.')
INSERT INTO BeerTypes VALUES ('Dunkelweizen','A dark wheat weizenbier')
INSERT INTO BeerTypes VALUES ('Eisbock','Eisbock is a traditional specialty beer of the Kulmbach district of Germany that is made by partially freezing a doppelbock and removing the water ice to concentrate the flavour and alcohol content, which ranges from 9% to 13% by volume. It is clear, with a colour ranging from deep copper to dark brown in colour, often with ruby highlights.')
INSERT INTO BeerTypes VALUES ('Flanders Red Ale','Flanders red ale is fermented with organisms other than Saccharomyces cerevisiae, especially Lactobacillus, which produces a sour character attributable to lactic acid. Long periods of aging are employed, a year or more, often in oak barrels, to impart a lactic acid character to the beer.')
INSERT INTO BeerTypes VALUES ('Gueuze','Gueuze (or geuze, Dutch pronunciation: [ˈɡøːzə]) is a type of lambic, a Belgian beer. It is made by blending young (1-year-old) and old (2- to 3-year-old) lambics, which is bottled for a second fermentation. Because the young lambics are not fully fermented, the blended beer contains fermentable sugars, which allow a second fermentation to occur. Lambic that undergoes a second fermentation in the presence of sour cherries before bottling results in kriek lambic, a beer closely related to gueuze.')
INSERT INTO BeerTypes VALUES ('India Pale Ale','India Pale Ale or IPA is a style of pale ale developed in England for export to India. The first known use of the expression "India pale ale" is in an advertisement in the Sydney Gazette and New South Wales Advertiser on 27 August 1829. Worthington White Shield, originating in Burton-upon-Trent, is a beer considered to be part of the development of India Pale Ale. The color of an IPA can vary from a light golden to a reddish amber.')
INSERT INTO BeerTypes VALUES ('Light Ale','Light ale is a low alcohol bitter, often bottled.')
INSERT INTO BeerTypes VALUES ('Malt Liquor','Malt liquor, in North America, is beer with high alcohol content. Legally, it often includes any alcoholic beverage with 5% or more alcohol by volume made with malted barley. In common usage, it refers to beers containing a high alcohol content, generally above 6%, which are made with ingredients and processes resembling those for American-style lagers.')
INSERT INTO BeerTypes VALUES ('Kolsch','Kölsch (German pronunciation: [kœlʃ]) is a beer brewed in Cologne, Germany. It is a clear, top-fermented beer with a bright, straw-yellow hue similar to other beers brewed from mainly Pilsener malt. Kölsch is warm fermented at around 13 to 21 °C (55 to 70 °F), then conditioned by lagering at cold temperatures.')
INSERT INTO BeerTypes VALUES ('Lambic','Lambic is a type of beer brewed in the Pajottenland region of Belgium southwest of Brussels and in Brussels itself at the Cantillon Brewery. Lambic beers include gueuze and kriek lambic. Lambic differs from most other beers in that it is fermented through exposure to wild yeasts and bacteria native to the Zenne valley, as opposed to exposure to carefully cultivated strains of brewers yeast. This process gives the beer its distinctive flavour: dry, vinous, and cidery, usually with a sour aftertaste.')
INSERT INTO BeerTypes VALUES ('Pale Ale','The highest proportion of pale malts results in a lighter color. The term "pale ale" first appeared around 1703 for beers made from malts dried with coke, which resulted in a lighter color than other beers popular at that time. Different brewing practices and hop levels have resulted in a range of taste and strength within the pale ale family.')
INSERT INTO BeerTypes VALUES ('Hefenweizen','A yeast wheat weizenbier')
INSERT INTO BeerTypes VALUES ('Lager','Lager is a type of beer conditioned at low temperatures.')
INSERT INTO BeerTypes VALUES ('Porter','Porter is a dark style of beer developed in London from well-hopped beers made from brown malt')
INSERT INTO BeerTypes VALUES ('Red Ale','Irish red ale, red ale, or Irish ale (Irish: leann dearg) is a name used by brewers in Ireland; Smithwicks is a typical example of a commercial Irish Red Ale. There are many other examples being produced by Irelands expanding craft beer industry. OHaras, 8 Degrees and Franciscan Well all brew examples of Irish Red Ale.')
INSERT INTO BeerTypes VALUES ('Stout','Stout is a dark beer that includes roasted malt or roasted barley, hops, water and yeast. Stouts were traditionally the generic term for the strongest or stoutest porters, typically 7% or 8% alcohol by volume (ABV), produced by a brewery. There are a number of variations including Baltic porter, milk stout, and imperial stout; the most common variation is dry stout, exemplified by Guinness Draught, the worlds best selling stout.')
INSERT INTO BeerTypes VALUES ('Pilsner','Pilsner (also pilsener or simply pils) is a type of pale lager. It takes its name from the Bohemian city of Pilsen, where it was first produced in 1842. The world’s first blond lager, the original Pilsner Urquell, is still produced there today.')
INSERT INTO BeerTypes VALUES ('Witbier','Witbier, white beer, bière blanche, or simply witte is a barley/wheat, top-fermented beer brewed mainly in Belgium and the Netherlands. It gets its name due to suspended yeast and wheat proteins which cause the beer to look hazy, or white, when cold. It is a descendant from those medieval beers which were flavored and preserved with a blend of spices and other plants such as coriander, orange, and bitter orange referred to as "gruit" instead of using hops.')
INSERT INTO BeerTypes VALUES ('Weizenbock','A more powerful Dunkel Weizen (of "bock strength"), with a pronounced estery alcohol character, perhaps some spiciness from this, and bolder and more complex malt characters of dark fruits.')
INSERT INTO BeerTypes VALUES ('Wheat','Wheat beer is a beer, usually top-fermented, which is brewed with a large proportion of wheat relative to the amount of malted barley. The two main varieties are Weissbier and Witbier; minor types include Lambic, Berliner Weisse and Gose.')
INSERT INTO BeerTypes VALUES ('Scotch Ale','Scotch Ale was first used as a designation for strong ales exported from Edinburgh in the 18th century')

/******************************************** BeerTypes Table Inserts **************************************************************/

/******************************************** GoldHorn Brewery Info ****************************************************************/

SET IDENTITY_INSERT Brewery ON

INSERT INTO Brewery (BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES (1, TRY_CONVERT(UNIQUEIDENTIFIER,'7EB3ACB7-3EAF-4CFE-91AD-12C8551F4B65'),'Goldhorn', '1361 E 55th St.', 'Cleveland', 'OH', 'USA', '44103', 'Located on Cleveland’s East Side, in the St. Clair neighborhood, featuring classic European and American style beers. We believe beer is more than just a beverage; it''s a shared experience between brewer, buyer and community.', 2010, 'Tuesday 3:00 pm – 9:00 pm <br/> 
Wednesday 3:00 pm – 9:00 pm <br/> 
Thursday 3:00 pm – 9:00 pm <br/>
Friday 3:00 pm – 10:00 pm <br/>
Saturday 12:00 pm – 10:00 pm <br/>
Sunday 11:00 am – 6:00 pm <br/>
Closed: Mondays', 'info@goldhorn.com', '216-465-1352', 'http://www.ohiocraftbeer.org/wp-content/uploads/2016/01/Goldhorn_Header2-1.jpg','http://www.ohiocraftbeer.org/wp-content/uploads/2016/01/Goldhorn_Header1.jpg', 'http://www.totalwine.com/media/sys_master/twmmedia/h0a/h36/8804310974494.png', '41.5217531', '-81.6513999')

INSERT INTO Beer VALUES (1, 'Lagunitas IPA', 13, 'Piney and resinous with classic West Coast citrus zing. By Lagunitas Brewing Company.', 0, 6.2, 51.5, '2017-01-18', 'http://www.totalwine.com/media/sys_master/twmmedia/h0a/h36/8804310974494.png')
INSERT INTO Beer VALUES (1, 'Back In Black', 13, 'Brewed like an American IPA but with the addition of rich, dark malts, this beer has all the flavor and hop character you expect with a smooth, mellow finish. By 21st Amendment Brewery.', 0, 6.8, 65, '2017-11-18', 'http://21st-amendment.com/assets/backinblack_can_022113-230x409.png')
INSERT INTO Beer VALUES (1, 'Wanderlust IPA', 13, 'Golden IPA made with five different hops. Intense grapefruit and dank notes with a crisp finish. By Breakside Brewery.', 0, 6.2, 64, '2017-01-19', 'http://cdn6.bigcommerce.com/s-4dsnxp/products/2870/images/3226/Breakside_Brewery_Wanderlust_IPA__11425.1450253560.1280.1280.png?c=2')
INSERT INTO Beer VALUES (1, 'Edward APA', 18, 'Aromatic and flowery, with impressions of citrus and pine. By Hill Farmstead Brewery.', 0, 5.2, 85, '2017-10-01', 'https://i.pinimg.com/736x/0c/09/a3/0c09a3a75d02b72c6a1798013902b946.jpg')
INSERT INTO Beer VALUES (1, 'Heady Topper', 13, 'Extremely pleasant hoppy taste with a light nodes of citrus. By The Alchemist.', 0, 8.0, 75, '2016-01-18', 'https://cdn.beeradvocate.com/im/beers/16814.jpg')
INSERT INTO Beer VALUES (1, 'Hofbrau Dunkel', 20, 'Pours dark amber, head slow to dissipate. Dark malt flavor is weak, mouthfeel is thin. By Dunkel Munich.', 0, 5.5, 62.5, '2017-01-18', 'http://www.harats-distribution.hr/site/assets/files/1081/hofbrau-dunkel.png')
INSERT INTO Beer VALUES (1, 'Delirium Tremens', 3, 'Slightly malty, a nice touch of alcohol, spicy. By Huyghe Brewery.', 0, 8.5, 65.5, '2017-01-18', 'http://www.beermerchants.com/media/catalog/product/cache/1/thumbnail/250x/9df78eab33525d08d6e5fb8d27136e95/d/e/delirium_tremens.png')

/******************************************** GoldHorn Brewery Info ****************************************************************/

/******************************************** Great Lakes Brewing Company Info *************************************************************/

INSERT INTO Brewery (BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES (2, TRY_CONVERT(UNIQUEIDENTIFIER,'2BF6CE16-54D4-463D-8CA3-AF223ABC1AC6'),'Great Lakes Brewing Company', '2516 Market Ave.', 'Cleveland', 'OH', 'USA', '44113', 'In 1986 when Patrick and Daniel Conway opened their fledgling operation in Cleveland''s Ohio City neighborhood, the odds were stacked against them. Fortunately, they surrounded themselves with a staff of passionate, knowledgeable people, and from the start committed themselves to bringing a sophisticated, diverse selection of craft beer to their home state.', 1986, 'Monday - Thursday: 11:30 AM - 10:30 PM (bar open until 12:00 AM) <br/>
Friday: 11:30 AM - 11:30 PM (bar open until 1:00 AM) <br/>
Saturday: 11:00 AM - 11:30 PM (bar open until 1:00 AM) <br/>
Sundays: Closed', 'glbcinfo@greatlakesbrewing.com', '216-771-4404', 'https://www.greatlakesbrewing.com/sites/default/files/800x534_taproom4web.jpg', 'https://www.greatlakesbrewing.com/sites/default/files/800x534_taproom4web.jpg', 'https://media-cdn.tripadvisor.com/media/photo-s/01/60/80/ca/great-lakes-brewery.jpg', '41.484399', '-81.7045211')
INSERT INTO Beer VALUES (2, 'Dortmunder Gold', 20, 'A smooth, award-winning (and deceptively unassuming) balance of sweet malt and dry hop flavors. Yes, its known for winning medals worldwide. But locally, its known as "Dort," our flagship lager that humbly maintains its smooth, balanced (and charmingly unpretentious) ways. By Great Lakes Brewing Company.', 1, 5.8, 30, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/dortmunder-fixed_1.png?itok=67hwPAVE')
INSERT INTO Beer VALUES (2, 'Eliot Ness', 2, 'Admittedly, its a bit of a paradox to name our Amber Lager for historys most famous agent of prohibition. But its a smooth, malty (and dare we say, arresting?) paradox. By Great Lakes Brewing Company.', 1, 6.1, 27, '1995-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/eliotness-fixed_1.png?itok=k-GSENtB')
INSERT INTO Beer VALUES (2, 'Turntable Pils', 24, 'Flip that record and wax nostalgic about Ohio’s deep-cut music legacy with our refreshing pilsner. Consider this our reissue of a classic style. By Great Lakes Brewing Company.', 1, 5.4, 35, '2018-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/turntable-2018-330x546.png?itok=xKxe5ucc')
INSERT INTO Beer VALUES (2, 'Holy Moses', 25, 'Refreshment or bust! Orange peel, coriander, and chamomile stake their claim in this unfiltered White Ale, named for our fair citys founder, Moses Cleaveland. By Great Lakes Brewing Company.', 1, 5.4, 20, '1996-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/holy-moses-combo-2018-290x480.png?itok=rzNaLfFb')
INSERT INTO Beer VALUES (2, 'Burning River', 18, 'A toast to the Cuyahoga River Fire! For rekindling an appreciation of the Great Lakes region’s natural resources (like the malt and hops illuminating this fresh Pale Ale). By Great Lakes Brewing Company.', 1, 6.0, 45, '1993-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/burning-river-combo-2018-290x480.png?itok=EOCDhtVI')
INSERT INTO Beer VALUES (2, 'Commodore Perry', 13, 'What’s this? A British-style IPA named after the man who defeated His Majesty’s Royal Navy in the War of 1812? Consider this a bold, hoppy (and mildly ironic) plunder of war. By Great Lakes Brewing Company.', 1, 7.7, 70, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/commodore-fixed_1.png?itok=s17Bfb8k')
INSERT INTO Beer VALUES (2, 'Edmund Fitzgerald', 21, 'Robust and complex, our Porter is a bittersweet tribute to the legendary freighters fallen crew—taken too soon when the gales of November came early. By Great Lakes Brewing Company.', 1, 6.0, 37, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/edfitz-fixed_1.png?itok=WId6qzd8')
INSERT INTO Beer VALUES (2, 'Lightkeeper', 3, 'Inspired by Marblehead Lighthouse (the oldest operating on the Great Lakes) our Blonde Ales effervescence is guided home by a shimmering beacon of dry and fruity hop flavors. By Great Lakes Brewing Company.', 1, 6.6, 30, '2018-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/lightkeeper-can-290x480-2.png?itok=vIeSA713')
INSERT INTO Beer VALUES (2, 'Conways Irish Ale', 22, 'A pint for Pa Conway! Our co-owners grandfather and policeman who’d likely uphold that an Irish Ale with full-bodied caramel malt flavors is just the ticket. By Great Lakes Brewing Company.', 1, 6.3, 25, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/conway-fixed_1.png?itok=uarextFA')
INSERT INTO Beer VALUES (2, 'Hop Madness', 13, 'Beware! Our deranged brewers conjured up loads of nefarious nuggets to create this dry-hopped elixir bursting with shockingly juicy aromas and hair-raising bitterness! By Great Lakes Brewing Company.', 1, 9.0, 100, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/hopmadness_combo_0.png?itok=cXvnVz3Z')
INSERT INTO Beer VALUES (2, 'Cloud Cutter', 27, 'Bursts of juicy citrus zip across friendly, lightly filtered wheat skies in our high-flying tribute to the historic Cleveland Air Races. By Great Lakes Brewing Company.', 1, 5.1, 40, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/cloud-cutter-composite-290x480.png?itok=_A4H66Vf')
INSERT INTO Beer VALUES (2, 'Chillwave', 13, 'Inspired by the North Coast’s dedicated (and sometimes chilly) surf community, our Double IPA will melt the ice in your beard and never lose its balance. By Great Lakes Brewing Company.', 1, 9, 80, '2018-04-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/chillwave-fixed.png?itok=cLFlsZ6g')
INSERT INTO Beer VALUES (2, 'Rally Drum Red Ale', 22, 'With a tip of the cap to Cleveland baseball superfan and bleacher seat percussionist John J. Adams, our Red Ale fields a double header of bitter hop and roasted malt flavors. By Great Lakes Brewing Company.', 1, 5.8, 45, '2018-04-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/rally-drum-all.png?itok=rFGsOSfH')
INSERT INTO Beer VALUES (2, 'Holy Moses Raspberry White Ale', 25, 'In the spirit of Moses Cleavelands thirst for discovery, our classic White Ale meets fresh, juicy raspberries to forge a pint worth planting a flag in (or an orange slice!) By Great Lakes Brewing Company.', 1, 6.2, 20, '2018-05-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/holy-moses-raspberry-290x480.png?itok=O5gJsfqI')
INSERT INTO Beer VALUES (2, 'Lake Erie Monster', 13, 'Issue a small craft advisory: this South Bay Bessie-inspired brew launches an intense hop attack amid torrid tropical fruit flavors. By Great Lakes Brewing Company.', 1, 9.1, 80, '2018-06-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/monster-fixed_1.png?itok=g1hS4uWp')
INSERT INTO Beer VALUES (2, 'Oktoberfest', 20, 'Prost! Our take on this classic German style is a celebration of maltiness— packed with rustic, autumnal flavors to put a little more oomph into your oom-pah-pah. By Great Lakes Brewing Company.', 1, 6.5, 20, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/oktoberfest-fixed.png?itok=xFr4Zj1_')
INSERT INTO Beer VALUES (2, 'Nosferatu', 22, 'Don’t be afraid of things that go hop in the night! Rich roasted malt flavors haunt the shadows of our Imperial Red Ale’s bitter teeth. By Great Lakes Brewing Company.', 1, 8.0, 90, '2018-10-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/nosferatu-fixed.png?itok=mign8lqQ')
INSERT INTO Beer VALUES (2, 'Ohio City Oatmeal Stout', 23, 'Dark and roasty yet light and smooth as a fresh coat of snow, our Oatmeal Stout will kick your cabin fever and inspire you to toss another log on the fire. By Great Lakes Brewing Company.', 1, 5.4, 25, '2018-10-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/dortmunder-fixed_1.png?itok=67hwPAVE')
INSERT INTO Beer VALUES (2, 'Christmas Ale', 5, 'Do not open ‘til Christmas? Whoever coined that phrase obviously hasn’t tasted Christmas Ale’s fresh honey, cinnamon, and ginger flavors. By Great Lakes Brewing Company.', 1, 7.5, 30, '2018-11-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/christmas-fixed_1.png?itok=F_14BBUC')
INSERT INTO Beer VALUES (2, 'Blackout Stout', 23, 'Bold and dark as a power-less metropolis, our Russian Imperial Stout commemorates the infamous 2003 blackout that briefly left some 55 million people utterly unplugged. By Great Lakes Brewing Company.', 1, 9.9, 50, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/blackout-fixed_1.png?itok=v458Qt4c')

/******************************************** Great Lakes Brewing Company Info *************************************************************/

/******************************************** Yards Brewing Info *******************************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES (3, TRY_CONVERT(UNIQUEIDENTIFIER,'B6CA7E03-DB49-4DE2-9D76-0E5C19E311B7'),'Yards Brewing', '500 Spring Garden St.', 'Philadelphia', 'PA', 'USA', '19123', 'Back in the late ''80s, two college buddies, Tom and Jon, decided to brew some beer for their friends. Whether it was natural talent or the endless supply of free beer, people liked what they tasted and wanted more. They didn’t know it at the time, but this was the beginning of what was to become Yards Brewing Company. From a garage in Manayunk, to Roxborough, then Kensington and finally to Northern Liberties, this is the Story of Yards, Philly’s Brewery since 1994.', 1994, 'Sundays from 11am to 10pm <br/>
Mondays from 11:30am to 10pm <br/>
Tuesdays from 11:30am to 10pm <br/>
Wednesdays from 11:30am to 10pm <br/>
Thursdays from 11:30am to 11pm <br/>
Fridays from 11:30am to 11pm <br/>
Saturdays from 11am to 11pm', 'info@yardsbrewing.com', '(215) 525-0175', 'https://scontent-lga3-1.cdninstagram.com/vp/8d86b17adb8cce17fd2cdc29669a92cb/5B5A057B/t51.2885-15/e35/29403439_165290210837971_5950059091274498048_n.jpg', NULL, NULL, '39.9607821', '-75.1470542')
INSERT INTO Beer VALUES (3, 'Alexander Hamilton''s Treasury Ale', 24, 'By Yards Brewing', 0, 4.5, NULL, '2017-02-28', NULL)
INSERT INTO Beer VALUES (3, 'Brandywine Brawler', 5, 'By Yards Brewing', 0, 4.2, NULL, '2017-10-27', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_BLR_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Cape of Good Hope', 13, 'Our Cape of Good Hope, which changes year to year, pays homage to the original style and adventurous spirit of the first British IPAs. Our 2014 release is a West Coast style double IPA. There’s Columbus in the kettle, Chinook in the whirlpool and Mosaic in the hopback. We’ve dry hopped Cape with Mosaic, Crystal, Cluster, and Pacific Jade hops as well. Pilsner malt gives this brew a beautiful golden hue. The end result is a dry, crisp ale with unmistakable flavors and aromas of tropical fruits. By Yards Brewing', 0, 9.7, 76, '2011-07-25', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_COGH_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Chocolate Love Stout', 23, 'Passionately brewed with over 200 pounds of pure, 100% cacao Belgian dark chocolate, this irresistibly smooth stout explodes with the taste and aroma of rich, dark chocolate goodness. This deep black beauty will seduce you with her roasty maltiness and hints of vanilla and caramel. Passionately brewed with over 200 pounds of pure, 100% cacao Belgian dark chocolate, this irresistibly smooth stout explodes with the taste and aroma of rich, dark chocolate goodness. Chocolate Love Stout will please you with its roasty maltiness and hints of vanilla and caramel. By Yards Brewing', 0, 6.9, 30, '2011-02-27', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_CLS_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'General Washington''s Porter', 21, 'Detailed in a letter from the General to his officers during the war, Washington’s recipe employed molasses to aid fermentation and give rich caramel notes to this robust, roasty ale. The recipe reflected his admiration for Philadelphia-style porters, especially those brewed by Robert Hare (whose original brewery stood just blocks from where ours is now). Our Tavern Porter, inspired by Washington’s, is dark, smooth, and complex with just a hint of dried fruit in the finish. By Yards Brewing', 0, 7, 34, '2010-08-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_GWP_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Golden Hop IPA', 13, 'Golden Hop IPA soars with the tropical notes of tangerine, mango and grapefruit from Mosaic and Amarillo Hops. Cascade in the hopback adds a bright floral, citrus undertone, complementing this light-bodied IPA''s vibrant hop bouquet. Wheat malt gives Golden Hop its sunny color while Belgian yeast contributes to its clean, crisp feel. By Yards Brewing', 0, 6, 55, '2015-11-06', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_GHI_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Imperial Stout', 23, 'Russian Imperial Stout is an export style stout, which English brewers created to weather the long, ocean voyage from Enland to the court of Catherine II in the late 18th century. Like other export styles, this one is high in alcohol and is loaded with hops. Though we’re not shipping it past the Philadelphia suburbs, our version of this classic style is warming, rich and roasty, with a delicious dry finish. We stuff the mash tun with floor malted English barely, and load up the kettle with classic British noble hops to create our authentic Imperial Stout. Cheers! By Yards Brewing', 0, 10.8, NULL, '2014-12-03', NULL)
INSERT INTO Beer VALUES (3, 'Loral Lager', 20, 'By Yards Brewing', 0, 5.3, NULL, '2017-02-25', NULL)
INSERT INTO Beer VALUES (3, 'Love Stout', 23, 'Our brewers have poured their hearts and roasted malts into this rich, slightly sweet stout. Luscious notes of coffee and chocolate accent the smooth, creamy mouth feel. We will not apologize for any amorous affairs resulting from the consumption of this beverage. By Yards Brewing', 0, 5.5, 21, '2010-08-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_LS_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Philadelphia Pale Ale', 18, 'Not to be boastful, but we honestly believe all other ales pale in comparison to ours. Dry hopped with an abundance of distinctive Simcoe hops, this straw colored pale ale is more drinkable than bitter, more aromatic than aggressive. Philly Pale, as it’s better known, is crisp, hoppy, and bursting with citrus. By Yards Brewing', 0, 4.6, 37, '2010-08-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_PPA_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Poor Richard''s Spruce', 2, 'Based on Franklin’s original recipe, which called for barley, molasses, and essence of spruce, our Tavern Spruce is as approachable and engaging as was the man himself. We source blue spruce clippings from a local organic farmer, steeping them in the kettle to create this one-of-a-kind deep amber ale. By Yards Brewing', 0, 5, 13, '2010-08-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_PRS_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Pynk', 5, 'Yards PYNK is a beer like no other. We add 3,300 pounds of sour and sweet cherries and raspberries to each batch, resulting in a tart berry ale that’s effervescent and pleasantly pink in color. Delighting the palette, this light-bodied brew finishes refreshingly dry. By Yards Brewing', 0, 5.5, 6, '2013-03-25', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_PYNK_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Rival IPA', 13, 'This is Rival IPA and it is an “over the top” ale that uses pale crystal and rye malts. This beer also uses Bravo, Nugget and whole flower Chinook hops (in the hopback). If that’s not enough fun, Rival is then dry-hopped with Centennial, Citra, Simcoe and Columbus hops. By Yards Brewing', 0, 6.2, 65, '2016-09-17', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_RVL_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Thomas Jefferson''s Tavern Ale', 5, 'This powerful and complex golden ale pays homage to Founding Father and fellow brewer, Thomas Jefferson. Yards Brewmaster, Tom Kehoe, worked closely with Philadelphia’s historic City Tavern to recreate this recipe, employing honey, rye, and wheat, just like the beer Jefferson made at Monticello. By Yards Brewing', 0, 8, 28, '2010-08-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_TJ_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Washington''s Reserve', 21, 'We set a portion of every batch of General Washington’s Tavern Porter aside in freshly emptied bourbon barrels shipped straight from Kentucky. There, the beer ages for three months, absorbing vanilla, oak and bourbon flavors from the barrel walls. The end result is our Washington’s Reserve, a smooth, aromatic porter with hints of dried fruit in the finish and vanilla on the nose. By Yards Brewing', 0, 7, Null, '2014-02-21', 'http://yardsbrewing.com/assets/img/ales-logos/LOGO_WR_circle_Yards_Ales.png')
INSERT INTO Beer VALUES (3, 'Pour House Hoppy White Ale', 27, 'By Yards Brewing', 0, Null, Null, '2017-04-28', NULL)

/******************************************** Yards Brewing Info *******************************************************************/

/*********************************************Goose Island Brewing Company**********************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES(4, TRY_CONVERT(UNIQUEIDENTIFIER, '2CFDFB56-A764-4AC3-B869-CFB602A0253E'), 'Goose Island Brewing Company', '1800 W Fulton St.', 'Chicago', 'IL', 'USA', '60612', 'Founded in Chicago in 1988, Goose Island is one of the most successful craft breweries in the Midwest and produces some of the most popular, and award winning, beers in the U.S.', 1988,
'Wednesday 2PM-8PM <br/> Thursday 2PM-8PM <br/> Friday from 2PM-9PM <br/> Saturday 12PM-9PM & Sunday from 12PM-6PM', 'info@gooseisland.com', '1-800-466-7363', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/tours/photo-2.JPG', NULL, NULL, '41.88712', '-87.672321')
INSERT INTO Beer VALUES (4, 'Goose IPA', 13, 'Our India Pale Ale recalls a time when ales shipped from England to India were highly hopped to preserve their distinct taste during the long journey. The result is a hop lover’s dream with a fruity aroma, set off by a dry malt middle, and long hop finish. By Goose Island Brewing Company.', 0, 5.9, 55, '2017-02-25', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/goose-ipa/sImage.png')
INSERT INTO Beer VALUES (4, 'Four Star Pils', 24, 'The brewers at Goose Island wanted a pilsner they could enjoy at the end of their shift, so Four Star Pils was created. A truly refreshing & flavorful beer brewed their way and honoring the city our brewers call home.  When you''re done with your next work day, raise a Four Star Pils with us! By Goose Island Brewing Company.', 0, 5.1, 38, '2018-01-01', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/four-star-pils/sImage.png')
INSERT INTO Beer VALUES (4, 'Goose Honkers Ale', 18, 'Inspired by visits to English country pubs, Honker’s Ale combines a spicy hop aroma with a rich malt middle to create a perfectly balanced beer. By Goose Island Brewing Company.', 0, 4.3, 30, '1997-01-01', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/goose-honkers-ale/sImage.png')
INSERT INTO Beer VALUES (4, '312 Urban Wheat Ale', 27, 'Inspired by the city of Chicago and densely populated with flavor, 312’s spicy aroma of Cascade hops is followed by a crisp, fruity ale flavor delivered in a smooth, creamy body that''s immensely refreshing. By Goose Island Brewing Company.', 0, 4.2, 18, '2006-01-01', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/urban-wheat/312wheat.png') 
INSERT INTO Beer VALUES (4, 'Green Line Pale Ale', 18, 'Green Line Pale Ale is a honey-colored, immensely sessionable American pale ale with a pronounced, bright, American hop aroma and citrus flavor. Notes of biscuit and lightly toasted malt create the backbone for Green Line’s pleasant, crisp bitterness. By Goose Island Brewing Company.', 0, 5.4, 30, '2014-01-01', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/green-line/sImage.png') 
INSERT INTO Beer VALUES (4, 'Old Man Grumpy', 18, 'Inspired by our grouchy-yet-gifted brewmaster, Old Man Grumpy is a deliciously drinkable pale ale sure to lift anyone’s spirits. By Goose Island Brewing Company.', 0, 5.8, 30, '2012-01-01', 'https://abib-gooseisland-iglusjax.stackpathdns.com/assets/images/beers/Old-Man-Grumpy/Old_Man_Grumpy_Render_sImage.png')  
/*********************************************Goose Island Brewing Company**********************************************************/

/*********************************************Ballast Point Brewing Company*********************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES(5, TRY_CONVERT(UNIQUEIDENTIFIER, '2CFDFB56-A764-4AC3-B869-CFB602A0253E'), 'Ballast Point Brewing Company', '9045 Carroll Way', 'San Diego', 'CA', 'USA', '92121', 'In 1992, Jack White opened Home Brew Mart. Along with Pete A''Hearn and Yuseff Cherney, Ballast Point Brewing was born in 1996.', 1996,
'Mon-Thur 11:00am-11:00pm <br/>
Fri & Sat 11:00am-12:00am <br/>
Sunday 10:00am-10:00pm', 'miramar@ballastpoint.com', '(858) 790-6900', 'https://www.ballastpoint.com/wp-content/uploads/2016/02/ballast-point-miramar-web.jpg', NULL, NULL, '32.88787', '-117.15812')
INSERT INTO Beer VALUES (5, 'Moscow Mule Ale', 2, 'Our Moscow Mule Ale is a tart and refreshing beer version of the classic cocktail. By Ballast Point Brewing Company.', 0, 10.0, 10, '2012-12-21', 'https://www.ballastpoint.com/wp-content/uploads/2018/01/02-beers-primary-image-Moscow-Mule.png')
INSERT INTO Beer VALUES (5, 'Sculpin', 13, 'Our Sculpin IPA is a great example of what got us into brewing in the first place. After years of experimenting, we knew hopping an ale at five separate stages would produce something special. By Ballast Point Brewing Company.', 0, 7.0, 70, '2012-12-21', 'https://www.ballastpoint.com/wp-content/uploads/2013/09/02-beers-primary-image-Sculpin.png')
INSERT INTO Beer VALUES (5, 'Victory at Sea', 21, 'Our Ballast Point Victory at Sea Imperial Porter is a bold, smooth brew with just the right amount of sweetness. By Ballast Point Brewing Company.', 0, 10.0, 60, '2012-12-21', 'https://www.ballastpoint.com/wp-content/uploads/2013/10/02-beers-primary-image-VAS.png')
INSERT INTO Beer VALUES (5, 'Dorado', 13, 'A huge, hoppy brew that will test your sea legs. Our Dorado Double IPA immediately hooks you with massive hops that never stop. Mash hopping, kettle hopping and dry hopping makes this beer a serious hop lover’s prize catch. By Ballast Point Brewing Company.', 0, 10.0, 91, '2012-12-21', 'https://www.ballastpoint.com/wp-content/uploads/2013/10/02-beers-primary-image-Dorado.png')
INSERT INTO Beer VALUES (5, 'Sea Rose', 27, 'Our Sea Rose tart cherry wheat ale is a fresh take on fruit beers. By Ballast Point Brewing Company.', 0, 4.0, 8, '2012-12-21', 'https://www.ballastpoint.com/wp-content/uploads/2016/12/02-beers-primary-image-SeaRose.png')
/*********************************************Ballast Point Brewing Company*********************************************************/

/*********************************************Bell's Brewery************************************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES(6, TRY_CONVERT(UNIQUEIDENTIFIER, '2CFDFB56-A764-4AC3-B869-CFB602A0253E'), 'Bell''s Brewery', '355 E. Kalamazoo Ave.', 'Kalamazoo', 'MI', 'USA', '49007', 'Our journey began with a 15-gallon soup kettle, a quest for better beer and countless batches of homebrew. The passion and personality that began Bell’s continues today through our breweries and Eccentric Café. We continue to grow and evolve, dedicated to our mission; to be fiercely independent, 100% family owned, deeply rooted to our community, committed to the environment and brewers of inspired beer.', 1985, 
'Saturdays: Noon - 6 p.m. <br/> Sundays: Noon - 5 p.m.', 'info@bellsbeer.com', '(269) 382-2332', 'https://www.bellsbeer.com/sites/default/files/styles/large/public/brewery-144.jpg', NULL, NULL, '42.294649','-85.578865') 
INSERT INTO Beer VALUES (6, 'Amber Ale', 2, 'The beer that helped build our brewery; Bell’s Amber Ale features both toasted and sweet caramel notes from carefully selected malts, balanced with herbal and citrus hop aromas. Capped by a clean bitterness, it’s incredibly versatile with food, but very tasty on its own. By Bell''s Brewery.', 0, 5.8, NULL, '2012-12-21', 'https://www.bellsbeer.com/sites/default/files/brands/Amber_WebPic_736X736.png')
INSERT INTO Beer VALUES (6, 'Porter', 21, 'Our award winning Porter bridges the gap between malty brown ales and heavily roasted stouts. Notes of chocolate, coffee and roasted barley are offset with just a slight hop bitterness. By Bell''s Brewery.', 0, 5.6, NULL, '2012-12-21', 'https://www.bellsbeer.com/sites/default/files/Porter_WebPic_736X736.png')
INSERT INTO Beer VALUES (6, 'Two-Hearted Ale', 13, 'Brewed with 100% Centennial hops from the Pacific Northwest and named after the Two Hearted River in Michigan’s Upper Peninsula, this IPA is bursting with hop aromas ranging from pine to grapefruit from massive hop additions in both the kettle and the fermenter. By Bell''s Brewery.', 0, 7.0, NULL, '2012-12-21', 'https://www.bellsbeer.com/sites/default/files/brands/2HD_WebPic_736X736.png')
INSERT INTO Beer VALUES (6, 'Oberon Ale', 27, 'Oberon is a wheat ale fermented with our signature house ale yeast, mixing a spicy hop character with mildly fruity aromas. The addition of wheat malt lends a smooth mouthfeel, making it a classic summer beer. Made with only 4 ingredients, and without the use of any spices or fruit, Oberon is the color and scent of sunny afternoon. By Bell''s Brewery.', 0, 5.8, NULL, '2012-12-21', 'https://www.bellsbeer.com/sites/default/files/brands/Oberon_WebPic_736X736.png')
INSERT INTO Beer VALUES (6, 'Best Brown Ale', 3, 'A smooth, toasty brown ale, Best Brown is a mainstay in our fall lineup. With hints of caramel and cocoa, the malt body has the depth to stand up to cool weather, but does not come across as heavy. This balancing act is aided by the generous use of American hops. By Bell''s Brewery.', 0, 5.8, NULL, '2012-12-21', 'https://www.bellsbeer.com/sites/default/files/brands/BBA_WebPic_736X736.png')
/*********************************************Bell's Brewery************************************************************************/

/*********************************************Rogue Ales and Spirits****************************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES(7, TRY_CONVERT(UNIQUEIDENTIFIER, '2CFDFB56-A764-4AC3-B869-CFB602A0253E'), 'Rogue Ales and Spirits', '2320 OSU Drive', 'Newport','OR', 'USA', '97365', 'The Revolution began in 1988 in the basement of the first Rogue Public House on Lithia Creek in Ashland, Ore. where American Amber Ale and Oregon Golden quickly became popular brews. Before long, our founder Jack Joyce was looking for a second location.', 1988,
'Sunday - Thursday: 11am - 9pm <br/> Friday - Saturday: 11am - 10pm', 'info@rogue.com', '(541) 867-3664', 'https://www.rogue.com/thumbs/contact/kathy-20th-full-3-contactus-1200x800.jpg', NULL, NULL, '44.617812', '-124.04971')
INSERT INTO Beer VALUES (7, 'Cold Brew IPA', 13, 'Rogue Cold Brew IPA is a hoppy IPA infused with 200 gallons of Stumptown Coffee Roasters’ famous Cold Brew Coffee in every batch. By Rogue.', 0, 7.5, 82, '2012-12-21', 'http://www.cstoreproductsonline.com/sites/default/files/styles/product/public/rogue_cold_brew_IPA.png?itok=BtQ3tmSp')
INSERT INTO Beer VALUES (7, 'Dead Guy Ale', 4, 'In the style of a German Maibock, using our proprietary Pacman yeast, Dead Guy is deep honey in color with a malty aroma and a rich, hearty flavor. By Rogue.', 0, 6.8, 40, '2012-12-21', 'http://cornerstarwineandliquor.com/Stores/13/ProductImages/Rogue_DeadGuyAle.png')
INSERT INTO Beer VALUES (7, 'Pumpkin Patch Ale', 2, 'Created with pumpkins grown at Rogue Farms in Independence, Ore., Our pumpkins are picked, loaded into our truck, driven immediately 77 miles to our brewery in Newport, Oregon, quickly roasted and pitched into the brew kettle. By Rogue.', 0, 6.1, 25, '2012-12-21', 'http://www.jjtaylor.com/florida/wp-content/uploads/sites/2/2016/09/Pumpkin-Patch1.png')
INSERT INTO Beer VALUES (7, 'Mocha Porter', 21, 'Ruddy brown in color, a bittersweet balance of malt and hops, yet a surprisingly light and refreshing taste. By Rogue.', 0, 5.6, 47, '2012-12-21', 'https://img.saveur-biere.com/img/p/3570-22224-v4_product_img.jpg')
INSERT INTO Beer VALUES (7, 'Shakespeare Stout', 23, 'We introduced this American-style oatmeal stout as one of our three original beers when our first pub opened in Ashland in 1988. By Rogue.', 0, 5.8, 60, '2012-12-21', 'https://bookriot.com/wp-content/uploads/2014/07/rogue-shakespear.png')
/*********************************************Rogue Ales and Spirits****************************************************************/

/***********************************************************Guinness****************************************************************/
INSERT INTO Brewery(BreweryId, UserId, BreweryName, BreweryAddress, BreweryCity, BreweryDistrict, BreweryCountry, BreweryPostalCode, History, YearFounded, HoursOfOperation, Email, Phone, BreweryProfileImg, BreweryBackgroundImg, BreweryHeaderImg, BreweryLatitude, BreweryLongitude)
VALUES(8, TRY_CONVERT(UNIQUEIDENTIFIER, '2CFDFB56-A764-4AC3-B869-CFB602A0253E'), 'Guinness', 'St. James''s Gate', 'Dublin', 'Dublin', 'Ireland', '8', 'On December 31st, 1759, Arthur Guinness signs a 9000-year lease on a small, disused, and ill-equipped property at St. James’s Gate and starts to brew ale', 1759,
'9:30am - 7pm daily', 'info@guinnessstorehouse.com', '+353 1 408 4800', 'http://www.thepotato.ie/wp-content/uploads/2013/03/st-james-gate-1.jpg', NULL, NULL, '53.305494','-7.737649')
INSERT INTO Beer VALUES (8, 'Guinness Draught', 23, 'Rich and creamy. Distinctively black. Velvety in its finish. This iconic beer is defined by harmony.', 0, 4.2, NULL, '1959-12-21', 'https://www.powersdistributing.com/sites/default/files/Guiness_0.png')
INSERT INTO Beer VALUES (8, 'Guinness Extra Stout', 23, 'As deep as Guinness Extra Stout’s color is its taste. Crisp barley cuts through hops. A bite draws you in, bold flavors linger. Bitter marries sweet. A rich, refreshing taste. Brewed with skill. Built to last.', 0, 5.6, NULL, '1821-12-21', 'http://www.billsdist.com/images/products/GuinnessExtraStout.png')
INSERT INTO Beer VALUES (8, 'Guinness Dublin Porter', 21, 'Sip Dublin Porter and you’re sampling Guinness history. Light but well rounded. Sweet and smooth. Just bitter enough.', 0, 3.8, NULL, '1796-12-21', 'https://d1uyinv54o97jy.cloudfront.net/attachments/1abff7314f3672208c02532413c5c051088444e3/store/fit/500/500/4d3b1613681b107dcb80ddeb0d18f3c2096868a1c0f024fa40351c9e9077/guinness-dublin-porter.png')
/***********************************************************Guinness****************************************************************/

SET IDENTITY_INSERT Brewery OFF

delete from beer where beer.BeerName = 'Guinness Dublin Porter'