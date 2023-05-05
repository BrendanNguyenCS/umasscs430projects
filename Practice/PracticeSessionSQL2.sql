-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
/*
DROP TABLE Reserves;
DROP TABLE Boats;
DROP TABLE Sailors;
*/

-- create table Sailors
CREATE TABLE Sailors (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2)
);

-- create table Boats
CREATE TABLE Boats (
    bid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(20),
    color VARCHAR(20)
);

--create table Reserves
CREATE TABLE Reserves (
    sid NUMBER(9),
    bid NUMBER(9),
    day DATE,
    PRIMARY KEY (sid, bid),
    FOREIGN KEY (sid) REFERENCES Sailors,
    FOREIGN KEY (bid) REFERENCES Boats
);

-- describe tables
DESC Reserves;
DESC Sailors;
DESC Boats;

-- insert data into Sailors table
INSERT INTO Sailors
    VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors
    VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors
    VALUES (58, 'rusty', 10, 35.0);
INSERT INTO Sailors
    VALUES (59, 'rusty', 10, 45.0);

-- insert data into Boats table
INSERT INTO Boats
    VALUES (101, 'interlake', 'red');
INSERT INTO Boats
    VALUES (102, 'clipper', 'green');

-- insert data into Reserves table
INSERT INTO Reserves
    VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves
    VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves
    VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

SELECT *
    FROM Sailors,
         Reserves
    WHERE Sailors.sid = Reserves.sid;

--sort by queries
SELECT *
    FROM Sailors;
SELECT *
    FROM Sailors
    ORDER BY age;
SELECT *
    FROM Sailors
    ORDER BY age DESC;
SELECT *
    FROM Sailors
    ORDER BY 4 DESC;
SELECT *
    FROM Sailors
    ORDER BY 4, 3 DESC;
SELECT *
    FROM Sailors
    ORDER BY 4, rating DESC;

--next commented out qyery will give an error if run
--SELECT * FROM Sailors, Reserves where Sailors.sid = Reserves.sid ORDER BY sid;
SELECT *
    FROM Sailors,
         Reserves
    WHERE Sailors.sid = Reserves.sid
    ORDER BY 1;

--LIKE keyword
SELECT *
    FROM Sailors
    WHERE sname = 'dustin';
SELECT *
    FROM Sailors
    WHERE sname LIKE 'dustin';
SELECT *
    FROM Sailors
    WHERE sname LIKE '%stin';
SELECT *
    FROM Sailors
    WHERE sname LIKE '%st';
SELECT *
    FROM Sailors
    WHERE sname LIKE '%st%';

-- case insensitive text matches
SELECT *
    FROM Sailors
    WHERE UPPER(sname) = UPPER('Dustin');
SELECT *
    FROM Sailors
    WHERE LOWER(sname) = LOWER('Dustin');

--other queries
SELECT s.sid, s.sname, b.color, r.day
    FROM Sailors s,
         Reserves r,
         Boats b
    WHERE s.sid = r.sid
      AND r.bid = b.bid
      AND r.day < TO_DATE('10/11/2022', 'MM/DD/YYYY');

SELECT s.sid, s.sname, b.color, r.day
    FROM Sailors s,
         Reserves r,
         Boats b
    WHERE s.sid = r.sid
      AND r.bid = b.bid
      AND r.day <= TO_DATE('10/11/2022', 'MM/DD/YYYY');

SELECT UPPER(sname)
    FROM Sailors s,
         Reserves r,
         Boats b
    WHERE s.sid = r.sid
      AND r.bid = b.bid
      AND s.age > 30
      AND (b.color = 'red' OR b.color = 'green');

SELECT sname
    FROM Sailors s,
         Reserves r,
         Boats b
    WHERE s.sid = r.sid
      AND r.bid = b.bid
      AND s.age > 30
      AND (b.color = 'red' OR b.color = 'green');

SELECT COUNT(DISTINCT b.bid)
    FROM Reserves r,
         Boats b
    WHERE r.bid = b.bid
      AND b.color = 'green';
