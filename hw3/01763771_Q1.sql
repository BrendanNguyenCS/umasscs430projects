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
    since   DATE,
    PRIMARY KEY (cid, aid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (aid) REFERENCES Accounts
);

-- Answer for b)
INSERT INTO Customers VALUES (1, 'Brendan Nguyen', 'Milton', 'MA', 22);
INSERT INTO Customers VALUES (2, 'Trent Murphy', 'Los Angeles', 'CA', 20);
INSERT INTO Accounts VALUES (1, 'savings', 5000);
INSERT INTO Accounts VALUES (2, 'checking', 2000);
INSERT INTO Has_account VALUES (2, 1);
INSERT INTO Has_account VALUES (1, 2);

-- Answer for c)
SELECT DISTINCT c.cid, c.name FROM Customers c, Accounts a, Has_account h
    -- Joining conditions
    WHERE c.cid = h.cid AND h.aid = a.aid
    -- Select conditions
    AND c.city = 'Boston' AND a.amount < 5000
    -- Order by name in descending order
    ORDER BY name DESC;

-- Answer for d)
SELECT c.cid, c.name, c.age FROM Customers c
    WHERE c.cid NOT IN (
        SELECT h.cid FROM Customers c2, Has_account h
            WHERE c2.cid = h.cid
            AND h.since >= TO_DATE('01/01/2020', 'MM/DD/YYYY')
            AND h.since <= TO_DATE('12/01/2021', 'MM/DD/YYYY')
    );

-- Answer for e)


-- Answer for f)


-- Answer for g)


-- Answer for h)


-- Answer for i)


-- Answer for j)
