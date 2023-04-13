import oracledb
import getpass

# read input arguments: username, password, db host, db name
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ")
hostname = input("Enter the hostname:")
database = input("Enter the database:")

'''
if hostname does not have / at the end, then add it.

Establish the connection to DBMS
'''
if hostname[-1] == '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + database)
elif hostname[-1] != '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + '/' + database)

curs = connection.cursor()  # creates a cursor that will be needed to access the databases

# GET LIST OF ALL TABLES THAT BELONG TO THIS USERNAME #

print("Tables created by this user:")
for table in curs.execute("SELECT table_name FROM user_tables"):
    print(table)

# IF TABLE RESERVES_SAMPLE EXISTS, DROP IT
curs.execute("SELECT COUNT(*) FROM user_tables WHERE table_name='RESERVES_SAMPLE'")
has_reserves_sample = curs.fetchone()
if has_reserves_sample[0] == 1:
    curs.execute("DROP TABLE reserves_sample")
    print("Table reserves_sample dropped.")

# IF TABLE BOATS_SAMPLE EXISTS, DROP IT
curs.execute("SELECT COUNT(*) FROM user_tables WHERE table_name='BOATS_SAMPLE'")
has_boats_sample = curs.fetchone()
if has_boats_sample[0] == 1:
    curs.execute("DROP TABLE boats_sample")
    print("Table boats_sample dropped.")

# IF TABLE SAILORS_SAMPLE EXISTS, DROP IT
curs.execute("SELECT COUNT(*) FROM user_tables WHERE table_name='SAILORS_SAMPLE'")
has_sailors_sample = curs.fetchone()
if has_sailors_sample[0] == 1:
    curs.execute("DROP TABLE sailors_sample")
    print("Table sailors_sample dropped.")

# CREATE TABLES #
print("Before creating table sailors_sample.")
curs.execute("CREATE TABLE sailors_sample(sid NUMBER(9) PRIMARY KEY, sname VARCHAR(20))")
print("After creating table sailors_sample.")
print("Before creating table boats_sample.")
curs.execute("CREATE TABLE boats_sample(bid NUMBER(9) PRIMARY KEY, name VARCHAR(20), color VARCHAR(20))")
print("After creating table boats_sample.")
print("Before creating table reserves_sample.")
curs.execute(
    "CREATE TABLE reserves_sample(sid NUMBER(9),bid NUMBER(9),PRIMARY KEY(sid, bid), FOREIGN KEY (sid)\
     REFERENCES sailors_sample, FOREIGN KEY(bid) REFERENCES boats_sample)")
print("After creating table reserves_sample.")

# ALTER TABLE sailors_sample #
curs.execute("ALTER TABLE sailors_sample ADD (rating NUMBER(2), age NUMBER(4,2))")
print("After altering table sailors_sample.")

# INSERT RECORDS INTO TABLES #
print("Inserting 3 records into sailors_sample.")
curs.execute("INSERT INTO sailors_sample VALUES (22, 'dustin', 7, 45.0)")
curs.execute("INSERT INTO sailors_sample VALUES (31, 'lubber', 8, 55.5)")
curs.execute("INSERT INTO sailors_sample VALUES (58, 'rusty', 10, 35.0)")
print("Inserting 1 record into boats_sample.")
curs.execute("INSERT INTO boats_sample VALUES (101,'interlake', 'red')")
print("Inserting 1 record into reserves_sample.")
curs.execute("INSERT INTO  reserves_sample VALUES (22,101)")
print("After inserting data.")

# RUN SELECT STATEMENT (find the name of the sailor(s) who reserved a red boat. #
print("Find the name of the sailor(s) who reserved a red boat")
for row in curs.execute("SELECT s.sname FROM sailors_sample S, reserves_sample R,\
Boats_sample B WHERE s.sid = r.sid AND r.bid = b.bid AND b.color = 'red'"):
    print(row)

print("Committing transaction.")
connection.commit()
print("Closing connection.")
connection.close()
