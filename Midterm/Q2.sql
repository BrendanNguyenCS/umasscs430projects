CREATE TABLE Musicians (
    mid    NUMBER(9) PRIMARY KEY,
    name   VARCHAR(50),
    rating REAL,
    city   VARCHAR(50),
    state  VARCHAR(50),
    dob    DATE
);

CREATE TABLE Instruments (
    iid      NUMBER(9) PRIMARY KEY,
    brand    VARCHAR(40),
    model    VARCHAR(40),
    myear    INT,
    category VARCHAR(50),
    dailyfee REAL
);

CREATE TABLE Rents (
    mid      NUMBER(9),
    iid      NUMBER(9),
    rentdate DATE,
    PRIMARY KEY (mid, iid, rentdate),
    FOREIGN KEY (mid) REFERENCES Musicians,
    FOREIGN KEY (iid) REFERENCES Instruments
);

-- Answer for a)
SELECT mid, name, city
    FROM Musicians
    WHERE state = 'MA';

-- Answer for b)
SELECT m.mid, m.name, i.iid, i.category
    FROM Musicians m
         JOIN Rents r ON m.mid = r.mid
         JOIN Instruments i ON r.iid = i.iid;

-- Answer for c)
SELECT m1.mid, m1.name
    FROM Musicians m1
         JOIN Rents r1 ON m1.mid = r1.mid
         JOIN Instruments i1 ON r1.iid = i1.iid
    WHERE i1.category = 'guitar'
INTERSECT
SELECT m2.mid, m2.name
    FROM Musicians m2
         JOIN Rents r2 ON m2.mid = r2.mid
         JOIN Instruments i2 ON r2.iid = i2.iid
    WHERE i2.category = 'piano';