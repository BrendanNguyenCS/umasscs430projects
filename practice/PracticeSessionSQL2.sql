-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
-- DROP TABLE reserves;
-- DROP TABLE boats;
-- DROP TABLE sailors;


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

-- describe tables
DESC reserves;
DESC sailors;
DESC boats;

-- insert data into sailors table
INSERT INTO sailors VALUES (22, 'dustin', 7, 45.0);
INSERT INTO sailors VALUES (31, 'lubber', 8, 55.5);
INSERT INTO sailors VALUES (58, 'rusty', 10, 35.0);
INSERT INTO sailors VALUES (59, 'rusty', 10, 45.0);

-- insert data into boats table
INSERT INTO boats VALUES ('interlake', 101, 'red');
INSERT INTO boats VALUES (102, 'clipper', 'green');

-- insert data into reserves table
INSERT INTO reserves VALUES (22,101,TO_DATE('10/10/2022', 'mm/dd/yyyy'));
INSERT INTO reserves VALUES (58,101,TO_DATE('10/11/2022', 'mm/dd/yyyy'));
INSERT INTO reserves VALUES (22,102,TO_DATE('10/20/2022', 'mm/dd/yyyy'));

SELECT * FROM sailors, reserves WHERE sailors.sid = reserves.sid;

--sort by queries
SELECT * FROM sailors;
SELECT * FROM sailors ORDER BY age;
SELECT * FROM sailors ORDER BY age DESC;
SELECT * FROM sailors ORDER BY 4 DESC;
SELECT * FROM sailors ORDER BY 4,3 DESC;
SELECT * FROM sailors ORDER BY 4,rating DESC;

--next commented out qyery will give an error if run
--select * FROM sailors,reserves where sailors.sid=reserves.sid order by sid;
SELECT * FROM sailors,reserves WHERE sailors.sid = reserves.sid ORDER BY 1;

--LIKE keyword
SELECT * FROM sailors WHERE sname='dustin';
SELECT * FROM sailors WHERE sname LIKE'dustin';
SELECT * FROM sailors WHERE sname LIKE '%stin';
SELECT * FROM sailors WHERE sname LIKE '%st';
SELECT * FROM sailors WHERE sname LIKE '%st%';

-- case insensitive text matches
SELECT * FROM sailors WHERE UPPER(sname) = UPPER('Dustin');
SELECT * FROM sailors WHERE LOWER(sname) = LOWER('Dustin');

--other queries
SELECT s.sid, s.sname, b.color, r.day FROM sailors s, reserves r, boats b
    WHERE s.sid = r.sid AND r.bid = b.bid AND r.day < TO_DATE('10/11/2022','MM/DD/YYYY');

SELECT s.sid, s.sname, b.color, r.day FROM sailors s, reserves r, boats b
    WHERE s.sid = r.sid AND r.bid = b.bid AND r.day <= TO_DATE('10/11/2022','MM/DD/YYYY');

SELECT UPPER(sname)
	FROM sailors s, reserves r, boats b
	WHERE s.sid = r.sid AND r.bid = b.bid
	AND s.age > 30 AND (b.color = 'red' OR b.color = 'green');

SELECT sname
	FROM sailors s, reserves r, boats b
	WHERE s.sid = r.sid AND r.bid = b.bid
	AND s.age > 30 AND (b.color = 'red' OR b.color = 'green');

SELECT COUNT(DISTINCT b.bid)
	FROM reserves r, boats b
	WHERE r.bid = b.bid AND b.color = 'green';
