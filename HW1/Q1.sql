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
SELECT * FROM Books WHERE author = 'joyce';

-- Answer for b)
SELECT author, pubyear FROM Books WHERE author = 'joyce';

-- Answer for c)
SELECT * FROM Students s, Reads r
    WHERE s.sid = r.sid
    AND s.sname = 'mary';

-- Answer for d)
SELECT * FROM Students s, Reads r
    WHERE s.sname = 'MA' AND r.year = 2020;

-- Answer for e)
SELECT bid, bname AS "name", author, pubyear, pubcompany
    FROM Books WHERE pubcompany = 'simon' OR pubcompany = 'alien';

-- Answer for f)
SELECT * FROM Students s, Reads r, Books b
    WHERE s.sid = r.sid AND b.bid = r.bid
    AND b.pubyear < 1950;