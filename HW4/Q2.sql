-- Answer for a)
CREATE TABLE Cars (
    carid    NUMBER(9) PRIMARY KEY,
    make     VARCHAR(40),
    model    VARCHAR(40),
    myear    INT,
    dailyfee REAL,
    CONSTRAINT ModelYearRange CHECK (myear >= 2015 AND myear <= 2020)
);

-- Answer for b)
CREATE TABLE Customers (
    custid NUMBER(9) PRIMARY KEY,
    name   VARCHAR(40) NOT NULL,
    city   VARCHAR(40) NOT NULL,
    state  VARCHAR(40) NOT NULL,
    dob    DATE        NOT NULL
);

-- Answer for c)
CREATE TABLE Rents (
    carid  NUMBER(9),
    custid NUMBER(9),
    rday   DATE NOT NULL,
    PRIMARY KEY (carid, custid),
    FOREIGN KEY (carid) REFERENCES Cars,
    FOREIGN KEY (custid) REFERENCES Customers
);

-- Answer for d)
-- Subquery version
SELECT cust1.custid, cust1.name
    FROM Customers cust1
         JOIN Rents r1 ON cust1.custid = r1.custid
         JOIN Cars car1 ON r1.carid = car1.carid
    WHERE car1.make = 'Honda'
      AND cust1.custid IN (
        SELECT cust2.custid
            FROM Customers cust2
                 JOIN Rents r2 ON cust2.custid = r2.custid
                 JOIN Cars car2 ON r2.carid = car2.carid
            WHERE car2.make = 'Toyota'
    );

-- Intersect version
SELECT cust1.custid, cust1.name
    FROM Customers cust1
         JOIN Rents r1 ON cust1.custid = r1.custid
         JOIN Cars car1 ON car1.carid = r1.carid
    WHERE car1.make = 'Honda'
INTERSECT
SELECT cust2.custid, cust2.name
    FROM Customers cust2
         JOIN Rents r2 ON cust2.custid = r2.custid
         JOIN Cars car2 ON car2.carid = r2.carid
    WHERE car2.make = 'Toyota';

-- Answers for e)
-- Subquery version
SELECT c1.carid, c1.make, c1.model
    FROM Cars c1
         JOIN Rents r1 ON c1.carid = r1.carid
    WHERE EXTRACT(YEAR FROM r1.rday) = 2020
      AND c1.carid NOT IN (
        SELECT *
            FROM Cars c2
                 JOIN Rents r2 ON c2.carid = r2.carid
            WHERE EXTRACT(YEAR FROM r2.rday) = 2022
    );

-- Intersect version
SELECT c1.carid, c1.make, c1.model
    FROM Cars c1
         JOIN Rents r1 ON c1.carid = r1.carid
    WHERE EXTRACT(YEAR FROM r1.rday) = 2020
INTERSECT
SELECT c2.carid, c2.make, c2.model
    FROM Cars c2
         JOIN Rents r2 ON c2.carid = r2.carid
    WHERE EXTRACT(YEAR FROM r2.rday) != 2022;

-- Answer for f)
INSERT INTO Cars
    VALUES (1, 'Honda', 'Civic', 2016, 95.50);
-- If we change the myear to 2013, this would be an invalid entry and thus would cause an error.