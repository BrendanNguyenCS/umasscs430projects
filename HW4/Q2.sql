-- Answer for a)
CREATE TABLE Cars (
    carid       NUMBER(9) PRIMARY KEY,
    make        VARCHAR(40),
    model       VARCHAR(40),
    myear       INT,
    dailyfee    REAL,
    CONSTRAINT ModelYearRange CHECK (myear >= 2015 AND myear <= 2020)
);

-- Answer for b)
CREATE TABLE Customers (
    custid  NUMBER(9) PRIMARY KEY,
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
SELECT cust1.custid, cust1.name
    FROM Customers cust1, Cars car1, Rents r
    -- Joining conditions
    WHERE cust1.custid = r.custid AND car1.carid = r.carid
    -- A Honda was rented
    AND car1.make = 'Honda'
    -- A Toyota was also rented
    AND cust1.custid IN (
        SELECT cust2.custid FROM Customers cust2, Cars car2, Rents r2
            -- Joining conditions
            WHERE cust2.custid = r2.custid AND car2.carid = r2.carid
            -- A Toyota car was rented
            AND car2.make = 'Toyota'
    );

-- Answer for e)
SELECT c1.carid, c1.make, c1.model
    FROM Cars c1, Rents r1
    -- Joining condition
    WHERE c1.carid = r1.carid
    -- Car was rented in 2020
    AND EXTRACT(YEAR FROM r1.rday) = 2020
    -- But not in 2022
    AND c1.carid NOT IN (
        SELECT * FROM Cars c2, Rents r2
            -- Joining condition
            WHERE c2.carid = r2.carid
            -- Car was rented in 2022
            AND EXTRACT(YEAR FROM r2.rday) = 2022
    );

-- Answer for f)
INSERT INTO Cars
    VALUES (1, 'Honda', 'Civic', 2016, 95.50);
    -- If we change the myear to 2013, this would be an invalid entry and thus would cause an error.