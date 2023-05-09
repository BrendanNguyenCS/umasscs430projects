CREATE TABLE Movies (
    mid         NUMBER(9) PRIMARY KEY,
    title       VARCHAR(50),
    director    VARCHAR(40),
    studio      VARCHAR(40),
    releaseyear INT
);

CREATE TABLE Customers (
    cid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(40),
    city  VARCHAR(40),
    state VARCHAR(40),
    age   REAL,
    CONSTRAINT MatureOnly CHECK (age >= 18)
);

CREATE TABLE Watch (
    mid       NUMBER(9),
    cid       NUMBER(9),
    watchedon DATE,
    PRIMARY KEY (mid, cid),
    FOREIGN KEY (mid) REFERENCES Movies,
    FOREIGN KEY (cid) REFERENCES Customers
);

INSERT INTO Movies
    VALUES (1, 'Glass Onion: A Knives Out Mystery', 'Rian Johnson', 'Netflix', 2022);
INSERT INTO Movies
    VALUES (2, 'Fast X', 'Louis Leterrier', 'Universal Studios', 2023);
INSERT INTO Movies
    VALUES (3, 'Cars', 'John Lasseter', 'Pixar Animation', 2006);
INSERT INTO Movies
    VALUES (4, 'Top Gun: Maverick', 'Joseph Kosinski', 'Paramount Pictures', 2022);
INSERT INTO Movies
    VALUES (5, 'Captain America: Civil War', 'Anthony Russo', 'Walt Disney Studios', 2016);
INSERT INTO Movies
    VALUES (6, 'Avatar', 'James Cameron', '20th Century Studios', 2009);
INSERT INTO Movies
    VALUES (7, 'Avatar: The Way of Water', 'James Cameron', '20th Century Studios', 2022);
INSERT INTO Movies
    VALUES (8, 'Transformers: Dark of the Moon', 'Michael Bay', 'Paramount Pictures', 2011);
INSERT INTO Movies
    VALUES (9, 'The Fast and the Furious: Tokyo Drift', 'Justin Lin', 'Universal Pictures', 2006);
INSERT INTO Movies
    VALUES (10, '8 Mile', 'Curtis Hanson', 'Universal Pictures', 2002);

INSERT INTO Customers
    VALUES (1, 'Brendan', 'Boston', 'MA', 22);
INSERT INTO Customers
    VALUES (2, 'Mike', 'Orlando', 'FL', 27);
INSERT INTO Customers
    VALUES (3, 'Justin', 'Seattle', 'WA', 20);
INSERT INTO Customers
    VALUES (4, 'Tom', 'Worcester', 'MA', 21);
INSERT INTO Customers
    VALUES (5, 'Marshall', 'Detroit', 'MI', 50);
INSERT INTO Customers
    VALUES (6, 'Tom', 'San Mateo', 'CA', 45);
INSERT INTO Customers
    VALUES (7, 'Jonathan', 'North Reading', 'MA', 29);
INSERT INTO Customers
    VALUES (8, 'Andy', 'Everett', 'MA', 26);
INSERT INTO Customers
    VALUES (9, 'Mark', 'Dallas', 'TX', 64);

INSERT INTO Watch
    VALUES (1, 1, TO_DATE('04/19/2023', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (10, 5, TO_DATE('10/17/2008', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (6, 7, TO_DATE('06/31/2022', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (7, 7, TO_DATE('12/31/2022', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (9, 3, TO_DATE('05/19/2023', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (4, 2, TO_DATE('11/11/2022', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (5, 4, TO_DATE('02/21/2022', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (3, 8, TO_DATE('10/01/2010', 'MM/DD/YYYY'));
INSERT INTO Watch
    VALUES (9, 6, TO_DATE('05/22/2022', 'MM/DD/YYYY'));

SELECT DISTINCT m.mid, m.title
    FROM Movies m
         JOIN Watch w ON m.mid = w.mid
    WHERE w.watchedon >= TO_DATE('01/01/2022', 'MM/DD/YYYY')
      AND w.watchedon <= TO_DATE('07/31/2022', 'MM/DD/YYYY');

SELECT c.cid, c.name, m.mid, m.title, m.director, w.watchedon
    FROM Customers c
         JOIN Watch w ON c.cid = w.cid
         JOIN Movies m ON w.mid = m.mid
    ORDER BY 6 DESC;