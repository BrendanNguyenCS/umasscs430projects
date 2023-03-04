-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
-- DROP TABLE reserves;
-- DROP TABLE boats;
-- DROP TABLE sailors;

-- create table sailors
CREATE TABLE sailors (
	sid 	NUMBER(9) PRIMARY KEY,
	sname	VARCHAR(20),
	rating  NUMBER(2),
	age   	NUMBER(4,2)
);

-- create table boats
CREATE TABLE boats (
	bid 	NUMBER(9) PRIMARY KEY,
	name	VARCHAR(20),
	color	VARCHAR(20)
);

--create table reserves
CREATE TABLE reserves (
	sid 	NUMBER(9) PRIMARY KEY,
	bid 	NUMBER(9) PRIMARY KEY,
	day 	DATE,
	FOREIGN KEY (sid) REFERENCES sailors,
	FOREIGN KEY (bid) REFERENCES boats
);

-- describe tables
DESC reserves;
DESC sailors;
DESC boats;

-- alter table reserves by adding a column
ALTER TABLE reserves ADD invoiceday DATE;

-- modify existing column by changing the data type
ALTER TABLE reserves MODIFY invoiceday VARCHAR(30);

-- describe table
DESC reserves;

-- alter table by renaming one column
ALTER TABLE reserves RENAME COLUMN invoiceday to invday;

-- describe table
DESC reserves;

-- rename table
ALTER TABLE reserves RENAME TO otherreserves;

-- rename table
ALTER TABLE otherreserves RENAME TO reserves;

-- alter table reserves by dropping one column
ALTER TABLE reserves DROP COLUMN invday;

-- describe table
DESC reserves;

-- insert data into sailors table
INSERT INTO sailors VALUES (22, 'dustin', 7, 45.0);
INSERT INTO sailors VALUES (31, 'lubber', 8, 55.5);
INSERT INTO sailors VALUES (58, 'rusty', 10, 35.0);
INSERT INTO sailors VALUES (59, 'rusty', 10, 45.0);

-- insert data into boats table
INSERT INTO boats VALUES ('interlake', 101, 'red');
INSERT INTO boats VALUES (102, 'clipper', 'green');

-- insert data into reserves table
INSERT INTO reserves VALUES (22, 101, TO_DATE('10/10/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (58, 101, TO_DATE('10/11/2022', 'MM/DD/YYYY'));
INSERT INTO reserves VALUES (22, 102, TO_DATE('10/20/2022', 'MM/DD/YYYY'));

-- SOME SELECT QUERIES USED TO EXTRACT DATA
SELECT * FROM sailors;
SELECT * FROM boats;
SELECT * FROM reserves;

SELECT rating, sname FROM sailors;
SELECT DISTINCT rating, sname FROM sailors;
SELECT * FROM sailors where rating = 10;

SELECT * FROM sailors, reserves WHERE sailors.sid = reserves.sid;

SELECT * FROM sailors s1, reserves r1 WHERE s1.sid = r1.sid;

SELECT * FROM sailors, reserves WHERE sailors.sid = reserves.sid AND reserves.bid = 101;

SELECT sailors.sname, boats.name, boats.color FROM sailors, reserves, boats WHERE sailors.sid = reserves.sid AND boats.bid = reserves.bid;

SELECT sname, name, color FROM sailors, reserves, boats WHERE sailors.sid = reserves.sid AND boats.bid = reserves.bid;
