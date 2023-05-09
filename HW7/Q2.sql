-- Answer for a)
CREATE USER joe IDENTIFIED BY joe123;

-- Answer for b)
GRANT SELECT, INSERT ON Sailors TO joe WITH GRANT OPTION;