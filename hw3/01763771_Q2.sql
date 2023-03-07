-- Answer for a)
CREATE TABLE Articles (
    aid             NUMBER(9) PRIMARY KEY,
    aname           VARCHAR(20),
    first_author    VARCHAR(50),
    pubyear         NUMBER(4),
    pubcompany      VARCHAR(50)
);

CREATE TABLE Students (
    sid     NUMBER(9) PRIMARY KEY,
    sname   VARCHAR(20),
    age     REAL,
    state   VARCHAR(20)
);

CREATE TABLE Reads (
    sid     NUMBER(9) PRIMARY KEY,
    aid     NUMBER(9) PRIMARY KEY,
    year    INT,
    PRIMARY KEY(sid, aid),
    FOREIGN KEY(sid) REFERENCES Students,
    FOREIGN KEY(aid) REFERENCES Articles
);

-- Answer for b)
INSERT INTO Students VALUES (1, 'Brendan Nguyen', 22, 'MA');
INSERT INTO Articles VALUES (1, 'Rainbow Six', 'Tom Clancy', 1998, 'G.P. Putnams Sons');
INSERT INTO Reads VALUES (1, 1,2023);

-- Answer for c)
SELECT COUNT(*) FROM Articles WHERE LOWER(first_author) LIKE '%an%';

-- Answer for d)
SELECT * FROM Articles a
    WHERE a.pubyear = (
        SELECT MAX(a2.pubyear) FROM Articles a2
    ) ORDER BY a.aname;

-- Answer for e)
SELECT s.sid, s.sname, s.age
    FROM Students s
    WHERE NOT EXISTS (
        SELECT a.aid FROM Articles a
        WHERE NOT EXISTS (
            SELECT * FROM Reads r
            WHERE r.aid = a.aid AND r.aid = s.sid
        )
    );

-- Answer for f)


-- Answer for g)


-- Answer for h)


-- Answer for i)
SELECT s.state, MIN(s.age), MAX(s.age), AVG(s.age)
    FROM Students s, Articles a, Reads r
    WHERE s.sid = r.sid AND r.aid = a.aid
    GROUP BY s.state
    HAVING COUNT(*) >= 2;

-- Answer for j)
SELECT * FROM Articles
    WHERE first_author LIKE 'B%'
    AND (pubyear <= 2018 OR pubyear >= 2020);

-- Answer for k)


-- Answer for l)