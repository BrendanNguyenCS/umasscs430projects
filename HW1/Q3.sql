/*
 SQL Practice file
 */

CREATE TABLE Books (
    bid         NUMBER(9) PRIMARY KEY,
    bname       VARCHAR(40),
    author      VARCHAR(40),
    pubyear     INT,
    pubcompany  VARCHAR(50)
);

CREATE TABLE Students (
    sid     NUMBER(9) PRIMARY KEY,
    sname   VARCHAR(40),
    age     REAL,
    state   VARCHAR(30)
);

CREATE TABLE Reads (
    sid     NUMBER(9),
    bid     NUMBER(9),
    year    INT,
    PRIMARY KEY (sid, bid),
    FOREIGN KEY (sid) REFERENCES Students,
    FOREIGN KEY (bid) REFERENCES Books
);

-- Answer for a)
SELECT * FROM Students s WHERE s.age = (
    SELECT MIN(s2.age) FROM Students s2
);

-- Answer for b)
SELECT * FROM Books WHERE pubyear = 2010 OR pubyear = 2020;

-- Answer for c)
SELECT b.bname, b.pubyear, b.pubcompany FROM Books b WHERE b.pubyear = (
    SELECT MIN(b2.pubyear) FROM Books b2
);

-- Answer for d)
(SELECT s.sname FROM Students s, Reads r
    WHERE s.sid = r.sid
    AND r.year = 2015 AND s.state = 'MA')
INTERSECT
(SELECT s2.sname FROM Students s2, Reads r2
    WHERE s2.sid = r2.sid
    AND r2.year = 2018 AND s2.state = 'MA');

-- Answer for e)
SELECT b.bname FROM Books b
    WHERE NOT EXISTS (
        (SELECT s.sid FROM Students s)
        MINUS
        (SELECT r.sid FROM Reads r WHERE r.bid = b.bid)
    );