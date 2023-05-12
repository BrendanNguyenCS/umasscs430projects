/*
 SQL Practice file
 */

CREATE TABLE Actors (
    aid   NUMBER(9) PRIMARY KEY,
    aname VARCHAR(40),
    age   REAL,
    city  VARCHAR(50),
    state VARCHAR(40)
);

CREATE TABLE Movies (
    mid    NUMBER(9) PRIMARY KEY,
    mname  VARCHAR(50),
    year   INT,
    studio VARCHAR(50)
);

CREATE TABLE Playsin (
    aid       NUMBER(9),
    mid       NUMBER(9),
    character VARCHAR(40),
    PRIMARY KEY (aid, mid),
    FOREIGN KEY (aid) REFERENCES Actors,
    FOREIGN KEY (mid) REFERENCES Movies
);

-- Answer for a)
SELECT *
    FROM Movies
    WHERE studio = 'WB'
       OR studio = 'Universal';

-- Answer for b)
SELECT aname
    FROM Actors
    WHERE age > 25
      AND state = 'VT';

-- Answer for c)
SELECT a1.aname, a1.age
    FROM Actors a1
         JOIN Playsin p1 ON a1.aid = p1.aid
         JOIN Movies m1 ON p1.mid = m1.mid
    WHERE m1.year = 2015
MINUS
SELECT a2.aname, a2.age
    FROM Actors a2
         JOIN Playsin p2 ON a2.aid = p2.aid
         JOIN Movies m2 ON p2.mid = m2.mid
    WHERE m2.year != 2015;

-- Answer for d)
SELECT DISTINCT a.aname, a.age, a.city
    FROM Actors a,
         Playsin p,
         Movies m
    WHERE a.aid = p.aid
      AND m.mid = p.mid
      AND a.city = 'Boston'
      AND a.state = 'MA'
      AND m.studio = 'Universal';

-- Answer for e)
SELECT a.aname, a.age
    FROM Actors a,
         Playsin p,
         Movies m
    WHERE a.aid = p.aid
      AND m.mid = p.mid
      AND m.year = 2012
INTERSECT
SELECT a2.aname, a2.age
    FROM Actors a2,
         Playsin p2,
         Movies m2
    WHERE a2.aid = p2.aid
      AND m2.mid = p2.mid
      AND m2.year = 2018;

-- Answer for f)
SELECT a.aname
    FROM Actors a,
         Playsin p,
         Movies m
    WHERE a.aid = p.aid
      AND m.mid = p.mid
      AND a.age > 30
      AND m.studio = 'WB'
      AND m.year = 2018;

-- Answer for g)
SELECT a.aname, a.age, m.mname
    FROM Actors a,
         Playsin p,
         Movies m
    WHERE a.aid = p.aid
      AND m.mid = p.mid;

-- Answer for h)
SELECT a.aname, a.age
    FROM Actors a,
         Playsin p
    WHERE a.aid = p.aid
      AND a.state = 'MA'
      AND p.character = 'Batman';

-- Answer for i)
SELECT a1.aname, a1.age
    FROM Actors a1,
         Playsin p1,
         Movies m1
    WHERE a1.aid = p1.aid
      AND p1.mid = m1.mid
      AND m1.studio = 'Paramount'
MINUS
SELECT a2.aname, a2.age
    FROM Actors a2,
         Playsin p2,
         Movies m2
    WHERE a2.aid = p2.aid
      AND p2.mid = m2.mid
      AND m2.studio = 'WB'
      AND m2.year = 2020;

-- Answer for j)
SELECT DISTINCT m1.mname
    FROM Movies m1,
         Playsin p1,
         Actors a1
    WHERE m1.mid = p1.mid
      AND p1.aid = a1.aid
      AND a1.state = 'MA'
INTERSECT
SELECT DISTINCT m2.mname
    FROM Movies m2,
         Playsin p2,
         Actors a2
    WHERE m2.mid = p2.mid
      AND p2.aid = a2.aid
      AND a2.state = 'NY';