-- SQL Practice 5
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT FOUR LINES TO DROP THE TABLES FIRST)

 --DROP TABLE PlaysIn;
 --DROP TABLE Movies;
 --DROP TABLE Actors;
 --DROP TABLE Movies2;

CREATE TABLE Movies(
        movie_id 	NUMBER(9) PRIMARY KEY,
        title	VARCHAR(40),
        year  INT,
        studio   VARCHAR(20)
);

CREATE TABLE Actors(
        actor_id 	NUMBER(9) PRIMARY KEY,
        name	VARCHAR(40),
        age  NUMBER(4,2)
);

CREATE TABLE PlaysIn(
        actor_id 	NUMBER(9),
        movie_id NUMBER(8),
        character VARCHAR(40),
        PRIMARY KEY(actor_id, movie_id),
        FOREIGN KEY (actor_id) REFERENCES Actors,
	    FOREIGN KEY (movie_id) REFERENCES Movies
);


-- insert records into Actors table
INSERT INTO Actors(actor_id,name,age) VALUES (10,'Joe',35.0);
INSERT INTO Actors(actor_id,name,age) VALUES (20,'Mary',20.0);
INSERT INTO Actors(actor_id,name,age) VALUES (30,'Anne',55.0);
INSERT INTO Actors(actor_id,name,age) VALUES (40,'Jerry',45.0);

-- insert records into movies table
INSERT INTO Movies(movie_id,title,year, studio) VALUES(100,'Movie A', 2010,'Universal');
INSERT INTO Movies(movie_id,title,year, studio) VALUES(200,'Movie B',2005,'Universal');
INSERT INTO Movies(movie_id,title,year, studio) VALUES(300,'Movie C',2015,'WB');

-- insert records into PlaysIn tab
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,100,'cab driver');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,200,'waitress');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,300,'Billy');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(20,100,'musician');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(20,300,'waitress');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,100,'Laura');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,200,'teacher');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,300,'librarian');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(40,100,'teacher');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(40,200,'football player');

-- check how many records you have in each table
SELECT COUNT(*) FROM Actors;
SELECT COUNT(*) FROM Movies;
SELECT COUNT(*) FROM Playsin;

-- look at data from each table
SELECT * FROM actors;
SELECT * FROM movies;
SELECT * FROM playsin;


--Find the id and name of actors who played in all movies
-- sol 1
SELECT a.actor_id, a.name
FROM Actors a
WHERE NOT EXISTS(
          (SELECT m.movie_id FROM Movies m)
           MINUS
          (SELECT p.movie_id FROM PlaysIn p
           WHERE p.actor_id=a.actor_id)
);

--Find the id and name of actors who played in all movies
-- sol 2
SELECT a.actor_id, a.name
FROM Actors a
WHERE NOT EXISTS (
          SELECT m.movie_id FROM Movies m
           WHERE NOT EXISTS (
                 SELECT * FROM PlaysIn p
                 WHERE p.actor_id=a.actor_id AND p.movie_id=m.movie_id
              )
);

-- Find the id and name of actors who played in all movies. Order the result by actors'name in ASC order.
SELECT a.actor_id, a.name
FROM Actors a
WHERE NOT EXISTS (
          SELECT m.movie_id FROM Movies m
           WHERE NOT EXISTS (
                 SELECT * FROM PlaysIn p
                 WHERE p.actor_id=a.actor_id AND p.movie_id=m.movie_id
              )
)
ORDER BY a.name ASC;

--Find the id and name of actors who played in all movies produced by ‘Universal' studio.
SELECT a.actor_id, a.name
FROM Actors a
WHERE NOT EXISTS(
          (SELECT m.movie_id FROM Movies m
           WHERE m.studio='Universal')
           MINUS
          (SELECT p.movie_id FROM PlaysIn p
           WHERE p.actor_id=a.actor_id)
);


---Find the id and name of actors who played in all movies produced by ‘Universal' studio.
-- sol 2
SELECT a.actor_id, a.name
FROM Actors a
WHERE NOT EXISTS (
          SELECT m.movie_id FROM Movies m
           WHERE m.studio='Universal' AND NOT EXISTS (
                 SELECT * FROM PlaysIn p
                 WHERE p.actor_id=a.actor_id AND p.movie_id=m.movie_id
              )
);

---List the average age of actors for each movie in which at least 4 actors play.
SELECT m.movie_id, AVG(a.age)
FROM Movies m, Actors a, PlaysIn p
WHERE m.movie_id=p.movie_id AND p.actor_id=a.actor_id
GROUP BY m.movie_id
HAVING COUNT(*) >=4;



-- NOT NULL Practies
--------------------
-- see Movies schema
DESC Movies

-- hoq many records we have in  Movies table
SELECT COUNT(*) FROM Movies;
SELECT COUNT(studio) FROM Movies;


-- INSERT a Movie with a NULL studio will work
INSERT INTO Movies(movie_id,title,year) VALUES(400,'Movie D', 2010);

SELECT * FROM Movies;
-- next two queries will not return the same result because studio has a null value in one record
SELECT COUNT(*) FROM Movies;
SELECT COUNT(studio) FROM Movies;

--insert a movie without a year will work
INSERT INTO Movies(movie_id,title) VALUES(500,'Movie E');
-- next two queries will not return the same result because year has a null value
SELECT COUNT(*) FROM Movies m;
SELECT COUNT(*) FROM Movies m WHERE m.year < 2010 or m.year>=2010;

-- CREATE TABLE with NOT NULL constraint on studio colub
CREATE TABLE Movies2(
        movie_id 	NUMBER(9) PRIMARY KEY,
        title	VARCHAR(40),
        year  INT,
        studio   VARCHAR(20)  NOT NULL
);

DESC Movies;
DESC Movies2;

-- next commented out INSERT statement will give will give an error, because studio has a NOT NULL constraint and it is missing from the INSERT statement
-- INSERT INTO Movies2(movie_id,title,year) VALUES(600,'Movie F', 2010);



-- next commented out insert will also give an error because primary key attribute is not present
--INSERT INTO Movies(title,year,studio) VALUES('Movie G', 2010,'Universal');

SELECT * FROM Movies;

-- Find all movies that have a studio
SELECT * FROM Movies where studio IS NOT NULL;

--Find all movies that DO NOT have a studio (i.r. column studio is null)
SELECT *
FROM Movies
WHERE studio IS NULL;


-- insert another movie without year
INSERT INTO Movies(movie_id,title) VALUES(1000,'Movie H');
--with SUM on column that has some null values
SELECT SUM(year) FROM Movies;


SELECT COUNT(*) FROM movies;
SELECT COUNT(year)FROM movies;
SELECT COUNT(studio) FROM movies;

-- group by, will have a group for NULL
SELECT AVG(movie_id), year FROM Movies
GROUP BY year;

-- min
SELECT MIN(year) FROM movies;
-- min and group by
SELECT MIN(year),studio FROM movies GROUP BY studio;
