CREATE TABLE Articles (
    aid     NUMBER(9) PRIMARY KEY,
    title   VARCHAR(40),
    author  VARCHAR(50),
    pubyear INT
);

CREATE TABLE Students (
    sid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(50),
    city    VARCHAR(40),
    state   VARCHAR(40),
    age     REAL,
    gpa     REAL,
    CONSTRAINT GPARange CHECK (gpa >= 1 AND gpa <= 4)
);

CREATE TABLE Reads (
    aid     NUMBER(9),
    sid     NUMBER(9),
    rday    DATE NOT NULL,
    PRIMARY KEY (aid, sid),
    FOREIGN KEY (aid) REFERENCES Articles,
    FOREIGN KEY (sid) REFERENCES Students
);

INSERT INTO Students VALUES (1, 'Brendan', 'Milton', 'MA', 22, 3.3);
INSERT INTO Students VALUES (2, 'Dennis', 'Boston', 'MA', 20, 3.8);
INSERT INTO Students VALUES (3, 'Alberto', 'Quincy', 'MA', 20, 3.7);
INSERT INTO Students VALUES (4, 'Jon', 'Boston', 'MA', 21, 3.4);
INSERT INTO Students VALUES (5, 'Michael', 'Seattle', 'WA', 23, 3.1);

INSERT INTO Articles VALUES (1, 'Why PostgreSQL is the Best SQL', 'Elon Musk', 2023);
INSERT INTO Articles VALUES (2, '5 Reasons Why NoSQL Databases are Still Useful', 'Tom Brady', 2020);
INSERT INTO Articles VALUES (3, 'Why UMass Boston is a Commuter School', 'Marcelo Suarez-Orozco', 2018);
INSERT INTO Articles VALUES (4, 'Why I Slapped Chris Rock', 'Will Smith', 2022);

INSERT INTO Reads VALUES (1, 1, TO_DATE('04/02/2023', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (2, 1, TO_DATE('03/31/2023', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (2, 3, TO_DATE('12/21/2022', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (3, 3, TO_DATE('04/13/2019', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (1, 4, TO_DATE('04/01/2023', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (4, 5, TO_DATE('12/29/2022', 'MM/DD/YYYY'));
INSERT INTO Reads VALUES (4, 2, TO_DATE('12/30/2021', 'MM/DD/YYYY'));