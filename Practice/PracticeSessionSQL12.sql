/**
  Solutions for Exercise 4.5 (pg. 128-129) from Database Management Systems Third Edition by Ramakrishnan and Gehrke
 */

CREATE TABLE Flights (
    flno     INT PRIMARY KEY,
    "from"   VARCHAR(40),
    "to"     VARCHAR(40),
    distance INT,
    departs  TIMESTAMP,
    arrives  TIMESTAMP
);

CREATE TABLE Aircraft (
    aid           INT PRIMARY KEY,
    aname         VARCHAR(40),
    cruisingrange INT
);

CREATE TABLE Employees (
    eid    INT PRIMARY KEY,
    ename  VARCHAR(50),
    salary INT
);

CREATE TABLE Certified (
    eid INT,
    aid INT,
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES Employees,
    FOREIGN KEY (aid) REFERENCES Aircraft
);

/**
  1. Find the eids of pilots certified for some Boeing aircraft.
 */
SELECT c.eid
    FROM Aircraft a,
         Certified c
    WHERE a.aid = c.aid
      AND a.aname = 'Boeing';

/**
  2. Find the names of pilots certified for some Boeing aircraft.
 */
SELECT e.ename
    FROM Employees e,
         Certified c,
         Aircraft a
    WHERE e.eid = c.eid
      AND c.aid = a.aid
      AND a.aname = 'Boeing';

/**
  3. Find the aids of all aircraft that can be used on non-stop flights from Bonn to Madrid.
 */
SELECT a.aid
    FROM Aircraft a,
         Flights f
    WHERE f."from" = 'Bonn'
      AND f."to" = 'Madrid'
      AND a.cruisingrange > f.distance;

/**
  4. Identify the flights that can be piloted by every pilot whose salary is more than $100,000.
 */
SELECT e.ename
    FROM Employees e,
         Aircraft a,
         Certified c,
         Flights f
    WHERE a.aid = c.aid
      AND e.eid = c.eid
      AND f.distance < a.cruisingrange
      AND e.salary > 100000;

/**
  5. Find the names of pilots who can operate planes with a range greater than 3000 miles but are not certified on any Boeing aircraft.
 */
SELECT e.ename
    FROM Certified c,
         Employees e,
         Aircraft a
    WHERE a.aid = c.aid
      AND e.eid = c.eid
      AND a.cruisingrange > 3000
      AND e.eid NOT IN (
        SELECT c2.eid
            FROM Certified c2,
                 Aircraft a2
            WHERE c2.aid = a2.aid
              AND a2.aname = 'Boeing'
    );

/**
  6. Find the eids of employees who make the highest salary.
 */
SELECT e.eid
    FROM Employees e
    WHERE e.salary = (
        SELECT MAX(e2.salary)
            FROM Employees e2
    );

/**
  7. Find the eids of employees who make the second highest salary.
 */
SELECT e.eid
    FROM Employees e
    WHERE e.salary = (
        SELECT MAX(e2.salary)
            FROM Employees e2
            WHERE e2.salary != (
                SELECT MAX(e3.salary)
                    FROM Employees e3
            )
    );

/**
  8. Find the eids of employees who are certified for the largest number of aircraft.
 */
SELECT e.eid
    FROM Employees e,
         Certified c
    WHERE e.eid = c.eid
    GROUP BY e.eid
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(c2.eid))
            FROM Certified c2
    );

/**
  9. Find the eids of employees who are certified for exactly three aircraft.
 */
SELECT c.eid
    FROM Certified c
    GROUP BY c.eid
    HAVING COUNT(*) = 3;

/**
  10. Find the total amount paid to employees as salaries.
 */
SELECT SUM(e.salary)
    FROM Employees e;