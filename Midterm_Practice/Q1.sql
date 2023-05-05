CREATE TABLE Customers (
    cid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(40),
    city  VARCHAR(40),
    state VARCHAR(50),
    age   INT
);

CREATE TABLE Museums (
    mid    NUMBER(9) PRIMARY KEY,
    mname  VARCHAR(40),
    mcity  VARCHAR(40),
    mstate VARCHAR(50),
    mtype  VARCHAR(20)
);

CREATE TABLE Visit (
    cid      NUMBER(9),
    mid      NUMBER(9),
    visitday DATE,
    PRIMARY KEY (cid, mid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (mid) REFERENCES Museums
);

-- Answer for 1)
SELECT name, city
    FROM Customers
    WHERE state = 'MA';

-- Answer for 2)
SELECT *
    FROM Museums
    WHERE mtype = 'history'
       OR mtype = 'science';

-- Answer for 3)
SELECT c.cid, c.name, m.mname
    FROM Customers c
         JOIN Visit v ON c.cid = v.cid
         JOIN Museums m ON v.mid = m.mid;

-- Answer for 4)
SELECT c1.cid, c1.name
    FROM Customers c1,
         Visit v1,
         Museums m1
    WHERE c1.cid = v1.cid
      AND m1.mid = v1.mid
      AND m1.mstate = 'NY'
MINUS
SELECT c2.cid, c2.name
    FROM Customers c2,
         Visit v2,
         Museums m2
    WHERE c2.cid = v2.cid
      AND m2.mid = v2.mid
      AND m2.mstate != 'NY';

-- Answer for 5)
SELECT m1.mid, m1.mname
    FROM Customers c1,
         Visit v1,
         Museums m1
    WHERE c1.cid = v1.cid
      AND v1.mid = m1.mid
      AND c1.city = 'Boston'
      AND c1.state = 'MA'
INTERSECT
SELECT m2.mid, m2.mname
    FROM Customers c2,
         Visit v2,
         Museums m2
    WHERE c2.cid = v2.cid
      AND v2.mid = m2.mid
      AND c2.city = 'Burlington'
      AND c2.state = 'MA';