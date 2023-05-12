-- Simple PL/SQL Example
DECLARE
    message VARCHAR(20) := 'Hello world!';
BEGIN
    DBMS_OUTPUT.PUT_LINE(message);
END;

-- PL/SQL Branches
DECLARE
    A NUMBER(6) := 10;
    B NUMBER(6);
BEGIN
    A := 23;
    B := A * 5;
    IF A < B THEN
        DBMS_OUTPUT.PUT_LINE(A || ' IS LESS THAN ' || B);
    ELSE
        DBMS_OUTPUT.PUT_LINE(B || ' IS LESS-OR-equal THAN ' || A);
    END IF;
END;

-- PL/SQL Loops
BEGIN
    FOR K IN 1..5
        LOOP
            DBMS_OUTPUT.PUT_LINE('K = ' || K);
        END LOOP;
END;

/** Used for Intellisense for following examples **/
CREATE TABLE Sailors (
    sid    NUMBER(9) PRIMARY KEY,
    sname  VARCHAR(20),
    rating NUMBER(2),
    age    NUMBER(4, 2)
);
/**************************************************/

-- PL/SQL Data gathering
DECLARE
    VAR_NAME Sailors.sname%TYPE;
    VAR_AGE  Sailors.age%TYPE;
BEGIN
    SELECT sname, age INTO VAR_NAME, VAR_AGE FROM Sailors WHERE sid = 10;
    DBMS_OUTPUT.PUT_LINE('Age OF ' || VAR_NAME || ' IS ' || VAR_AGE);
END;

-- PL/SQL Cursor
DECLARE
    S Sailors%ROWTYPE;
    CURSOR SAILORCURSOR IS
        SELECT *
            FROM Sailors;
BEGIN
    OPEN SAILORCURSOR;
    LOOP
        FETCH SAILORCURSOR INTO S;
        EXIT WHEN SAILORCURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('AGE OF ' || S.sname || ' IS ' || S.age);
    END LOOP;
    CLOSE SAILORCURSOR;
END;