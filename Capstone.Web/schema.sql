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
INSERT INTO Beer VALUES (2, 'Eliot Ness', NULL, 'Admittedly, its a bit of a paradox to name our Amber Lager for historys most famous agent of prohibition. But its a smooth, malty (and dare we say, arresting?) paradox.', 1, 6.1, 27, '1995-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/eliotness-fixed_1.png?itok=k-GSENtB')
INSERT INTO Beer VALUES (2, 'Turntable Pils', NULL, 'Flip that record and wax nostalgic about Ohio’s deep-cut music legacy with our refreshing pilsner. Consider this our reissue of a classic style.', 1, 5.4, 35, '2018-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/turntable-2018-330x546.png?itok=xKxe5ucc')
INSERT INTO Beer VALUES (2, 'Holy Moses', NULL, 'Refreshment or bust! Orange peel, coriander, and chamomile stake their claim in this unfiltered White Ale, named for our fair citys founder, Moses Cleaveland.', 1, 5.4, 20, '1996-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/holy-moses-combo-2018-290x480.png?itok=rzNaLfFb')
INSERT INTO Beer VALUES (2, 'Burning River', NULL, 'A toast to the Cuyahoga River Fire! For rekindling an appreciation of the Great Lakes region’s natural resources (like the malt and hops illuminating this fresh Pale Ale).', 1, 6.0, 45, '1993-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/burning-river-combo-2018-290x480.png?itok=EOCDhtVI')
INSERT INTO Beer VALUES (2, 'Commodore Perry', NULL, 'What’s this? A British-style IPA named after the man who defeated His Majesty’s Royal Navy in the War of 1812? Consider this a bold, hoppy (and mildly ironic) plunder of war.', 1, 7.7, 70, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/commodore-fixed_1.png?itok=s17Bfb8k')
INSERT INTO Beer VALUES (2, 'Edmund Fitzgerald', NULL, 'Robust and complex, our Porter is a bittersweet tribute to the legendary freighters fallen crew—taken too soon when the gales of November came early.', 1, 6.0, 37, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/edfitz-fixed_1.png?itok=WId6qzd8')
INSERT INTO Beer VALUES (2, 'Lightkeeper', NULL, 'Inspired by Marblehead Lighthouse (the oldest operating on the Great Lakes) our Blonde Ales effervescence is guided home by a shimmering beacon of dry and fruity hop flavors.', 1, 6.6, 30, '2018-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/lightkeeper-can-290x480-2.png?itok=vIeSA713')
INSERT INTO Beer VALUES (2, 'Conways Irish Ale', NULL, 'A pint for Pa Conway! Our co-owners grandfather and policeman who’d likely uphold that an Irish Ale with full-bodied caramel malt flavors is just the ticket.', 1, 6.3, 25, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/conway-fixed_1.png?itok=uarextFA')
INSERT INTO Beer VALUES (2, 'Hop Madness', NULL, 'Beware! Our deranged brewers conjured up loads of nefarious nuggets to create this dry-hopped elixir bursting with shockingly juicy aromas and hair-raising bitterness!', 1, 9.0, 100, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/hopmadness_combo_0.png?itok=cXvnVz3Z')
INSERT INTO Beer VALUES (2, 'Cloud Cutter', NULL, 'Bursts of juicy citrus zip across friendly, lightly filtered wheat skies in our high-flying tribute to the historic Cleveland Air Races.', 1, 5.1, 40, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/cloud-cutter-composite-290x480.png?itok=_A4H66Vf')
INSERT INTO Beer VALUES (2, 'Chillwave', NULL, 'Inspired by the North Coast’s dedicated (and sometimes chilly) surf community, our Double IPA will melt the ice in your beard and never lose its balance.', 1, 9, 80, '2018-04-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/chillwave-fixed.png?itok=cLFlsZ6g')
INSERT INTO Beer VALUES (2, 'Rally Drum Red Ale', NULL, 'With a tip of the cap to Cleveland baseball superfan and bleacher seat percussionist John J. Adams, our Red Ale fields a double header of bitter hop and roasted malt flavors.', 1, 5.8, 45, '2018-04-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/rally-drum-all.png?itok=rFGsOSfH')
INSERT INTO Beer VALUES (2, 'Holy Moses Raspberry White Ale', NULL, 'In the spirit of Moses Cleavelands thirst for discovery, our classic White Ale meets fresh, juicy raspberries to forge a pint worth planting a flag in (or an orange slice!)', 1, 6.2, 20, '2018-05-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/holy-moses-raspberry-290x480.png?itok=O5gJsfqI')
INSERT INTO Beer VALUES (2, 'Lake Erie Monster', NULL, 'Issue a small craft advisory: this South Bay Bessie-inspired brew launches an intense hop attack amid torrid tropical fruit flavors.', 1, 9.1, 80, '2018-06-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/monster-fixed_1.png?itok=g1hS4uWp')
INSERT INTO Beer VALUES (2, 'Oktoberfest', NULL, 'Prost! Our take on this classic German style is a celebration of maltiness— packed with rustic, autumnal flavors to put a little more oomph into your oom-pah-pah.', 1, 6.5, 20, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/oktoberfest-fixed.png?itok=xFr4Zj1_')
INSERT INTO Beer VALUES (2, 'Nosferatu', NULL, 'Don’t be afraid of things that go hop in the night! Rich roasted malt flavors haunt the shadows of our Imperial Red Ale’s bitter teeth.', 1, 8.0, 90, '2018-10-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/nosferatu-fixed.png?itok=mign8lqQ')
INSERT INTO Beer VALUES (2, 'Ohio City Oatmeal Stout', NULL, 'Dark and roasty yet light and smooth as a fresh coat of snow, our Oatmeal Stout will kick your cabin fever and inspire you to toss another log on the fire.', 1, 5.4, 25, '2018-10-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/dortmunder-fixed_1.png?itok=67hwPAVE')
INSERT INTO Beer VALUES (2, 'Christmas Ale', NULL, 'Do not open ‘til Christmas? Whoever coined that phrase obviously hasn’t tasted Christmas Ale’s fresh honey, cinnamon, and ginger flavors.', 1, 7.5, 30, '2018-11-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/christmas-fixed_1.png?itok=F_14BBUC')
INSERT INTO Beer VALUES (2, 'Blackout Stout', NULL, 'Bold and dark as a power-less metropolis, our Russian Imperial Stout commemorates the infamous 2003 blackout that briefly left some 55 million people utterly unplugged.', 1, 9.9, 50, '1988-01-01', 'https://www.greatlakesbrewing.com/sites/default/files/styles/large/public/blackout-fixed_1.png?itok=v458Qt4c')

/******************************************** Great Lakes Brewery Info *************************************************************/

/******************************************** BeerTypes Table Inserts **************************************************************/
INSERT INTO BeerTypes VALUES ('Altbier','Altbier is usually a dark copper colour. It is fermented at a moderate temperature using a top-fermenting yeast which gives its flavour some fruitiness, but matured at a cooler temperature, which gives it a cleaner and crisper taste more akin to lager beer styles than is the norm for top-fermented beers, such as British pale ale')
INSERT INTO BeerTypes VALUES ('Amber Ale','An Amber Ale Amber ale is a term used in Australia, France and North America for pale ales brewed with a proportion of amber malt and sometimes crystal malt to produce an amber color generally ranging from light copper to light brown. A small amount of crystal or other colored malt is added to the basic pale ale base to produce a slightly darker color, as in some Irish and British pale ales. In France the term "ambrée" is used to signify a beer, either cold or warm fermented, which is amber in color; the beer, as in Pelforth Ambrée and Fischer Amber, may be a Vienna lager, or it may be a Bière de Garde as in Jenlain Ambrée. In North America, American-variety hops are used in varying degrees of bitterness, although very few examples are particularly hoppy. In Australia the most popular Amber Ale is from Malt Shovel Brewery, branded James Squire in honour of Australias first brewer, who first brewed beer in Sydney in 1794')
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