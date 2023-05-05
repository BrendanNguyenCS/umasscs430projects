-- SQL Practice 4
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT FOUR LINES TO DROP THE TABLES FIRST)
/*
DROP TABLE Reserves;
DROP TABLE Boats;
DROP TABLE Sailors;
DROP TABLE Sailors3;
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

CREATE TABLE Sailors3 (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2),
    salary NUMBER(9)
);

-- describe tables
DESC Reserves;
DESC Sailors;
DESC Boats;
DESC Sailors3;


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

-- insert data into sailors3 table
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (22, 'dustin', 7, 45.0, 20000);
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (31, 'lubber', 8, 55.5, 30000);
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (58, 'rusty', 10, 35.0, 15000);
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (59, 'rusty', 10, 45.0, 40000);
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (60, 'andy', 10, 60.0, 25000);
INSERT INTO Sailors3 (sid, sname, rating, age, salary)
    VALUES (61, 'mary', 8, 25.0, 30000);

-- QUERIES
SELECT *
    FROM Sailors3;

-- with aggregates
SELECT s.rating, MIN(s.age)
    FROM Sailors3 s
    GROUP BY s.rating;

-- next commented query will fail when run
/*
SELECT s.sname, s.rating, MIN(s.age)
	FROM Sailors3 s
	GROUP BY s.rating;
*/

SELECT s.sname, s.rating, MIN(s.age)
    FROM Sailors3 s
    GROUP BY s.rating, s.sname;

-- NESTED QUERIES
-- find the sailors with the highest rating
SELECT *
    FROM Sailors s
    WHERE s.rating = (
        SELECT MAX(s2.rating)
            FROM Sailors s2
    );

-- NOTE: next commented query will fail.
/*
SELECT * from Sailors s
	WHERE s.rating = (
		SELECT s2.rating FROM Sailors s2
	);
*/

-- find the sailors who reserved boat 101
SELECT *
    FROM Sailors s
    WHERE EXISTS (
        SELECT *
            FROM Reserves r
            WHERE r.bid = 101
              AND s.sid = r.sid
    );

-- select all sailors who have at least one reservation
SELECT *
    FROM Sailors s
    WHERE s.sid IN (
        SELECT r.sid
            FROM Reserves r
    );

-- select all sailors who have NO reservation
SELECT *
    FROM Sailors s
    WHERE s.sid NOT IN (
        SELECT r.sid
            FROM Reserves r
    );

-- select all sailors whose rating is higher than any sailor who reserved boat 101
SELECT *
    FROM Sailors s
    WHERE s.rating > ANY (
        SELECT s2.rating
            FROM Sailors s2,
                 Reserves r
            WHERE s2.sid = r.sid
              AND r.bid = 101
    );

-- select the name and rating for sailors who reserved boat 101
SELECT s2.sname, s2.rating
    FROM Sailors s2,
         Reserves r
    WHERE s2.sid = r.sid
      AND r.bid = 101;

-- select all sailors with the maximum age
-- sol1:
SELECT *
    FROM Sailors s
    WHERE s.age >= ALL (
        SELECT s2.age
            FROM Sailors s2
    );

-- select all sailors with the maximum age
-- sol2:
-- this query uses aggregates
SELECT *
    FROM Sailors s
    WHERE s.age = (
        SELECT MAX(s2.age)
            FROM Sailors s2
    );
