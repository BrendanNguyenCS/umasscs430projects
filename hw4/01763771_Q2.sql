-- Answer for a)
CREATE TABLE Cars (
    carid       NUMBER(9) PRIMARY KEY,
    make        VARCHAR(40),
    model       VARCHAR(40),
    myear       INT,
    dailyfee    REAL
    CONSTRAINT MYearRange CHECK (myear >= 2015 AND myear <= 2020)
);

-- Answer for b)
CREATE TABLE Customers (
    custid  NUMBER(9) PRIMARY KEY NOT NULL,
    name    VARCHAR(40) NOT NULL,
    city    VARCHAR(40) NOT NULL,
    state   VARCHAR(40) NOT NULL,
    dob     DATE NOT NULL
);

-- Answer for c)
CREATE TABLE Rents (
    carid   NUMBER(9),
    custid  NUMBER(9),
    rday    DATE NOT NULL,
    PRIMARY KEY (carid, custid),
    FOREIGN KEY (carid) REFERENCES Cars,
    FOREIGN KEY (custid) REFERENCES Customers
);

-- Answer for d)
SELECT cust1.custid, cust1.name FROM Customers cust1, Cars car1, Rents r
    WHERE cust1.custid = r.custid AND car1.carid = r.carid
    AND car1.model = 'Honda' AND cust1.custid IN (
        SELECT cust2.custid FROM Customers cust2, Cars car2, Rents r2
            WHERE cust2.custid = r2.custid AND car2.carid = r2.carid
            AND car2.model = 'Toyota'
    );

-- Answer for e)


-- Answer for f)
INSERT INTO Cars VALUES (1, 'Civic', 'Honda', 2016, 95.50);
    -- If we change the myear to 2013, this would be an invalid entry and thus would cause an error.