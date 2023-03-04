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
    cid NUMBER(9),
    aid NUMBER(9),
    PRIMARY KEY (cid, aid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (aid) REFERENCES Accounts
);

-- Answer for b)


-- Answer for c)
SELECT DISTINCT c.cid, c.name FROM Customers c, Accounts a, Has_account h
    -- Joining conditions
    WHERE c.cid = h.cid AND h.aid = a.aid
    -- Select conditions
    AND c.city = 'Boston' AND a.amount < 5000
    -- Order by name in descending order
    ORDER BY name DESC;

-- Answer for d)


-- Answer for e)


-- Answer for f)


-- Answer for g)


-- Answer for h)


-- Answer for i)


-- Answer for j)


-- Answer for k)


-- Answer for l)
