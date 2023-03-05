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
    year    NUMBER(4),
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


-- Answer for f)


-- Answer for g)


-- Answer for h)


-- Answer for i)


-- Answer for j)


-- Answer for k)


-- Answer for l)