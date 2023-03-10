-- Answer for a)
CREATE TABLE Customers (
    cid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(20),
    city    VARCHAR(50),
    state   VARCHAR(50),
    age     REAL
);

CREATE TABLE Accounts (
    aid     NUMBER(9) PRIMARY KEY,
    atype   VARCHAR(50),
    amount  REAL
);

CREATE TABLE Has_account (
    cid     NUMBER(9),
    aid     NUMBER(9),
    since   INT,
    PRIMARY KEY (cid, aid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (aid) REFERENCES Accounts
);

-- Answer for b)
INSERT INTO Customers VALUES (1, 'Brendan Nguyen', 'Milton', 'MA', 22);
INSERT INTO Customers VALUES (2, 'Trent Murphy', 'Los Angeles', 'CA', 20);
INSERT INTO Accounts VALUES (1, 'savings', 5000);
INSERT INTO Accounts VALUES (2, 'checking', 2000);
INSERT INTO Has_account VALUES (2, 1, 2010);
INSERT INTO Has_account VALUES (1, 2, 2011);

-- Answer for c)
SELECT DISTINCT c.cid, c.name FROM Customers c, Accounts a, Has_account h
    -- Joining conditions
    WHERE c.cid = h.cid AND h.aid = a.aid
    -- Select conditions
    AND c.city = 'Boston' AND a.amount < 5000
    -- Order by name in descending order
    ORDER BY name DESC;

-- Answer for d)
SELECT DISTINCT c.cid, c.name, c.age FROM Customers c
    WHERE c.cid NOT IN (
        SELECT h.cid FROM Customers c2, Has_account h
            WHERE c2.cid = h.cid
            AND h.since >= TO_DATE('01/01/2020', 'MM/DD/YYYY')
            AND h.since <= TO_DATE('12/01/2021', 'MM/DD/YYYY')
    );

-- Answer for e)
SELECT DISTINCT c.cid, c.name, c.age FROM Customers c, Has_account h, Accounts a
    WHERE c.cid = h.cid AND h.aid = a.aid
    AND a.atype = 'savings' AND c.cid IN (
        SELECT c2.cid FROM Customers c2, Has_account h2, Accounts a2
            WHERE c.cid = h.cid AND h.aid = a.aid AND a.atype = 'checking'
    );

-- Answer for f)
SELECT c.cid, c.name FROM Customers c, Has_account h, Accounts a
    WHERE c.cid = h.cid AND h.aid = a.aid
    GROUP BY c.cid, c.name
    HAVING SUM(a.amount) <= 10000;

-- Answer for g)
SELECT a.aid FROM Accounts a
    WHERE a.atype = 'checking' AND 2 <= (
        SELECT COUNT(*) FROM Has_account h WHERE h.aid = a.aid
    );

-- Answer for h)
SELECT DISTINCT c.cid, COUNT(*)
    FROM Customers c, Accounts a, Has_account h
    -- Joining conditions
    WHERE c.cid = h.cid AND h.aid = a.aid
    -- Customer age between 25 and 35 with more than 2 accounts
    AND c.age > 25 AND c.age < 35
    GROUP BY c.cid
    HAVING COUNT(*) >= 2;

-- Answer for i)
SELECT DISTINCT c.cid, c.name, c.age FROM Customers c, Has_account h
    WHERE c.cid = h.cid
    AND h.since = 2020 AND h.cid IN (
        SELECT h2.cid FROM Customers c2, Has_account h2
            WHERE h2.cid = c2.cid AND h2.since = 2018
    );

-- Answer for j)
SELECT DISTINCT c.cid, c.name FROM Customers c, Accounts a, Has_account h
    WHERE c.cid = h.cid AND h.aid = a.aid
    AND c.state = 'MA' AND a.atype = 'savings'
    GROUP BY c.cid, c.name
    HAVING COUNT(*) >= 2;