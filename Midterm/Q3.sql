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
SELECT *
    FROM Musicians
    WHERE name LIKE '%an%';

-- Answer for b)
SELECT rating, COUNT(*)
    FROM Musicians
    GROUP BY rating
    ORDER BY rating DESC;

-- Answer for c)
CREATE VIEW YoungestMusicians AS
    SELECT m1.mid, m1.name, m1.city, m1.state
        FROM Musicians m1
        WHERE m1.dob = (
            SELECT MAX(m2.dob)
                FROM Musicians m2
        );

-- Answer for d)
SELECT iid, brand, model
    FROM Instruments
    WHERE myear = 2020
      AND (brand = 'yamaha' OR brand = 'roland');

-- Answer for e)
SELECT category, AVG(dailyfee)
    FROM Instruments
    GROUP BY category
    HAVING COUNT(*) >= 3;

-- Answer for f)
SELECT m.mid, m.name
    FROM Musicians m
    WHERE NOT EXISTS (
        SELECT i.iid
            FROM Instruments i
            WHERE i.category = 'piano'
        MINUS
        SELECT r.iid
            FROM Rents r
            WHERE r.mid = m.mid
    );

-- Answer for g)
SELECT m.mid, m.name, SUM(i.dailyfee)
    FROM Musicians m,
         Rents r,
         Instruments i
    WHERE m.mid = r.mid
      AND r.iid = i.iid
    GROUP BY m.mid, m.name;

-- Answer for h)
ALTER TABLE Musicians ADD (
    phone_number VARCHAR(20)
);
