CREATE TABLE Books (
    bid         NUMBER(9) PRIMARY KEY,
    bname       VARCHAR(40),
    author      VARCHAR(50),
    pubyear     INT,
    pubcompany  VARCHAR(50)
);

CREATE TABLE Authors (
    aid     NUMBER(9) PRIMARY KEY,
    name    VARCHAR(40),
    rating  INT,
    city    VARCHAR(50),
    state   VARCHAR(40)
);

CREATE TABLE Write (
    aid     NUMBER(9),
    bid     NUMBER(9),
    PRIMARY KEY (aid, bid),
    FOREIGN KEY (aid) REFERENCES Authors,
    FOREIGN KEY (bid) REFERENCES Books
);

INSERT INTO Books VALUES (1, 'Operating Systems: Three Easy Pieces', 'Remzi Arpaci-Dusseau', 2018, 'University of Wisconsin-Madison');
INSERT INTO Books VALUES (2, 'Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 1999, 'Bloomsbury Publishing');
INSERT INTO Books VALUES (3, 'Harry Potter and the Order of the Phoenix', 'J.K. Rowling', 2003, 'Bloomsbury Publishing');
INSERT INTO Books VALUES (4, 'The Lightning Thief', 'Rick Riordan', 2005, 'Disney Publishing Worldwide');
INSERT INTO Books VALUES (5, 'The Hunger Games: Mockingjay', 'Suzanne Collins', 2010, 'Scholastic');
INSERT INTO Books VALUES (6, 'Rainbow Six', 'Tom Clancy', 1998, 'G.P. Putnam''s Sons');
INSERT INTO Books VALUES (7, 'Without Remorse', 'Tom Clancy', 1993, 'G.P. Putnam''s Sons');
INSERT INTO Books VALUES (8, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 1979, 'Pan Books');
INSERT INTO Books VALUES (9, 'Alex Rider: Nightshade', 'Anthony Horowitz', 2020, 'Philomel Books');

INSERT INTO Authors VALUES (1, 'Remzi Arpaci-Dusseau', 4, 'Madison', 'Wisconsin');
INSERT INTO Authors VALUES (2, 'J.K. Rowling', 9, 'Yate', 'England');
INSERT INTO Authors VALUES (3, 'Rick Riordan', 8, 'San Antonio', 'TX');
INSERT INTO Authors VALUES (4, 'Suzanne Collins', 7, 'Hartford', 'CT');
INSERT INTO Authors VALUES (5, 'Tom Clancy', 10, 'Baltimore', 'MD');
INSERT INTO Authors VALUES (6, 'Douglas Adams', 8, 'Cambridge', 'England');
INSERT INTO Authors VALUES (7, 'Anthony Horowitz', 7, 'Stanmore', 'England');

INSERT INTO Write VALUES (1, 1);
INSERT INTO Write VALUES (2, 2);
INSERT INTO Write VALUES (2, 3);
INSERT INTO Write VALUES (3, 4);
INSERT INTO Write VALUES (4, 5);
INSERT INTO Write VALUES (5, 6);
INSERT INTO Write VALUES (5, 7);
INSERT INTO Write VALUES (6, 8);
INSERT INTO Write VALUES (7, 9);