-- SQL Practice 4
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT FOUR LINES TO DROP THE TABLES FIRST)
--DROP TABLE reserves;
--DROP TABLE boats;
--DROP TABLE sailors;
--DROP TABLE sailors3;

-- create table sailors
CREATE TABLE sailors(
	sid 	NUMBER(9) PRIMARY KEY,
	sname	VARCHAR(20),
	rating  NUMBER(2),
	age   	NUMBER(4,2)
);

-- create table boats
CREATE TABLE boats(
	bid 	NUMBER(9) PRIMARY KEY,
	name	VARCHAR(20),
	color	VARCHAR(20)
);

--create table reserves
CREATE TABLE reserves(
	sid 	NUMBER(9),
	bid 	NUMBER(9),
	day 	DATE,
	PRIMARY KEY(sid,bid),
	FOREIGN KEY (sid) REFERENCES sailors,
	FOREIGN KEY (bid) REFERENCES boats
);

CREATE TABLE SAILORS3(
	sid 	NUMBER(9) PRIMARY KEY,
	sname	VARCHAR(20),
	rating  NUMBER(2),
	age   	NUMBER(4,2),
	salary 	NUMBER(9)
);

-- describe tables
DESC reserves;
DESC sailors;
DESC boats;
DESC sailors3;


-- insert data into sailors table
INSERT INTO SAILORS(sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO SAILORS
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO SAILORS
	VALUES (58, 'rusty', 10, 35.0);
INSERT INTO SAILORS
	VALUES (59, 'rusty', 10, 45.0);

-- insert data into boats table
INSERT INTO boats (name, bid, color)
	VALUES ('interlake', 101, 'red');
INSERT INTO boats(bid, name, color)
	VALUES (102, 'clipper', 'green');
INSERT INTO boats(bid, name, color)
	VALUES (103, 'transatlantic', 'red');
INSERT INTO boats(bid, name, color)
	VALUES (104, 'vacation', 'white');
INSERT INTO boats(bid, name, color)
	VALUES (105, 'hawaii', 'green');
INSERT INTO boats(bid, name, color)
	VALUES (106, 'sea', 'green');

-- insert data into reserves table
INSERT INTO reserves VALUES (22,101,TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (58,101,TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (22,102,TO_DATE('10/20/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (59,103,TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- insert data into sailors3 table
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (22, 'dustin', 7, 45.0,20000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (31, 'lubber', 8, 55.5, 30000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (58, 'rusty', 10, 35.0, 15000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (59, 'rusty', 10, 45.0, 40000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (60, 'andy', 10, 60.0, 25000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (61, 'mary', 8, 25.0, 30000);

-- QUERIES

SELECT * FROM sailors3;

-- with aggregates

SELECT s.rating, MIN(s.age) FROM SAILORS3 s GROUP BY s.rating;

-- next commented query will fail when run
--SELECT s.sname,s.rating, MIN(s.age)
--FROM SAILORS3 s
--GROUP BY s.rating;

SELECT s.sname,s.rating, MIN(s.age)
	FROM SAILORS3 s
	GROUP BY s.rating, s.sname;

---- NESTED QUERIES

-- find the sailors with the highest rating
SELECT * FROM sailors s
	WHERE s.rating = (SELECT MAX(s2.rating) FROM sailors s2);

-- NOTE: next commented query will fail.
--SELECT * from sailors s
--WHERE s.rating = (SELECT s2.rating
--                              FROM sailors s2);


-- find the sailors who reserved boat 101
SELECT * FROM Sailors s
	WHERE EXISTS (
		SELECT * FROM Reserves r
			WHERE r.bid = 101 AND s.sid = r.sid
	);

-- select all sailors who have at least one reservation
SELECT * FROM Sailors s
    WHERE s.sid IN (SELECT r.sid FROM Reserves r);

-- select all sailors who have NO reservation
SELECT * FROM Sailors s
	WHERE s.sid NOT IN (SELECT r.sid FROM Reserves r);

-- select all sailors whose rating is higher than any sailor who reserved boat 101
SELECT * FROM Sailors s
	WHERE s.rating > ANY (
		SELECT s2.rating
		   FROM Sailors s2,Reserves r
		   WHERE s2.sid=r.sid AND r.bid=101
	);

-- select the name and rating for sailors who reserved boat 101
SELECT  s2.sname, s2.rating
	FROM Sailors s2,Reserves r
	WHERE s2.sid = r.sid AND r.bid=101;

-- select all sailors with the maximum age
-- sol1:
SELECT * FROM Sailors s
	WHERE s.age >= ALL (SELECT s2.age FROM Sailors s2);

-- select all sailors with the maximum age
-- sol2:
-- this query uses aggregates
SELECT * FROM Sailors s
	WHERE s.age = (SELECT MAX(s2.age) FROM Sailors s2);

