-- Replicated from PracticeSessionSQL6.sql
CREATE TABLE Sailors (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2)
);

CREATE TABLE Boats (
    bid   NUMBER(9) PRIMARY KEY,
    name  VARCHAR(20),
    color VARCHAR(20)
);

CREATE TABLE Reserves (
    sid NUMBER(9),
    bid NUMBER(9),
    day DATE,
    PRIMARY KEY (sid, bid),
    FOREIGN KEY (sid) REFERENCES Sailors,
    FOREIGN KEY (bid) REFERENCES Boats
);

-- Replicated from PracticeSessionSQL5.sql
CREATE TABLE Movies (
    movie_id NUMBER(9) PRIMARY KEY,
    title    VARCHAR(40),
    year     INT,
    studio   VARCHAR(20)
);

CREATE TABLE Actors (
    actor_id NUMBER(9) PRIMARY KEY,
    name     VARCHAR(40),
    age      NUMBER(4, 2)
);

CREATE TABLE PlaysIn (
    actor_id  NUMBER(9),
    movie_id  NUMBER(9),
    character VARCHAR(40),
    PRIMARY KEY (actor_id, movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors,
    FOREIGN KEY (movie_id) REFERENCES Movies
);

-- Replicated from HW4/Q1.sql
CREATE TABLE Books (
    bid        NUMBER(9) PRIMARY KEY,
    bname      VARCHAR(40),
    author     VARCHAR(50),
    pubyear    INT,
    pubcompany VARCHAR(50)
);

CREATE TABLE Authors (
    aid    NUMBER(9) PRIMARY KEY,
    name   VARCHAR(40),
    rating INT,
    city   VARCHAR(50),
    state  VARCHAR(40)
);

CREATE TABLE Write (
    aid NUMBER(9),
    bid NUMBER(9),
    PRIMARY KEY (aid, bid),
    FOREIGN KEY (aid) REFERENCES Authors,
    FOREIGN KEY (bid) REFERENCES Books
);
