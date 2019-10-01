-- *************************************************************************************************
-- This script creates all of the database objects (tables, sequences, etc) for the database
-- *************************************************************************************************

BEGIN;

-- CREATE statements go here
DROP TABLE IF EXISTS brewnews;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Beer;
DROP TABLE IF EXISTS Brewery;
DROP TABLE IF EXISTS app_user;


CREATE TABLE app_user (
  id SERIAL PRIMARY KEY,
  user_name varchar(32) NOT NULL UNIQUE,
  password varchar(32) NOT NULL,
  role varchar(32),
  salt varchar(255) NOT NULL
);

CREATE TABLE Brewery
(
BREWERY_ID SERIAL PRIMARY KEY,
NAME VARCHAR(30),
ADDRESS VARCHAR(100),
EMAIL VARCHAR(50),
DESCRIPTION VARCHAR(500),
owners_user_id int,
gpslocation VARCHAR(500) default '39.9612, -82.9988'
);

CREATE TABLE Beer 
(
BREWERY_ID INT, 
BEER_ID SERIAL PRIMARY KEY,
NAME VARCHAR(30),
STYLE VARCHAR(30),
DESCRIPTION VARCHAR(500),
ABV VARCHAR(5),
ACTIVE BOOLEAN default true,
FOREIGN KEY (BREWERY_ID) REFERENCES Brewery(BREWERY_ID)
);

CREATE TABLE Reviews
(
BEER_ID INT,
REVIEW_ID SERIAL PRIMARY KEY,
NAME VARCHAR(30),
RATING INT,
REVIEW VARCHAR(280),
brewer_response VARCHAR(280) default null,
FOREIGN KEY (BEER_ID) REFERENCES Beer(BEER_ID)
);

CREATE TABLE brewnews 
(
newsitem_ID SERIAL PRIMARY KEY,
BREWERY_ID INT, 
newsupdate VARCHAR(500),
updatetime VARCHAR(100),
FOREIGN KEY (BREWERY_ID) REFERENCES Brewery(BREWERY_ID)
);

