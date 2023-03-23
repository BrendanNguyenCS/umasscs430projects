/*
DROP TABLE Reserves;
DROP TABLE Boats;
DROP TABLE Sailors;
*/

-- create table Sailors
CREATE TABLE Sailors (
	sid 	NUMBER(9) PRIMARY KEY,
	sname	VARCHAR(20),
	rating  NUMBER(2),
	age   	NUMBER(4, 2)
);

-- create table boats
CREATE TABLE Boats (
	bid 	NUMBER(9) PRIMARY KEY,
	name	VARCHAR(20),
	color	VARCHAR(20)
);

--create table reserves
CREATE TABLE Reserves (
	sid 	NUMBER(9),
	bid 	NUMBER(9),
	day 	DATE,
	PRIMARY KEY (sid, bid),
	FOREIGN KEY (sid) REFERENCES Sailors,
	FOREIGN KEY (bid) REFERENCES Boats
);

-- create view SailorsAndBoats
CREATE VIEW SailorsAndBoats (sid, sname, bid, bname, color, day)
	AS SELECT s.sid, s.sname, b.bid, b.name, b.color, r.day
	FROM Sailors s, Reserves r, Boats b
	WHERE s.sid = r.sid AND r.bid = b.bid;

DESC SailorsAndBoats;

SELECT * FROM SailorsAndBoats;

-- insert data into Sailors
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (58, 'rusty', 10, 35.0);
INSERT INTO Sailors (sid, sname, rating, age)
	VALUES (59, 'rusty', 10, 45.0);

-- insert data into boats table
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

-- insert data into reserves table
INSERT INTO Reserves VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (59, 103, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

SELECT * FROM SailorsAndBoats;

SELECT * FROM SailorsAndBoats WHERE sname LIKE 'd%';

-- create view SailorsAndBoats3
CREATE VIEW SailorsAndBoats3
	AS SELECT s.sid, s.sname, b.bid, b.name, b.color, r.day
	FROM Sailors s, Reserves r, Boats b
	WHERE s.sid = r.sid AND r.bid = b.bid;

DESC SailorsAndBoats3
DESC SailorsAndBoats

-- create view SailorsHighRating
CREATE VIEW SailorsHighRating
	AS SELECT * FROM Sailors s
	WHERE s.rating > 8;

DESC SailorsHighRating;

SELECT * FROM Sailors;
SELECT * FROM SailorsHighRating;

UPDATE Sailors SET rating = 7 WHERE sid = 58;

SELECT * FROM Sailors;
SELECT * FROM SailorsHighRating;
