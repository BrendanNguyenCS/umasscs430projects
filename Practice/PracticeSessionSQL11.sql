/**
  Solutions for Exercise 4.3 (pg. 127-128) from Database Management Systems Third Edition by Ramakrishnan and Gehrke
 */

CREATE TABLE Suppliers (
    sid     INT PRIMARY KEY,
    sname   VARCHAR(40),
    address VARCHAR(50)
);

CREATE TABLE Parts (
    pid   INT PRIMARY KEY,
    pname VARCHAR(40),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid  INT,
    pid  INT,
    cost REAL,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Suppliers,
    FOREIGN KEY (pid) REFERENCES Parts
);

/**
  1. Find the names of suppliers who supply some red part.
 */
SELECT s.sname
    FROM Suppliers s,
         Parts p,
         Catalog c
    WHERE s.sid = c.sid
      AND c.pid = p.pid
      AND p.color = 'red';

/**
  2. Find the sids of suppliers who supply some red or green part.
 */
SELECT c.sid
    FROM Parts p,
         Catalog c
    WHERE c.pid = p.pid
      AND (p.color = 'red' OR p.color = 'green');

/**
  3. Find the sids of suppliers who supply some red part or are at 221 Packer Street.
 */
SELECT DISTINCT s.sid
    FROM Suppliers s,
         Parts p,
         Catalog c
    WHERE s.sid = c.sid
      AND p.pid = c.pid
      AND (p.color = 'red' OR s.address = '221 Packer Street');

/**
  4. Find the sids of suppliers who supply some red part and some green part.
 */
SELECT c.sid
    FROM Catalog c,
         Parts p
    WHERE c.pid = p.pid
      AND p.color = 'red'
INTERSECT
SELECT c.sid
    FROM Catalog c,
         Parts p
    WHERE c.pid = p.pid
      AND p.color = 'green';

/**
  5. Find the sids of suppliers who supply every part.
 */
SELECT s.sid
    FROM Suppliers s
    WHERE NOT EXISTS (
        SELECT p.pid
            FROM Parts p
        MINUS
        SELECT c.pid
            FROM Catalog c
            WHERE c.sid = s.sid
    );

/**
  6. Find the sids of suppliers who supply every red part.
 */
SELECT s.sid
    FROM Suppliers s
    WHERE NOT EXISTS (
        SELECT p.pid
            FROM Parts p
            WHERE p.color = 'red'
        MINUS
        SELECT c.pid
            FROM Catalog c
            WHERE c.sid = s.sid
    );

/**
  7. Find the sids of suppliers who supply every red or green part.
 */
SELECT s.sid
    FROM Suppliers s
    WHERE NOT EXISTS (
        SELECT p.pid
            FROM Parts p
            WHERE (p.color = 'red' OR p.color = 'green')
        MINUS
        SELECT c.pid
            FROM Catalog c
            WHERE c.sid = s.sid
    );

/**
  8. Find the sids of suppliers who supply every red part or supply every green part.
 */
SELECT s.sid
    FROM Suppliers s
    WHERE NOT EXISTS (
        SELECT p.pid
            FROM Parts p
            WHERE p.color = 'red'
        MINUS
        SELECT c.pid
            FROM Catalog c
            WHERE c.sid = s.sid
    )
UNION
SELECT s.sid
    FROM Suppliers s
    WHERE NOT EXISTS (
        SELECT p.pid
            FROM Parts p
            WHERE p.color = 'green'
        MINUS
        SELECT c.pid
            FROM Catalog c
            WHERE c.sid = s.sid
    );

/**
  9. Find the pairs of sids such that the supplier with the first sid charges more for some part than the supplier with the second sid.
 */
SELECT c1.sid, c2.sid
    FROM Catalog c1,
         Catalog c2
    WHERE c1.pid = c2.pid
      AND c1.sid != c2.sid
      AND c1.cost > c2.cost;

/**
  10. Find the pids of parts supplied by at least two different suppliers.
 */
SELECT c.pid
    FROM Catalog c
    GROUP BY c.pid
    HAVING COUNT(*) >= 2;

/**
  11. Find the pids of the most expensive parts supplied by suppliers named Yosemite Sham.
 */
SELECT p.pid
    FROM Parts p,
         Catalog c,
         Suppliers s
    WHERE p.pid = c.pid
      AND c.sid = s.sid
      AND s.sname = 'Yosemite Sham'
      AND c.cost = (
        SELECT MAX(c2.cost)
            FROM Catalog c2
            WHERE c2.sid = c.sid
    );