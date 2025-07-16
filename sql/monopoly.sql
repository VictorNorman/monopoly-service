--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;


-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY,
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	ID integer PRIMARY KEY,
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	score integer,
	cash integer,
	-- should be: pieceLocation integer REFERENCES Property(ID)
	pieceLocation varchar(50)
	);

CREATE TABLE Property (
	ID integer PRIMARY KEY,
	name varchar(50),
	color varchar(50),
	playerGameID integer REFERENCES PlayerGame(ID),
	numHouses integer,
	numHotels integer
);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.com', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.com', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 1, 0.00, 1000, 'Marvin Gardens');
INSERT INTO PlayerGame VALUES (2, 1, 2, 0.00, 250, 'Boardwalk');
INSERT INTO PlayerGame VALUES (3, 1, 3, 2350.00, 100, 'Boardwalk');
INSERT INTO PlayerGame VALUES (4, 2, 1, 1000.00, 50, 'Boardwalk');
INSERT INTO PlayerGame VALUES (5, 2, 2, 0.00, 10000, 'Boardwalk');
INSERT INTO PlayerGame VALUES (6, 2, 3, 500.00, 10, 'Boardwalk');
INSERT INTO PlayerGame VALUES (7, 3, 2, 0.00, 0, 'Boardwalk');
INSERT INTO PlayerGame VALUES (8, 3, 3, 5500.00, 0, 'Boardwalk');

INSERT INTO Property(ID, name, color, playerGameID, numHouses, numHotels)
    VALUES (1, 'Park Place', 'dark blue', 1, 1, 0);
INSERT INTO Property(ID, name, color, playerGameID, numHouses, numHotels)
    VALUES (2, 'Boardwalk', 'dark blue', 1, 0, 2);
INSERT INTO Property(ID, name, color, playerGameID, numHouses, numHotels)
    VALUES (3, 'Marvin Gardens', 'green', 2, 2, 0);

