-- Answer for a)
CREATE TABLE Books (
    bid         NUMBER(9) PRIMARY KEY,
    bname       VARCHAR(40),
    author      VARCHAR(50),
    pubyear     INT,
    pubcompany  VARCHAR(50)
);

CREATE TABLE Authors (
    aid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(40),
    rating  INT,
    city    VARCHAR(50),
    state   VARCHAR(40)
);

CREATE TABLE Write (
    aid     NUMBER(9),
    bid     NUMBER(9),
    PRIMARY KEY (aid, bid),
    FOREIGN KEY (aid) REFERENCES Authors,
    FOREIGN KEY (bid) REFERENCES Books
);

-- Answer for b)


-- Answer for c)
SELECT bid, bname FROM Books WHERE pubyear IS NULL ORDER BY bname DESC;

-- Answer for d)
SELECT b.pubcompany, b.pubyear, COUNT(*) FROM Books b, Authors a, Write w
    WHERE b.bid = w.bid AND a.aid = w.aid
    GROUP BY b.pubcompany, b.pubyear;

-- Answer for e)


-- Answer for f)
UPDATE Authors SET rating = 8;

-- Answer for g)
UPDATE Books SET pubcompany = 'simon' WHERE pubyear = 2020;

-- Answer for h)


-- Answer for i)
DELETE FROM Books WHERE pubyear IS NULL;

-- Answer for j)
INSERT INTO Books VALUES (1, 'Operating Systems: Three Easy Pieces', 'Remzi Arpaci-Dusseau', 2018, 'University of Wisconsin-Madison');
INSERT INTO Authors VALUES (1, 'Remzi Arpaci-Dusseau', 9, 'Madison', 'Wisconsin');
INSERT INTO Write VALUES (1, 1);

-- Answer for k)
UPDATE Authors SET name = 'Andrea Arpaci-Dusseau', rating = 7 WHERE aid = 1;

-- Answer for l)
ALTER TABLE Authors ADD (
    phone VARCHAR(40)
);

-- Answer for m)
/*
 The statement SELECT COUNT(name) FROM AUTHORS; will count all the rows in the name column and excludes NULL values while the statement SELECT COUNT(*) FROM Authors; doesn't exclude NULL values.
 */

-- Answer for n)
DROP TABLE Write;
DROP TABLE Authors;
DROP TABLE Books;
CREATE TABLE Authors (
    aid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(40),
    rating  INT,
    city    VARCHAR(50),
    state   VARCHAR(40),
    CONSTRAINT RatingRange CHECK (rating >= 1 AND rating <= 10)
);