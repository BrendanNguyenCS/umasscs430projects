CREATE TABLE Articles (
    aid             NUMBER(9) PRIMARY KEY,
    aname           VARCHAR(20),
    first_author    VARCHAR(50),
    pubyear         NUMBER(4),
    pubcompany      VARCHAR(50)
);

CREATE TABLE Students (
    sid     NUMBER(9) PRIMARY KEY,
    sname   VARCHAR(20),
    age     REAL,
    state   VARCHAR(20)
);

CREATE TABLE Reads (
    sid     NUMBER(9) PRIMARY KEY,
    aid     NUMBER(9) PRIMARY KEY,
    PRIMARY KEY(sid, aid),
    FOREIGN KEY(sid) REFERENCES Students,
    FOREIGN KEY(aid) REFERENCES Articles
);

INSERT INTO Students VALUES (1, 'Brendan Nguyen', 22, 'MA');
INSERT INTO Students VALUES (2, 'Wilhen Alberto Hui Mei', 21, 'WA');
INSERT INTO Students VALUES (3, 'Joseph Nguyen', 20, 'MA');
INSERT INTO Students VALUES (4, 'Kelsey Vu', 23, 'CT');
INSERT INTO Students VALUES (5, 'Trevor Murphy', 19, 'FL');