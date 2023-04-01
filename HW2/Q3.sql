-- Answer for a)
CREATE TABLE songs (
    songid      NUMBER(9) PRIMARY KEY,
    title       VARCHAR(50),
    release     DATE
);

CREATE TABLE singers (
    singerid    NUMBER(9) PRIMARY KEY,
    name        VARCHAR(20),
    age         INT,
    city        VARCHAR(50),
    state       VARCHAR(50)
);

CREATE TABLE singsin (
    singerid    NUMBER(9),
    songid      NUMBER(9),
    PRIMARY KEY(singerid, songid),
    FOREIGN KEY(singerid) REFERENCES singers,
    FOREIGN KEY(songid) REFERENCES songs
);

-- Answer for b)
SELECT name FROM singers WHERE city = 'Boston' ORDER BY name;

-- Answer for c)
SELECT name, age, title, release
    FROM singers s1, singsin s2, songs s3
    -- Joining conditions
    WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- sorted by name in descending order
    ORDER BY name DESC;

-- Answer for d)
SELECT COUNT(*) FROM singers WHERE city = 'Los Angeles' AND state = 'CA';

-- Answer for e)
SELECT * FROM singers WHERE name LIKE '%a' ORDER BY state DESC;

-- Answer for f)
SELECT name, state
    FROM singers s1, singsin s2, songs s3
    -- Joining conditions
    WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Song title contains 'happy' (case insensitive)
    AND LOWER(s3.title) LIKE '%happy%';

-- Answer for g)
SELECT name, city, state
    FROM singers s1, singsin s2, songs s3
    -- Joining conditions
    WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Date lies after given lower boundary date
    AND release > TO_DATE('08/21/2022', 'MM/DD/YYYY');

-- Answer for h)
SELECT title FROM songs
    WHERE release = (
        SELECT MIN(release) FROM songs
    );

-- Answer for i)
SELECT COUNT(DISTINCT s1.singerid)
    FROM singers s1, singsin s2, songs s3
    -- Joining conditions
    WHERE s1.singerid = s2.singerid AND s2.songid = s3.songid
    -- Date lies between given boundary dates
    AND release >= TO_DATE('01/01/2022', 'MM/DD/YYYY')
    AND release <= TO_DATE('05/31/2022', 'MM/DD/YYYY');

--Answer for j)
SELECT COUNT(*) FROM songs WHERE EXTRACT(YEAR FROM release) = 2020;