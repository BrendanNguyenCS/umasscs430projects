--Answer for a
CREATE TABLE songs (
    songid NUMBER(9) PRIMARY KEY,
    title VARCHAR(50),
    release DATE
);

CREATE TABLE singers (
    singerid NUMBER(9) PRIMARY KEY,
    name VARCHAR(50),
    age REAL,
    city VARCHAR(100),
    state VARCHAR(100)
);

CREATE TABLE singsin (
    singerid NUMBER(9),
    songid NUMBER(9),
    FOREIGN KEY(singerid) REFERENCES singers,
    FOREIGN KEY(songid) REFERENCES songs
);

--Answer for b
SELECT name FROM singers WHERE city = 'Boston' ORDER BY name;

--Answer for c


--Answer for d
SELECT COUNT(*) FROM singers WHERE city = 'Los Angeles' AND state = 'CA';

--Answer for e


--Answer for f


--Answer for g


--Answer for h


--Answer for i


--Answer for j
SELECT COUNT(*) from songs where EXTRACT(YEAR FROM release) = 2020;