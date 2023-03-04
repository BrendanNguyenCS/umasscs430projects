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
    PRIMARY KEY(sid, aid),
    FOREIGN KEY(sid) REFERENCES Students,
    FOREIGN KEY(aid) REFERENCES Articles
);

-- Answer for b)


-- Answer for c)
SELECT COUNT(*) FROM Articles WHERE LOWER(first_author) LIKE '%an%';

-- Answer for d)
SELECT * FROM Articles
    WHERE pubyear = (
        SELECT MAX(pubyear) FROM Articles
    ) ORDER BY aname;

-- Answer for e)


-- Answer for f)


-- Answer for g)


-- Answer for h)


-- Answer for i)


-- Answer for j)
