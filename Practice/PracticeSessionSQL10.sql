/**
  Solutions for Exercise 3.8 (pg. 96) from Database Management Systems Third Edition by Ramakrishnan and Gehrke
 */

/**
  2. Write the SQL statements required to create the preceding relations, including appropriate versions of all primary and foreign key integrity constraints.
 */
CREATE TABLE Emp (
    eid    INT PRIMARY KEY,
    ename  VARCHAR(40),
    age    INT,
    salary REAL
);

CREATE TABLE Works (
    eid      INT,
    did      INT,
    pct_time INT,
    PRIMARY KEY (eid, did),
    FOREIGN KEY (eid) REFERENCES Emp,
    FOREIGN KEY (did) REFERENCES Dept ON DELETE CASCADE
);

/**
  3. Define the Dept relation in SQL so that every department is guaranteed to have a manager.
 */
CREATE TABLE Dept (
    did       INT PRIMARY KEY,
    dname     VARCHAR(50),
    budget    REAL,
    managerid INT NOT NULL,
    FOREIGN KEY (managerid) REFERENCES Emp
);

/**
  4. Write an SQL statement to add John Doe as an employee with eid = 101, age = 32, and salary = 15,000.
 */
INSERT INTO Emp
    VALUES (101, 'John Doe', 32, 15000);

/**
  5. Write an SQL statement to give every employee a 10 percent raise.
 */
UPDATE Emp
SET salary = salary * 1.1;

/**
  6. Write an SQL statement to delete the Toy department. Given the referential integrity constraints you chose for this schema, explain what happens when this statement is executed.
 */
DELETE
    FROM Dept
    WHERE dname = 'Toy';

    /**
      When this record is deleted, any references to this department in Works will also be deleted.
     */