-- Answer for a)
CREATE TABLE Movies (
    mid         NUMBER(9) PRIMARY KEY,
    title       VARCHAR(50),
    director    VARCHAR(40),
    studio      VARCHAR(40),
    releaseyear INT
);

-- Answer for b)
CREATE TABLE Customers (
    cid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(40),
    city  VARCHAR(40),
    state VARCHAR(40),
    age   REAL,
    CONSTRAINT MatureOnly CHECK (age >= 18)
);

-- Answer for c)
CREATE TABLE Watch (
    mid       NUMBER(9),
    cid       NUMBER(9),
    watchedon DATE,
    PRIMARY KEY (mid, cid),
    FOREIGN KEY (mid) REFERENCES Movies,
    FOREIGN KEY (cid) REFERENCES Customers
);

-- Answer for d)
CREATE INDEX indexWatchDate ON Watch (watchedon);

-- Answer for e)
INSERT INTO Movies
    VALUES (1, 'Glass Onion: A Knives Out Mystery', 'Rian Johnson', 'Netflix', 2022);
INSERT INTO Customers
    VALUES (1, 'Brendan', 'Boston', 'MA', 22);
INSERT INTO Watch
    VALUES (1, 1, TO_DATE('04/19/2023', 'MM/DD/YYYY'));

-- Answer for f)
SELECT DISTINCT m.mid, m.title
    FROM Movies m
         JOIN Watch w ON m.mid = w.mid
    WHERE w.watchedon >= TO_DATE('01/01/2022', 'MM/DD/YYYY')
      AND w.watchedon <= TO_DATE('07/31/2022', 'MM/DD/YYYY');

-- Answer for g)
SELECT c.cid, c.name, m.mid, m.title, m.director, w.watchedon
    FROM Customers c
         JOIN Watch w ON c.cid = w.cid
         JOIN Movies m ON w.mid = m.mid
    ORDER BY 6 DESC;