-- Answer for a)
CREATE TABLE Articles (
    aid     NUMBER(9) PRIMARY KEY,
    title   VARCHAR(40),
    author  VARCHAR(50),
    pubyear INT
);

CREATE TABLE Students (
    sid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(50),
    city  VARCHAR(40),
    state VARCHAR(40),
    age   REAL,
    gpa   REAL,
    CONSTRAINT GPARange CHECK (gpa >= 1 AND gpa <= 4)
);

CREATE TABLE Reads (
    aid  NUMBER(9),
    sid  NUMBER(9),
    rday DATE NOT NULL,
    PRIMARY KEY (aid, sid),
    FOREIGN KEY (aid) REFERENCES Articles,
    FOREIGN KEY (sid) REFERENCES Students
);

-- Answer for b)
CREATE INDEX RDayIndex ON Reads (rday);
-- Here, we can easily access all of the records for the days each student read an article in a way that is better formatted.

-- Answer for c)
INSERT INTO Students
    VALUES (1, 'Brendan', 'Milton', 'MA', 22, 3.3);
INSERT INTO Students
    VALUES (2, 'Dennis', 'Boston', 'MA', 20, 3.8);
INSERT INTO Students
    VALUES (3, 'Alberto', 'Quincy', 'MA', 20, 3.7);

INSERT INTO Articles
    VALUES (1, 'Why PostgreSQL is the Best SQL', 'Elon Musk', 2023);
INSERT INTO Articles
    VALUES (2, '5 Reasons Why NoSQL Databases are Still Useful', 'Tom Brady', 2020);

-- Answer for d)
INSERT INTO Reads
    VALUES (1, 1, TO_DATE('04/02/2023', 'MM/DD/YYYY'));
INSERT INTO Reads
    VALUES (2, 1, TO_DATE('03/31/2023', 'MM/DD/YYYY'));
INSERT INTO Reads
    VALUES (2, 3, TO_DATE('12/21/2022', 'MM/DD/YYYY'));

-- Answer for e)
CREATE VIEW MAStudents AS
    SELECT *
        FROM Students
        WHERE state = 'MA';

-- Answer for f)
CREATE VIEW StudentReads
AS
    SELECT s.sid, s.name, s.city, a.aid, a.title
        FROM Students s
             JOIN Reads r ON s.sid = r.sid
             JOIN Articles a ON a.aid = r.aid;

-- Answer for g)
SELECT sid, COUNT(*)
    FROM StudentReads
    GROUP BY sid;

-- Answer for h)
DROP VIEW StudentReads;
DROP VIEW MAStudents;