-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
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

-- create table Boats
CREATE TABLE Boats (
	bid 	NUMBER(9) PRIMARY KEY,
	name	VARCHAR(20),
	color	VARCHAR(20)
);

--create table Reserves
CREATE TABLE Reserves (
	sid 	NUMBER(9) PRIMARY KEY,
	bid 	NUMBER(9) PRIMARY KEY,
	day 	DATE,
	FOREIGN KEY (sid) REFERENCES Sailors,
	FOREIGN KEY (bid) REFERENCES Boats
);

-- describe tables
DESC Reserves;
DESC Sailors;
DESC Boats;

-- alter table Reserves by adding a column
ALTER TABLE Reserves ADD invoiceday DATE;

-- modify existing column by changing the data type
ALTER TABLE Reserves MODIFY invoiceday VARCHAR(30);

-- describe table
DESC Reserves;

-- alter table by renaming one column
ALTER TABLE Reserves RENAME COLUMN invoiceday to invday;

-- describe table
DESC Reserves;

-- rename table
ALTER TABLE Reserves RENAME TO otherreserves;

-- rename table
ALTER TABLE otherreserves RENAME TO Reserves;

-- alter table Reserves by dropping one column
ALTER TABLE Reserves DROP COLUMN invday;

-- describe table
DESC Reserves;

-- insert data into Sailors table
INSERT INTO Sailors VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors VALUES (58, 'rusty', 10, 35.0);
INSERT INTO Sailors VALUES (59, 'rusty', 10, 45.0);

-- insert data into Boats table
INSERT INTO Boats VALUES ('interlake', 101, 'red');
INSERT INTO Boats VALUES (102, 'clipper', 'green');

-- insert data into Reserves table
INSERT INTO Reserves VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- SOME SELECT QUERIES USED TO EXTRACT DATA
SELECT * FROM Sailors;
SELECT * FROM Boats;
SELECT * FROM Reserves;

SELECT rating, sname FROM Sailors;
SELECT DISTINCT rating, sname FROM Sailors;
SELECT * FROM Sailors where rating = 10;

SELECT * FROM Sailors, Reserves WHERE Sailors.sid = Reserves.sid;

SELECT * FROM Sailors s1, Reserves r1 WHERE s1.sid = r1.sid;

SELECT * FROM Sailors, Reserves WHERE Sailors.sid = Reserves.sid AND Reserves.bid = 101;

SELECT Sailors.sname, Boats.name, Boats.color
	FROM Sailors, Reserves, Boats
	WHERE Sailors.sid = Reserves.sid AND Boats.bid = Reserves.bid;

SELECT sname, name, color
	FROM Sailors, Reserves, Boats
	WHERE Sailors.sid = Reserves.sid AND Boats.bid = Reserves.bid;
