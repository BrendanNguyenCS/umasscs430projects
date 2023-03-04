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

INSERT INTO Customers VALUES (1, 'Brendan Nguyen', 'Milton', 'MA', 22);
INSERT INTO Customers VALUES (2, 'David Nguyen', 'Boston', 'MA', 59);
INSERT INTO Customers VALUES (3, 'Christine Ha-Nguyen', 'Dorchester', 'MA', 52);
INSERT INTO Customers VALUES (4, 'Jonathan Nguyen', 'Wilmington', 'MA', 29);
INSERT INTO Customers VALUES (5, 'Ben Duong', 'Boston', 'MA', 29);
INSERT INTO Customers VALUES (6, 'Rose Henley', 'Ocala', 'FL', 76);