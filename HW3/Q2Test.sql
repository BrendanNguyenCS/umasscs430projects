CREATE TABLE Articles (
    aid          NUMBER(9) PRIMARY KEY,
    aname        VARCHAR(100),
    first_author VARCHAR(50),
    pubyear      NUMBER(4),
    pubcompany   VARCHAR(50)
);

CREATE TABLE Students (
    sid   NUMBER(9) PRIMARY KEY,
    sname VARCHAR(20),
    age   REAL,
    state VARCHAR(20)
);

CREATE TABLE Reads (
    sid NUMBER(9) PRIMARY KEY,
    aid NUMBER(9) PRIMARY KEY,
    PRIMARY KEY (sid, aid),
    FOREIGN KEY (sid) REFERENCES Students,
    FOREIGN KEY (aid) REFERENCES Articles
);

INSERT INTO Students
    VALUES (1, 'Brendan Nguyen', 22, 'MA');
INSERT INTO Students
    VALUES (2, 'Wilhen Alberto Hui Mei', 21, 'WA');
INSERT INTO Students
    VALUES (3, 'Joseph Nguyen', 20, 'MA');
INSERT INTO Students
    VALUES (5, 'Trevor Murphy', 19, 'FL');

INSERT INTO Articles
    VALUES (1, 'Ferrari didn''t expect to fight Toyota for WEC Sebring win', 'Gary Watkins', 2023, 'Autosport');
INSERT INTO Articles
    VALUES (2, '2023 Hypercar & GTP Line-Up Almost Complete', 'Graham Goodwin', 2022, 'DailySportsCar');
INSERT INTO Articles
    VALUES (3, 'The Formula 1 grid for 2022', 'Catalina Arevalo', 2021, 'Marca');
INSERT INTO Articles
    VALUES (4, 'Three Features Android Auto Should Get in 2021', 'Bogdan Popa', 2020, 'AutoEvolution');

INSERT INTO Reads
    VALUES (1, 1);
INSERT INTO Reads
    VALUES (2, 2);
INSERT INTO Reads
    VALUES (3, 3);
INSERT INTO Reads
    VALUES (5, 4);