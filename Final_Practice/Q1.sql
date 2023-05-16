CREATE TABLE Students (
    sid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(40),
    city  VARCHAR(50),
    state VARCHAR(40),
    age   INT,
    CONSTRAINT MinAge CHECK (age >= 21)
);

CREATE TABLE Rents (
    cid      NUMBER(9),
    sid      NUMBER(9),
    price    INT,
    rentdate DATE,
    PRIMARY KEY (cid, sid),
    FOREIGN KEY (cid) REFERENCES Cars,
    FOREIGN KEY (sid) REFERENCES Students
);

-- Answer for 1)
SELECT COUNT(*)
    FROM Students
    WHERE state = 'MA';

-- Answer for 2)
SELECT state, COUNT(*)
    FROM Students
    GROUP BY state;

-- Answer for 3)
SELECT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make = 'Honda'
      AND c.model = 'Accord'
INTERSECT
SELECT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make = 'Toyota'
      AND c.model = 'Prius';

-- Answer for 4)
SELECT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make = 'Toyota'
      AND c.model = 'Prius'
MINUS
SELECT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make != 'Toyota'
      AND c.model != 'Prius';

-- Answer for 5)
SELECT s.sid, s.name
    FROM Students s
    WHERE NOT EXISTS (
        SELECT c.cid
            FROM Cars c
            WHERE NOT EXISTS (
                SELECT r.cid
                    FROM Rents r
                    WHERE r.cid = c.cid
                      AND r.sid = s.sid
            )
    );

SELECT s.sid, s.name
    FROM Students s
    WHERE NOT EXISTS (
        SELECT c.cid
            FROM Cars c
        MINUS
        SELECT r.cid
            FROM Rents r
            WHERE r.sid = s.sid
    );

SELECT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    GROUP BY s.sid, s.name
    HAVING COUNT(DISTINCT c.cid) = (
        SELECT COUNT(*)
            FROM Cars
    );

-- Answer for 6)
CREATE VIEW Cars2020 AS
    SELECT *
        FROM Cars
        WHERE myear = 2020;

-- Answer for 7)
CREATE TABLE Cars (
    cid   NUMBER(9) PRIMARY KEY,
    make  VARCHAR(20),
    model VARCHAR(20),
    myear NUMBER(9) CHECK (myear >= 2010)
);

-- Answer for 8)
SELECT AVG(state), state
    FROM Students
    GROUP BY state
    HAVING COUNT(*) > 99;

-- Answer for 9)
SELECT COUNT(r.cid), s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
    WHERE UPPER(s.name) LIKE UPPER('a%')
    GROUP BY s.sid, s.name;

-- Answer for 10)
SELECT DISTINCT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
    WHERE EXTRACT(YEAR FROM r.rentdate) = 2018
MINUS
SELECT DISTINCT s.sid, s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
    WHERE EXTRACT(YEAR FROM r.rentdate) != 2018;

-- Answer for 11)
SELECT *
    FROM Cars
    WHERE make = 'Honda'
      AND model = 'Accord'
      AND myear < 2018;

-- Answer for 12)
SELECT cid
    FROM Cars
    WHERE make = 'Honda'
      AND model = 'Accord'
      AND myear < 2018;

-- Answer for 13)
SELECT s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make = 'Honda'
      AND EXTRACT(YEAR FROM r.rentdate) = 2018
MINUS
SELECT s.name
    FROM Students s
         JOIN Rents r ON s.sid = r.sid
         JOIN Cars c ON r.cid = c.cid
    WHERE c.make = 'Honda'
      AND EXTRACT(YEAR FROM r.rentdate) != 2018;