INSERT INTO app_user (user_name, password, role, salt)
VALUES ('admin', 'EN20vFByiMSoJxVnQkLv0Q==', 'admin', '+QPNlgYVN3BxHE4iAyTzF/nFrIpvBYorWQvmYPkaOyOLffRXKtQL6U7xpZ/d2MqD9kmjW7snTDUiNCyUrcDTCJUrebygcuUPnHGDFkmgaQZ2XyC/FnCb0diradSyExZJlphEMT+sFkcHdZkB1HQwPn7HLkB7qqKeLuYfgmXGbn4=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('brewery1', '1bCN70wh2NUOAJDr/XY0WA==', 'brewer', 'fhj4gcjrmJCZL8u5Vtp+0QNmjaiS6xTBclwYYOuRR/ybbu8ht2LSY5zkVZjWEFwo6cyGGF0J9/5W0cW7Y2Hnf0IheK2nInA+VD5flbJrNLMKvTKVto7IlEmT2FqtutpkTYc8fUCj2Bi9o/4Uk+wKBVmEnfdzIadkAxM+GvL+/P8=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('brewery2', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('columbusbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('wolfsridgebrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('seventhsonbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('platformbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('elevatorbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('endeavorbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('actualbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('lineagebrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('northhighbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('landgrantbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('sideswipebrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('rockmillbrewingcompany', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');
INSERT INTO app_user (user_name, password, role, salt)
VALUES ('pretentiousbarrelhouse', '8pGFdKQ6ZAQnLPDQaEoY+Q==', 'brewer', 'RGkMoh2ozEeX8BpV5QXX5Ra1Lmu6B3yIASwPrYDpsKWdM+zlNVP14lv3+Cas8g2B6GGBJ/OVc9vHeSIGcvnaInmPiAVw8zS9tLHd/Cs9/FntTxqrtQUe8webvBywB9veH74TlSyJjk70iDp5zstHRCaPbpM14GDzqyHFhZnM6XQ=');



INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Brewery One', '111 Fake Street Columbus, OHIO 44134', 'BREWERYONE@GMAIL.COM', 'THIS BREWERY RULES', 2, '39.9612, -82.9988');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id)
VALUES ('Brewery Two', '222 Fake Street Grove City, OHIO 44134', 'BREWERYTWO@GMAIL.COM', 'THIS BREWERY RULES MORE THAN BREWERY ONE', 3);
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Columbus Brewing Company', '2555 Harrison Rd, Columbus, OH 43204', 'contact@columbusbrewing.com', 'Columbus Brewing Company is a craft brewery located in Columbus, Ohio. CBC brews mostly hop forward, award-winning beers', 4, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Wolfs Ridge Brewing Company', '215 N 4th St, Columbus, OH 43215', 'admin@wolfsridge.com', 'Wolfs Ridge Brewing is a restaurant, brewery, and tap room driven by a passion to elevate the standards of Columbus best restaurants and breweries.', 5, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Seventh Son Brewing Company', '1101 N 4th St, Columbus, OH 43201', 'admin@seventhson.com', 'Craft brewery and event space located in Columbus, Ohio.', 6, '39.985374, -82.999676');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Platform Brewing Company', '408 N 6th St, Columbus, OH 43215', 'contact@platformbrewing.com', 'Platform Beer Co was founded in 2014 by Paul Benner and Justin Carson as a homebrew-inspired educational brewery devoted to community', 7, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Elevator Brewing Company', '161 N High St, Columbus, OH 43215', 'admin@elevatorbrewing.com', 'Historic, wood-trimmed pub with an on-site brewery & a menu of surf n turf & other American fare.', 8, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Endeavor Brewing', '909 W 5th Ave, Columbus, OH 43212', 'admin@endeavorbrewing.com', 'Taproom plus eats with a full bar serving local & regional craft beers & house beers once a week.', 9, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Actual Brewing', '1837, 655 N James Rd, Columbus, OH 43219', 'admin@actualbrewing.com', 'History brewery in the heart of Columbus.', 10, '40.0030864,-82.994959');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Lineage Brewing', '2971 N High St, Columbus, OH 43202', 'contact@lineagebrewing.com', 'Bright, modern brewpub in a former car wash offering smart homebrews, comfort food & patio seating.', 11, '39.967424, -83.069271');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('North High Brewing', '1288 N High St, Columbus, OH 43201', 'contact@northhighbrewing.com', 'Microbrewery featuring a brew-your-own option, plus a rustic-chic pub serving house beers & panini.', 12, '39.988660, -83.005674');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Land-Grant Brewing', '424 W Town St, Columbus, OH 43215', 'admin@landgrantbrewing.com', 'Brewery & Tap Room.', 13, '39.957627, -83.011541');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Sideswipe Brewing', '2419 Scioto Harper Dr, Columbus, OH 43204', 'admin@sideswipebrewing.com', 'Unassuming path brewery & taproom offering menu of housemade beers, plus growlers for sale.', 14, '39.966791, -83.066978');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Rock Mill Brewing Company', '5705 Lithopolis Rd NW, Lancaster, OH 43130', 'admin@rockmillbrewingco.com', 'We are a small production brewery located on a former horse farm near Lancaster', 15, '39.748226, -82.709738');
INSERT INTO BREWERY (NAME, ADDRESS, EMAIL, DESCRIPTION, owners_user_id, gpslocation)
VALUES ('Pretentious Barrel House', '745 Taylor Ave, Columbus, OH 43219', 'admin@prretentiousbarrelhouse.com', 'Pretentious Barrel House is the first dedicated sour brewery in the Columbus area', 16, '39.982109, -82.960739');




INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (1, 'Brewiser', 'IPA', 'This beer rules', '8.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (2, 'Beer One', 'Pilsner', 'THIS BEER RULES MORE', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV, ACTIVE)
VALUES (2, 'Hidden Beer', 'Stout', 'THIS BEER SHOULD BE HIDDEN', '17.3',false);
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (2, 'Beer Two', 'Lager', 'The sequel to beer one', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (3, 'Columbus IPA', 'IPA', 'A Columbus favorite', '4.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (3, 'Bodhi', 'Pilsner', 'Another Columbus favorite', '7.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (3, 'Creeper', 'Stout', 'Our most popular beer', '6.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (3, 'Citra Noel', 'Lager', 'Our newest beer', '3.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (4, 'Clear Sky Daybreak', 'Lager', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (4, 'Howling Moon', 'IPA', 'A Columbus favorite', '5.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (4, 'Driftwood', 'Pilsner', 'Another Columbus favorite', '7.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (4, 'Direwolf', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (4, 'Clear Sky Cinnamon Toast', 'Lager', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (5, 'Humulus Nimbus', 'Lager', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (5, 'American Strong Ale', 'Ale', 'A Columbus favorite', '5.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (5, 'The Scientist IPA', 'IPA', 'Another Columbus favorite', '7.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (5, 'Proliferous', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (5, 'Stone Fort Oat Brown', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (6, 'Speed Merchant', 'Lager', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (6, 'New Cleveland Palesner', 'Pale Ale', 'A Columbus favorite', '5.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (6, 'Yammy Yammy', 'IPA', 'Another Columbus favorite', '7.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (6, 'Orange Blossom Gose', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (6, 'EstherBelgian Christmas', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (7, 'Three Frogs IPA', 'IPA', 'Staff choice', '6.5');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (7, 'Bleeding Buckeye', 'Pale Ale', 'A Columbus favorite', '5.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (7, 'Big Vic Imperial IPA', 'IPA', 'Another Columbus favorite', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (7, 'Dark Force', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (7, 'Heiferweizen', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (8, 'New World IPA', 'IPA', 'Staff choice', '6.5');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (8, 'Latin Lager', 'Lager', 'A Columbus favorite', '5.8');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (8, 'Export Stout', 'Stout', 'Another Columbus favorite', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (8, 'Old World Wit', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (8, 'Tripel', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (9, 'Fat Julian', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (9, 'Photon', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (10, 'Spaceship 6', 'Stout', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (10, 'Oscura Obscura', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (11, 'Milk Stout', 'Stout', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (11, 'Pale Ale', 'Pale Ale', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (11, 'Stardust', 'Oat', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (12, 'Stiff Arm IPA', 'IPA', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (12, '1862 Ale', 'Pale Ale', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (12, 'Greenskeeper Session IPA', 'IPA', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (13, 'Fisticuffs', 'IPA', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (13, 'Elegant Hoodlum', 'Pale Ale', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (13, 'Pixielated Sun', 'Lager', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (14, 'Saison Noir', 'IPA', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (14, 'Cask Aged Tripel', 'Pale Ale', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (14, 'Dubbel', 'Lager', 'Our newest beer', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (15, 'Sybarite', 'IPA', 'Staff choice', '6.9');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (15, 'Derisive', 'Pale Ale', 'Our most popular beer', '3.3');
INSERT INTO BEER (BREWERY_ID, NAME,  STYLE, DESCRIPTION, ABV)
VALUES (15, 'Truculent', 'Lager', 'Our newest beer', '6.9');


INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (1, 'Joey BeerDrinker', 5, 'This beer changed my life bro');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (1, 'Janet', 4, 'Best Ive had in a while');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (1, 'Beerlord', 3, 'IPAs are a different strain bro');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (2, 'Jason', 1, 'Not impressed');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (2, 'Mason', 3, 'Try another offering from this place, this one is mediocre');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (3, 'Kelly', 3, 'Great brewery but the beer lacked flavor');
INSERT INTO REVIEWS (BEER_ID, NAME, RATING, REVIEW)
VALUES (3, 'Matt', 1, 'I want my money back');

INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (1, 'Our grand opening is today! Come enjoy a beer!', 'January 12, 2015');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (2, 'Our grand opening is today! Come enjoy a beer!', 'December 12, 2011');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (1, 'Come celebrate our 3 year anniversary!', 'January 12, 2018');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (1, 'Happy cinco demayo! Come enjoy our holiday specials!', 'May 4, 2018');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (1, 'Come to our Christmas party Saturday for huge discounts!', 'December 22, 2018');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (2, 'Come celebrate our 5 year anniversary with specials!', 'December 12, 2016');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (1, 'Fourth of July specials start early, come enjoy the holiday at your favorite local brewery!', 'July 3, 2019');
INSERT INTO brewnews (brewery_id, newsupdate, updatetime)
VALUES (2, 'Under new management. Come see the specials for our grand reopening tomorrow!', 'June 12, 2019');
COMMIT;

SELECT * FROM BEER;
SELECT * FROM BREWERY ORDER BY BREWERY_ID ASC;
SELECT * FROM REVIEWS;
SELECT * FROM app_user;
SELECT * FROM brewnews;