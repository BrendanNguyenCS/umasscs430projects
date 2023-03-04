CREATE TABLE songs (
    songid      NUMBER(9) PRIMARY KEY,
    title       VARCHAR(50),
    release     DATE
);

CREATE TABLE singers (
    singerid    NUMBER(9) PRIMARY KEY,
    name        VARCHAR(20),
    age         REAL,
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

INSERT INTO singers VALUES (1, 'Bruno Mars', 37, 'Honolulu', 'HI');
INSERT INTO singers VALUES (2, 'Ed Sheeran', 32, 'Los Angeles', 'CA');
INSERT INTO singers VALUES (3, 'LMFAO', 17, 'Los Angeles', 'CA');
INSERT INTO singers VALUES (4, 'Halsey', 28, 'Edison', 'NJ');
INSERT INTO singers VALUES (5, 'Adam Levine', 43, 'Los Angeles', 'CA');
INSERT INTO singers VALUES (6, 'Cardi B', 30, 'New York', 'NY');
INSERT INTO singers VALUES (7, 'Rihanna', 35, 'Saint Michael', 'Barbados');
INSERT INTO singers VALUES (8, 'Lil Nas X', 23, 'Atlanta', 'GA');
INSERT INTO singers VALUES (9, 'Kimbra', 32, 'Hamilton', 'New Zealand');

INSERT INTO songs VALUES (1, 'Uptown Funk', TO_DATE('01/17/2015', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (2, 'Party Rock Anthem', TO_DATE('07/16/2011', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (3, 'Shape Of You', TO_DATE('01/28/2017', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (4, 'Closer', TO_DATE('09/03/2016', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (5, 'Girls Like You', TO_DATE('09/29/2018', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (6, 'We Found Love', TO_DATE('11/12/2011', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (7, 'Old Town Road', TO_DATE('04/13/2019', 'MM/DD/YYYY'));
INSERT INTO songs VALUES (8, 'Somebody That I Used to Know', TO_DATE('04/28/2017', 'MM/DD/YYYY'));

INSERT INTO singsin VALUES (1, 1);
INSERT INTO singsin VALUES (3, 2);
INSERT INTO singsin VALUES (2, 3);
INSERT INTO singsin VALUES (4, 4);
INSERT INTO singsin VALUES (5, 5);
INSERT INTO singsin VALUES (6, 5);
INSERT INTO singsin VALUES (7, 6);
INSERT INTO singsin VALUES (8, 7);
INSERT INTO singsin VALUES (9, 8);