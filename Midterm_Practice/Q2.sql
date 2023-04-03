-- Answer for 1
SELECT COUNT(*) FROM Museums;

-- Answer for 2
SELECT COUNT(*) FROM Museums WHERE mcity = 'Boston' AND mstate = 'MA';

-- Answer for 3
SELECT AVG(c.age), c.state FROM Customers c GROUP BY c.state HAVING COUNT(*) >= 5;

-- Answer for 4
SELECT * FROM Customers WHERE state = 'MA' AND (age < 30 OR age > 40);

-- Answer for 5
CREATE TABLE Customers (
    cid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(40),
    city    VARCHAR(50),
    state   VARCHAR(50),
    age     INT
);

CREATE TABLE Museums (
    mid     NUMBER(9) PRIMARY KEY,
    mname   VARCHAR(40),
    mcity   VARCHAR(50),
    mstate  VARCHAR(50),
    mtype   VARCHAR(50)
);

CREATE TABLE Visit (
    cid         NUMBER(9),
    mid         NUMBER(9),
    visitday    DATE,
    PRIMARY KEY (cid, mid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (mid) REFERENCES Museums
);

-- Answer for 6
SELECT c.cid, c.name FROM Customers c, Visit v, Museums m
    WHERE c.cid = v.cid AND m.mid = v.mid
    AND mstate = 'MA' AND EXTRACT(YEAR FROM v.visitday) = 2018
    ORDER BY c.name;

-- Answer for 7
INSERT INTO Customers VALUES (1, 'Brendan', 'Boston', 'MA', 22);
INSERT INTO Museums VALUES (1, 'Museum of Science', 'Boston', 'MA', 'science');
INSERT INTO Visit VALUES (1, 1, TO_DATE('03/30/2023', 'MM/DD/YYYY'));

-- Answer for 8
(SElECT c.cid, c.name FROM Customers c, Visit v
    WHERE c.cid = v.cid
    AND EXTRACT(YEAR FROM v.visitday) = 2019)
MINUS
(SELECT c2.cid, c2.name FROM Customers c2, Visit v2
    WHERE c2.cid = v2.cid
    AND EXTRACT(YEAR FROM v2.visitday) = 2020);

-- Answer for 9
(SELECT c.cid, c.name FROM Customers c, Visit v
    WHERE c.cid = v.cid
    AND EXTRACT(YEAR FROM v.visitday) = 2020)
INTERSECT
(SELECT c2.cid, c2.name FROM Customers c2, Visit v2
    WHERE c2.cid = v2.cid
    AND EXTRACT(YEAR FROM v2.visitday) = 2018);

-- Answer for 11
SELECT c.cid, c.name, c.city, c.state, c.age
    FROM Customers c, Visit v, Museums m
    WHERE c.cid = v.cid AND m.mid = v.mid
    AND m.mtype = 'history';

-- Answer for 12
SELECT * FROM Museums m WHERE 100 <= (
    SELECT COUNT(v.cid) FROM Visit v WHERE v.mid = m.mid
);

-- Answer for 14
SELECT * FROM Museums WHERE mtype IS NOT NULL;

-- Answer for 15
SELECT c.cid, c.name FROM Customers c
    WHERE NOT EXISTS (
        SELECT m.mid FROM Museums m WHERE NOT EXISTS (
            SELECT * FROM Visit v WHERE v.cid = c.cid AND v.mid = m.mid
        )
    );

-- Answer for 16
SELECT c.cid, c.name FROM Customers c WHERE c.age = (
    SELECT MIN(c2.age) FROM Customers c2
);

-- Answer for 17
SELECT c.cid, c.name FROM Customers c WHERE NOT EXISTS (
    SELECT m.mid FROM Museums m WHERE m.mstate = 'MA' AND NOT EXISTS (
        SELECT * FROM Visit v WHERE v.mid = m.mid AND v.cid = c.cid
    )
);

-- Answer for 18
(SELECT c.cid, c.name FROM Customers c, Visit v, Museums m
    WHERE c.cid = v.cid AND m.mid = v.mid
    AND m.mtype = 'history')
INTERSECT
(SELECT c2.cid, c2.name FROM Customers c2, Visit v2, Museums m2
    WHERE c2.cid = v2.cid AND m2.mid = v2.mid
    AND m2.mtype = 'science');
