-- Answer for a)
CREATE TABLE Articles (
    aid          NUMBER(9) PRIMARY KEY,
    aname        VARCHAR(100),
    first_author VARCHAR(50),
    pubyear      INT,
    pubcompany   VARCHAR(50)
);

CREATE TABLE Students (
    sid   NUMBER(9) PRIMARY KEY,
    sname VARCHAR(20),
    age   REAL,
    state VARCHAR(20)
);

CREATE TABLE Reads (
    sid  NUMBER(9),
    aid  NUMBER(9),
    year INT,
    PRIMARY KEY (sid, aid),
    FOREIGN KEY (sid) REFERENCES Students,
    FOREIGN KEY (aid) REFERENCES Articles
);

-- Answer for b)
INSERT INTO Students
    VALUES (1, 'Brendan Nguyen', 22, 'MA');
INSERT INTO Articles
    VALUES (1, 'Rainbow Six', 'Tom Clancy', 1998, 'G.P. Putnam''s Sons');
INSERT INTO Reads
    VALUES (1, 1, 2023);

-- Answer for c)
SELECT COUNT(*)
    FROM Articles
    WHERE LOWER(first_author) LIKE '%an%';

-- Answer for d)
SELECT *
    FROM Articles a
    WHERE a.pubyear = (
        SELECT MAX(a2.pubyear)
            FROM Articles a2
    )
    ORDER BY a.aname;

-- Answer for e)
SELECT s.sid, s.sname, s.age
    FROM Students s
    WHERE NOT EXISTS (
        SELECT a.aid
            FROM Articles a
        MINUS
        SELECT r.aid
            FROM Reads r
            WHERE r.sid = s.sid
    );

-- Answer for f)
-- Subquery version
SELECT s.sid, s.sname
    FROM Students s,
         Articles a,
         Reads r
    WHERE s.sid = r.sid
      AND r.aid = a.aid
      AND a.pubyear = 2020
      AND s.sid NOT IN (
        SELECT s2.sid
            FROM Students s2,
                 Articles a2,
                 Reads r2
            WHERE s2.sid = r2.sid
              AND r2.aid = a2.aid
              AND a2.pubyear = 2018
    )
    ORDER BY s.sname DESC;

-- Intersect version
SELECT s1.sid, s1.sname
    FROM Students s1
         JOIN Reads r1 ON s1.sid = r1.sid
         JOIN Articles a1 ON a1.aid = r1.aid
    WHERE a1.pubyear = 2020
INTERSECT
SELECT s2.sid, s2.sname
    FROM Students s2
         JOIN Reads r2 ON s2.sid = r2.sid
         JOIN Articles a2 ON r2.aid = a2.aid
    WHERE a2.pubyear != 2018
ORDER BY sname DESC;

-- Answer for g)
SELECT DISTINCT s.sid, s.sname
    FROM Students s,
         Articles a,
         Reads r
    WHERE s.sid = r.sid
      AND r.aid = a.aid
      AND r.year = a.pubyear;

-- Answer for h)
SELECT s.sid, COUNT(*)
    FROM Students s,
         Reads r
    WHERE s.sid = r.sid
    GROUP BY s.sid
    HAVING COUNT(*) >= 3;

-- Answer for i)
SELECT state, MIN(age), MAX(age), AVG(age)
    FROM Students s
    GROUP BY state
    HAVING COUNT(*) >= 2;

-- Answer for j)
SELECT *
    FROM Articles
    WHERE first_author LIKE 'B%'
      AND (pubyear <= 2018 OR pubyear >= 2020);

-- Answer for k)
SELECT DISTINCT s.sid, s.sname
    FROM Students s
    WHERE NOT EXISTS (
        SELECT a.aid
            FROM Articles a
            WHERE a.pubcompany = 'penguin'
              AND a.pubyear = 2022
              AND NOT EXISTS (
                SELECT *
                    FROM Reads r
                    WHERE r.aid = a.aid
                      AND r.sid = s.sid
            )
    );

-- Answer for l)
SELECT DISTINCT s.sid, s.sname, s.age, s.state
    FROM Students s
    WHERE EXISTS (
        SELECT a.aid
            FROM Articles a
            WHERE a.pubcompany = 'simon'
              AND NOT EXISTS (
                SELECT *
                    FROM Reads r
                    WHERE r.aid = a.aid
                      AND r.sid = s.sid
            )
    );