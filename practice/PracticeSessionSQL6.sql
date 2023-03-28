-- SQL Practice 6
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF YOU ALREADY HAVE THESE TABLES AND WANT TO RECREATE THEM WITH FRESH DATA FROM THIS FILE, PLEASE UNCOMMENT THE NEXT LINES
-- TO DROP THE TABLES FIRST)
/*
DROP TABLE PlaysIn;
DROP TABLE Movies;
DROP TABLE Actors;
DROP TABLE Sailors;
DROP TABLE Reserves;
DROP TABLE Boats;
DROP TABLE Sailors4;
DROP TABLE Sailors5;
*/

-- create table Movies
CREATE TABLE Movies (
    movie_id 	NUMBER(9) PRIMARY KEY,
    title	    VARCHAR(40),
    year        INT,
    studio      VARCHAR(20)
);

-- create table Actors
CREATE TABLE Actors (
    actor_id 	NUMBER(9) PRIMARY KEY,
    name	    VARCHAR(40),
    age         NUMBER(4,2)
);

-- create table PlaysIn
CREATE TABLE PlaysIn (
    actor_id 	NUMBER(9),
    movie_id    NUMBER(8),
    character   VARCHAR(40),
    PRIMARY KEY (actor_id, movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors,
    FOREIGN KEY (movie_id) REFERENCES Movies
);

-- insert records into Actors table
INSERT INTO Actors (actor_id, name, age)
    VALUES (10, 'Joe', 35.0);
INSERT INTO Actors (actor_id, name, age)
    VALUES (20, 'Mary', 20.0);
INSERT INTO Actors (actor_id, name, age)
    VALUES (30, 'Anne', 55.0);
INSERT INTO Actors (actor_id, name, age)
    VALUES (40, 'Jerry', 45.0);
INSERT INTO Actors (actor_id, name, age)
    VALUES (500, 'Joe', 45.0);

-- insert records into Movies table
INSERT INTO Movies (movie_id, title, year, studio)
    VALUES (100, 'Movie A', 2010, 'Universal');
INSERT INTO Movies (movie_id, title, year, studio)
    VALUES (200, 'Movie B', 2005, 'Universal');
INSERT INTO Movies (movie_id, title, year, studio)
    VALUES (300, 'Movie C', 2015, 'WB');

-- insert records into PlaysIn table
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (10, 100, 'cab driver');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (10, 200, 'waitress');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (10, 300, 'Billy');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (20, 100, 'musician');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (20, 300, 'waitress');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (30, 100, 'Laura');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (30, 200, 'teacher');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (30, 300, 'librarian');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (40, 100, 'teacher');
INSERT INTO PlaysIn (actor_id, movie_id, character)
    VALUES (40, 200, 'football player');

SELECT * FROM Actors a, PlaysIn p WHERE a.actor_id = p.actor_id ;

SELECT * FROM Actors a JOIN PlaysIn p ON a.actor_id = p.actor_id ;

-- left join. Will include actors who do not play in any movie (e.g. actor with actor_id 500)
SELECT * FROM Actors a
    LEFT JOIN PlaysIn p ON a.actor_id = p.actor_id ;

SELECT * FROM Actors a, PlaysIn p, Movies m
    WHERE a.actor_id = p.actor_id AND p.movie_id = m.movie_id;

SELECT * FROM Actors a
    JOIN PlaysIn p ON a.actor_id = p.actor_id
    JOIN Movies m ON m.movie_id = p.movie_id;

-- cross product
SELECT * FROM Actors, PlaysIn;

SELECT * FROM Actors CROSS JOIN PlaysIn;

-- natural join
SELECT * FROM Actors a, PlaysIn p, Movies m
    WHERE a.actor_id = p.actor_id AND p.movie_id = m.movie_id;

SELECT * FROM Actors NATURAL JOIN PlaysIn NATURAL JOIN Movies;

-- create table Sailors
CREATE TABLE Sailors(
    sid 	NUMBER(9) PRIMARY KEY,
    sname	VARCHAR(20),
    rating  NUMBER(2),
    age   	NUMBER(4,2)
);

-- create table Boats
CREATE TABLE Boats(
	bid 	NUMBER(9) PRIMARY KEY,
	name	VARCHAR(20),
	color	VARCHAR(20)
);

--create table Reserves
CREATE TABLE Reserves(
	sid 	NUMBER(9),
	bid 	NUMBER(9),
	day     DATE,
	PRIMARY KEY (sid, bid),
	FOREIGN KEY (sid) REFERENCES Sailors,
	FOREIGN KEY (bid) REFERENCES Boats
);

INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (58, 'rusty', 10, 35.0);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (59, 'rusty', 10, 45.0);

-- insert data into Boats table
INSERT INTO Boats (name, bid, color)
	VALUES ('interlake', 101, 'red');
INSERT INTO Boats (bid, name, color)
	VALUES (102, 'clipper', 'green');
INSERT INTO Boats (bid, name, color)
	VALUES (103, 'transatlantic', 'red');
INSERT INTO Boats (bid, name, color)
	VALUES (104, 'vacation', 'white');
INSERT INTO Boats (bid, name, color)
	VALUES (105, 'hawaii', 'green');
INSERT INTO Boats (bid, name, color)
	VALUES (106, 'sea', 'green');

-- insert data into Reserves table
INSERT INTO Reserves VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (59, 103, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- some updates
UPDATE Sailors SET rating = 9 WHERE sid = 31;

UPDATE Sailors SET rating = 8;

-- some deletes
-- delete all record for sailors named rusty
DELETE FROM Sailors WHERE sname = 'rusty';

--delete all records FROM table Sailors
DELETE FROM Sailors;

-- INTEGRITY CONSTRAINTS
-- Foreign key integrity constraint
-- this will return an error
INSERT INTO Reserves VALUES (20, 101, TO_DATE('10/26/2022', 'MM/DD/YYYY'));

-- general constraints
-- For table Sailors, we can insert records with rating 11
INSERT INTO Sailors VALUES (100, 'joe', 11, 33);

-- create table Sailors4 with a constraint on rating, to only allow VALUES >= 1 and <= 10.
CREATE TABLE Sailors4 (
    sid 	NUMBER(9) PRIMARY KEY,
    sname	VARCHAR(20),
    rating  NUMBER(2),
    age   	NUMBER(4,2),
    CONSTRAINT RatingRange CHECK (rating >= 1 AND rating <= 10)
);

-- this will return an error because of the RatingRange constraint
INSERT INTO Sailors4 VALUES (100, 'joe', 11, 33);

-- same constraint without name
CREATE TABLE Sailors5 (
    sid 	NUMBER(9) PRIMARY KEY,
    sname	VARCHAR(20),
    rating  NUMBER(2) CHECK (rating >= 11 AND rating <= 10),
    age   	NUMBER(4,2)
);

-- this will return an error because of the constraint on rating
INSERT INTO Sailors5 VALUES (100, 'joe', 11, 33);

