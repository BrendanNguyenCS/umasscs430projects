CREATE TABLE Cars (
    carid       NUMBER(9) PRIMARY KEY,
    make        VARCHAR(40),
    model       VARCHAR(40),
    myear       INT,
    dailyfee    REAL,
    CONSTRAINT MYearRange CHECK (myear >= 2015 AND myear <= 2020)
);

CREATE TABLE Customers (
    custid  NUMBER(9) PRIMARY KEY,
    name    VARCHAR(40) NOT NULL,
    city    VARCHAR(40) NOT NULL,
    state   VARCHAR(40) NOT NULL,
    dob     DATE NOT NULL
);

CREATE TABLE Rents (
    carid   NUMBER(9),
    custid  NUMBER(9),
    rday    DATE NOT NULL,
    PRIMARY KEY (carid, custid),
    FOREIGN KEY (carid) REFERENCES Cars,
    FOREIGN KEY (custid) REFERENCES Customers
);

INSERT INTO Cars VALUES (1, 'Honda', 'Civic', 2016, 95.50);
INSERT INTO Cars VALUES (2, 'Honda', 'Accord', 2018, 105.00);
INSERT INTO Cars VALUES (3, 'Honda', 'Fit', 2017, 83.00);
INSERT INTO Cars VALUES (4, 'Toyota', 'Sienna', 2020, 135.00);
INSERT INTO Cars VALUES (5, 'Lamborghini', 'Aventador', 2019, 500.00);
INSERT INTO Cars VALUES (6, 'Tesla', 'Model Y', 2020, 140.00);
INSERT INTO Cars VALUES (7, 'Ford', 'Bronco', 2021, 125.00); -- Should fail
INSERT INTO Cars VALUES (8, 'Hennessey', 'Venom GT', 2017, 650.00);
INSERT INTO Cars VALUES (9, 'Ford', 'GT', 2018, 450.00);
INSERT INTO Cars VALUES (10, 'Toyota', 'Avalon', 2019, 101.00);
INSERT INTO Cars VALUES (11, 'Chevrolet', 'Colorado', 2018, 111.11);
INSERT INTO Cars VALUES (12, 'Chrysler', 'Pacifica', 2020, 115.00);

INSERT INTO Customers VALUES (1, 'Brendan', 'Boston', 'MA', TO_DATE('07/21/2000', 'MM/DD/YYYY'));
INSERT INTO Customers VALUES (2, 'Dennis', 'Boston', 'MA', TO_DATE('01/23/2022', 'MM/DD/YYYY'));
INSERT INTO Customers VALUES (3, 'Thomas', 'Burlington', 'VT', TO_DATE('10/11/2002'));
INSERT INTO Customers VALUES (4, 'Alberto', 'Quincy', 'MA', TO_DATE('09/21/2002', 'MM/DD/YYYY'));
INSERT INTO Customers VALUES (5, 'Joseph', 'Revere', 'MA', TO_DATE('03/13/2003', 'MM/DD/YYYY'));

INSERT INTO Rents VALUES (1, 1, TO_DATE('02/02/2020', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (10, 1, TO_DATE('02/02/2021', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (1, 2, TO_DATE('10/12/2021', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (10, 3, TO_DATE('03/17/2022', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (11, 5, TO_DATE('02/02/2023', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (3, 2, TO_DATE('09/11/2019', 'MM/DD/YYYY'));
INSERT INTO Rents VALUES (11, 4, TO_DATE('11/11/2020', 'MM/DD/YYYY'));