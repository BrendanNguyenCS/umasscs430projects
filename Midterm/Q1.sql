CREATE TABLE Customers (
    cid          NUMBER(9) PRIMARY KEY,
    cname        VARCHAR(50),
    ccity        VARCHAR(50),
    cstate       VARCHAR(50),
    dob          DATE,
    phone_number VARCHAR(20)
);

CREATE TABLE Hotels (
    hid         NUMBER(9) PRIMARY KEY,
    hname       VARCHAR(50),
    hcity       VARCHAR(50),
    hstate      VARCHAR(50),
    star_number INT
);

CREATE TABLE Stays (
    cid NUMBER(9),
    hid NUMBER(9),
    PRIMARY KEY (cid, hid),
    FOREIGN KEY (cid) REFERENCES Customers,
    FOREIGN KEY (hid) REFERENCES Hotels
);