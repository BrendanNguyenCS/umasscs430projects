-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
/*
DROP TABLE Reserves;
DROP TABLE Boats;
DROP TABLE Sailors;
DROP TABLE Sailors2;
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

CREATE TABLE Sailors2 (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2)
);

-- describe tables
DESC Reserves;
DESC Sailors;
DESC Boats;
DESC Sailors2;

-- insert data into Sailors table
INSERT INTO Sailors (sid, sname, rating, age)
    VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors
    VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors
    VALUES (58, 'rusty', 10, 35.0);
INSERT INTO Sailors
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
INSERT INTO Reserves
    VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves
    VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves
    VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));
INSERT INTO Reserves
    VALUES (59, 103, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- insert data into Sailors2 table
INSERT INTO Sailors2 (sid, sname, rating, age)
    VALUES (20, 'joe', 9, 24.0);
INSERT INTO Sailors2 (sid, sname, rating, age)
    VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors2 (sid, sname, rating, age)
    VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors2 (sid, sname, rating, age)
    VALUES (60, 'andy', 9, 60.0);

--- some operations
SELECT sname, rating, (rating - 1) / 2 AS newcol
    FROM Sailors;
SELECT sname, rating, (rating - 1)
    FROM Sailors;

--UNION, INTERSECT
SELECT *
    FROM Sailors
UNION
SELECT *
    FROM Sailors2;

SELECT *
    FROM Sailors
UNION ALL
SELECT *
    FROM Sailors2;

SELECT *
    FROM Sailors
INTERSECT
SELECT *
    FROM Sailors2;

SELECT *
    FROM Sailors
    WHERE rating > 8
UNION
SELECT *
    FROM Sailors2
    WHERE rating < 8;

--- operation with aggregates
SELECT AVG(rating)
    FROM Sailors;
-- with WHERE clause
SELECT SUM(rating)
    FROM Sailors
    WHERE age > 40;

-- next commented out query will return an error if run
--SELECT age, AVG(rating) from Sailors;

-- GROUP BY
SELECT rating, AVG(age)
    FROM Sailors
    GROUP BY rating;
-- group by and order by
SELECT age, AVG(rating)
    FROM Sailors
    GROUP BY age
    ORDER BY AVG(rating);
-- group by with renaming aggregate
SELECT age, AVG(rating) AS avgrating
    FROM Sailors
    GROUP BY age
    ORDER BY avgrating;

-- GROUP BY AND HAVING
-- how many boats of each color I have ?
SELECT COUNT(*)
    FROM Boats
    GROUP BY color;
-- how many boats of each color I have ? Include in the results boats with an id greater than 102
SELECT COUNT(*)
    FROM Boats
    WHERE bid > 102
    GROUP BY color;

-- MORE PRACTICE
SELECT *
    FROM Reserves;

-- Find how many reservations for each boat color we have.
SELECT color, COUNT(*)
    FROM Reserves r,
         Boats b
    WHERE r.bid = b.bid
    GROUP BY color;

-- Find how many reservation for each boat color we have. Count each unique boat only once.
SELECT color, COUNT(DISTINCT r.bid)
    FROM Reserves r,
         Boats b
    WHERE r.bid = b.bid
    GROUP BY color;
