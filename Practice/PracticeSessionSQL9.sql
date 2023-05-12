-- Simple stored procedure
CREATE OR REPLACE PROCEDURE SUM_AB(A INT, B INT, C OUT INT) IS
BEGIN
    C := A + B;
END;

-- Simple stored function
CREATE OR REPLACE FUNCTION ADD_TWO(A INT, B INT) RETURN INT IS
BEGIN
    RETURN (A + B);
END;

/** Used for Intellisense for following examples **/
CREATE TABLE Sailors (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2)
);
/**************************************************/

-- Granting privileges
CREATE USER Horatio IDENTIFIED BY h123;
GRANT INSERT, SELECT ON Sailors TO Horatio

CREATE USER Yuppy IDENTIFIED BY yuppy1;
GRANT INSERT, DELETE ON Sailors TO Yuppy WITH GRANT OPTION;

CREATE USER Dustin IDENTIFIED BY duster96;
GRANT INSERT (rating) ON Sailors TO Dustin;

-- Revoking privileges
REVOKE INSERT ON Sailors FROM Yuppy;