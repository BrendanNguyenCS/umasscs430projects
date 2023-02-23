-- Answer for a
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

-- Answer for b
SELECT name FROM singers WHERE city = 'Boston' ORDER BY name;

-- Answer for c
SELECT s1.name, s1.age, s3.title, s3.release
FROM singers s1, singsin s2, songs s3
    -- Joining conditions
WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- sorted by name in descending order
ORDER BY s1.name DESC;

-- Answer for d
SELECT COUNT(*) FROM singers WHERE city = 'Los Angeles' AND state = 'CA';

-- Answer for e
SELECT * FROM singers WHERE name LIKE '%a' ORDER BY state DESC;

-- Answer for f
SELECT s1.name, s1.state
FROM singers s1, singsin s2, songs s3
    -- Joining conditions
WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Song title contains 'happy' (case insensitive)
    AND lower(s3.title) LIKE '%happy%';

-- Answer for g
SELECT s1.name, s1.city, s1.state
FROM singers s1, singsin s2, songs s3
    -- Joining conditions
WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Date lies after given lower boundary date
    AND s3.release > TO_DATE('08/21/2022', 'MM/DD/YYYY');

-- Answer for h


-- Answer for i
SELECT COUNT(DISTINCT s1.singerid)
FROM singers s1, singsin s2, songs s3
    -- Joining conditions
WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Date lies between given boundary dates
    AND s3.release >= TO_DATE('01/01/2022', 'MM/DD/YYYY')
    AND s3.release <= TO_DATE('05/31/2022', 'MM/DD/YYYY');

--Answer for j
SELECT COUNT(*) FROM songs WHERE EXTRACT(YEAR FROM release) = 2020;