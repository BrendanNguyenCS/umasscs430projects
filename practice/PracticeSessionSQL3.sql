-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
DROP TABLE reserves;
DROP TABLE boats;
DROP TABLE sailors;
DROP TABLE sailors2;

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

CREATE TABLE sailors2(
	sid 	NUMBER(9) PRIMARY KEY,
	sname	VARCHAR(20),
	rating  NUMBER(2),
	age   	NUMBER(4,2)
);

-- describe tables
DESC reserves;
DESC sailors;
DESC boats;
DESC sailors2;

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
INSERT INTO boats(name, bid, color)
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
INSERT INTO reserves VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (59, 103, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- insert data into sailors2 table
INSERT INTO sailors2(sid, sname, rating, age)
	VALUES (20, 'joe', 9, 24.0);
INSERT INTO sailors2(sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO sailors2(sid, sname, rating, age)
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO sailors2(sid, sname, rating, age)
	VALUES (60, 'andy', 9, 60.0);


--- some operations

SELECT sname, rating, (rating-1)/2 AS newcol FROM sailors;
SELECT sname, rating, (rating-1) FROM sailors;

--UNION, INTERSECT
SELECT * FROM sailors
	UNION
	SELECT * FROM sailors2;

SELECT * FROM sailors
	UNION ALL
	SELECT * FROM sailors2;

SELECT * FROM sailors
	INTERSECT
	SELECT * FROM sailors2;

(SELECT * FROM sailors WHERE rating > 8)
	UNION
	(SELECT * FROM sailors2 WHERE rating < 8);



--- operation with aggregates
SELECT AVG(rating) FROM sailors;
-- with WHERE clause
SELECT SUM(rating) FROM sailors WHERE age > 40;

-- next commented out query will return an error if run
--SELECT age,AVG(rating) from sailors;

--GROUP BY
SELECT rating, AVG(age) FROM sailors GROUP BY rating;
-- group by and order by
SELECT age, AVG(rating) FROM sailors GROUP BY age ORDER BY AVG(rating);
-- group by with renaming aggregate
SELECT age, AVG(rating) AS avgrating FROM sailors GROUP BY age ORDER BY avgrating;


-- GROUP BY AND HAVING
-- how many boats of each color I have ?
SELECT COUNT(*) FROM boats GROUP BY color;
-- how many boats of each color I have ? Include in the results boats with an id greater than 102
SELECT COUNT(*) FROM boats WHERE bid > 102 GROUP BY color;

-- MORE PRACTICE
SELECT * FROM reserves;

-- Find how many reservations for each boat color we have.
SELECT color, COUNT(*)
	FROM reserves r, boats b
	WHERE r.bid = b.bid
	GROUP BY color;

-- Find how many reservation for each boat color we have. Count each unique boat only once.
SELECT color, COUNT(distinct r.bid)
	FROM reserves r, boats b
	WHERE r.bid = b.bid
	GROUP BY color;
