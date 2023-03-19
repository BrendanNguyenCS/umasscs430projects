CREATE TABLE Customers (
    cid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(20),
    city    VARCHAR(50),
    state   VARCHAR(50),
    age     INT
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

INSERT INTO Customers VALUES (1, 'Brendan Nguyen', 'Milton', 'MA', 22);
INSERT INTO Customers VALUES (2, 'David Mitchell', 'Boston', 'MA', 59);
INSERT INTO Customers VALUES (3, 'Christine Mitchell', 'Dorchester', 'MA', 52);
INSERT INTO Customers VALUES (4, 'Agent Smith', 'Wilmington', 'MA', 29);
INSERT INTO Customers VALUES (5, 'Benjamin Franklin', 'Boston', 'MA', 29);
INSERT INTO Customers VALUES (6, 'Rose Rosa', 'Ocala', 'FL', 76);

INSERT INTO Accounts VALUES (1, 'savings', 10500);
INSERT INTO Accounts VALUES (2, 'savings', 4500);
INSERT INTO Accounts VALUES (3, 'savings', 1500);
INSERT INTO Accounts VALUES (4, 'checking', 1500);
INSERT INTO Accounts VALUES (5, 'checking', 200);
INSERT INTO Accounts VALUES (6, 'savings', 750);

INSERT INTO Has_account VALUES (1, 4, TO_DATE('01/01/2019', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (1, 2, TO_DATE('07/21/2020', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (2, 1, TO_DATE('05/05/2017', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (3, 4, TO_DATE('01/01/2019', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (4, 6, TO_DATE('03/31/1999', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (5, 3, TO_DATE('05/04/2001', 'MM/DD/YYYY'));
INSERT INTO Has_account VALUES (6, 5, TO_DATE('03/28/2007', 'MM/DD/YYYY'));
