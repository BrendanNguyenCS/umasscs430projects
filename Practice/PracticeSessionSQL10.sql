/**
  Solutions for Exercise 5.1 (pg. 174-175) from Database Management Systems Third Edition by Ramakrishnan and Gehrke
 */

CREATE TABLE Student (
    snum    INT PRIMARY KEY,
    sname   VARCHAR(40),
    major   VARCHAR(40),
    "level" VARCHAR(40),
    age     INT
);

CREATE TABLE Class (
    name     VARCHAR(40) PRIMARY KEY,
    meets_at TIMESTAMP,
    room     VARCHAR(20),
    fid      INT,
    FOREIGN KEY (fid) REFERENCES Faculty
);

CREATE TABLE Enrolled (
    snum  INT,
    cname VARCHAR(40),
    PRIMARY KEY (snum, cname),
    FOREIGN KEY (snum) REFERENCES Student,
    FOREIGN KEY (cname) REFERENCES Class (name)
);

CREATE TABLE Faculty (
    fid    INT PRIMARY KEY,
    fname  VARCHAR(50),
    deptid INTEGER
);

/**
  1. Find the names of all Juniors (level = JR) who are enrolled in a class taught by I.Teach.
 */
SELECT DISTINCT s.sname
    FROM Student s,
         Class c,
         Enrolled e,
         Faculty f
    WHERE s.snum = e.snum
      AND e.cname = c.name
      AND c.fid = f.fid
      AND f.fname = 'I.Teach'
      AND s."level" = 'JR';

/**
  2. Find the age of the oldest student who is either a History major or enrolled in a course taught by I.Teach.
 */
SELECT MAX(s.age)
    FROM Student s
    WHERE s.major = 'History'
       OR s.snum IN (
        SELECT e.snum
            FROM Class c,
                 Enrolled e,
                 Faculty f
            WHERE e.cname = c.name
              AND c.fid = f.fid
              AND f.fname = 'I.Teach'
    );

/**
  3. Find the names of all classes that either meet in room R128 or have five or more students enrolled.
 */
SELECT c.name
    FROM CLass c
    WHERE c.room = 'R128'
       OR c.name IN (
        SELECT e.cname
            FROM Enrolled e
            GROUP BY e.cname
            HAVING COUNT(*) >= 5
    );

/**
  4. Find the names of all students who are enrolled in two classes that meet at the same time.
 */
SELECT DISTINCT s.sname
    FROM Student s
    WHERE s.snum IN (
        SELECT e1.snum
            FROM Enrolled e1,
                 Enrolled e2,
                 Class c1,
                 Class c2
            WHERE e1.snum = e2.snum
              AND e1.cname != e2.cname
              AND e1.cname = c1.name
              AND e2.cname = c2.name
              AND c1.meets_at = c2.meets_at
    );

/**
  5. Find the names of faculty members who teach in every room in which some class is taught.
 */
SELECT DISTINCT f.fname
    FROM Faculty f
    WHERE NOT EXISTS (
        SELECT *
            FROM Class c
        MINUS
        SELECT c1.room
            FROM Class c1
            WHERE c1.fid = f.fid
    );

/**
  6. Find the names of faculty member for whom the combined enrollment of the courses they teach is less than five.
 */
SELECT DISTINCT f.fname
    FROM Faculty f
    WHERE 5 > (
        SELECT COUNT(e.snum)
            FROM Class c,
                 Enrolled e
            WHERE c.name = e.cname
              AND c.fid = f.fid
    );

/**
  7. For each level, print the level and the average age of students for that level.
 */
SELECT "level", AVG(s.age)
    FROM Student s
    GROUP BY "level";

/**
  8. For all levels except JR, print the level and the average age of students for that level.
 */
SELECT "level", AVG(s.age)
    FROM Student s
    WHERE "level" != 'JR'
    GROUP BY "level";

/**
  9. For each faculty member that has taught classes only in room R128, print the faculty member's name and the total number he/she has taught.
 */
SELECT f.fname, COUNT(*)
    FROM Faculty f,
         Class c
    WHERE f.fid = c.fid
      AND c.room = 'R128'
    GROUP BY f.fname
MINUS
SELECT f.fname, COUNT(*)
    FROM Faculty f,
         Class c
    WHERE f.fid = c.fid
      AND room != 'R128'
    GROUP BY f.fname;

/**
  10. Find the names of students enrolled in the maximum number of classes.
 */
SELECT DISTINCT s.sname
    FROM Student s
    WHERE s.snum IN (
        SELECT e.snum
            FROM Enrolled e
            GROUP BY e.snum
            HAVING COUNT(*) >= ALL (
                SELECT COUNT(*)
                    FROM Enrolled e2
                    GROUP BY e2.snum
            )
    );

/**
  11. Find the names of students not enrolled in any class.
 */
SELECT DISTINCT s.sname
    FROM Student s
    WHERE s.snum NOT IN (
        SELECT e.snum
            FROM Enrolled e
    );

/**
  12. For each age value that appears in Students, find the level value that appears the most often. For example, if there are more FR level students aged 18 than SR, JR, or SO students aged 18, you would print the pair (18, FR).
 */
SELECT S.age, S."level"
    FROM Student S
    GROUP BY S.age, S."level"
    HAVING S."level" IN (
        SELECT S1."level"
            FROM Student S1
            WHERE S1.age = S.age
            GROUP BY S1."level", S1.age
            HAVING COUNT(*) >= ALL (
                SELECT COUNT(*) FROM Student S2 WHERE s1.age = S2.age GROUP BY S2."level", S2.age
            )
    );