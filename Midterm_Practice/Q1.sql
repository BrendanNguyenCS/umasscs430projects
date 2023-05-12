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
    FROM Customers c1
         JOIN Visit v1 ON c1.cid = v1.cid
         JOIN Museums m1 ON m1.mid = v1.mid
    WHERE m1.mstate = 'NY'
MINUS
SELECT c2.cid, c2.name
    FROM Customers c2
         JOIN Visit v2 ON c2.cid = v2.cid
         JOIN Museums m2 ON m2.mid = v2.mid
    WHERE m2.mstate != 'NY';

-- Answer for 5)
SELECT m1.mid, m1.mname
    FROM Customers c1
         JOIN Visit v1 ON c1.cid = v1.cid
         JOIN Museums m1 ON v1.mid = m1.mid
    WHERE c1.city = 'Boston'
      AND c1.state = 'MA'
INTERSECT
SELECT m2.mid, m2.mname
    FROM Customers c2
         JOIN Visit v2 ON c2.cid = v2.cid
         JOIN Museums m2 ON v2.mid = m2.mid
    WHERE c2.city = 'Burlington'
      AND c2.state = 'MA';