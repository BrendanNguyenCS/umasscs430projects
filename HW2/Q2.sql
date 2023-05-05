-- Answer for c)
CREATE TABLE Countries (
    countryname VARCHAR(20) PRIMARY KEY,
    capital     VARCHAR(20),
    president   VARCHAR(20),
    continent   VARCHAR(20)
);

CREATE TABLE Persons (
    id        NUMBER(9) PRIMARY KEY,
    firstName VARCHAR(20),
    lastName  VARCHAR(20),
    dob       DATE
);

CREATE TABLE Visited (
    id          NUMBER(9),
    countryname VARCHAR(20),
    PRIMARY KEY (id, countryname),
    FOREIGN KEY (id) REFERENCES Persons,
    FOREIGN KEY (countryname) REFERENCES Countries
);

-- Answer for d)
ALTER TABLE Persons ADD (
    city VARCHAR(50), state VARCHAR(50)
);

-- Answer for e)
DROP TABLE Visited;
DROP TABLE Persons;
DROP TABLE Countries;