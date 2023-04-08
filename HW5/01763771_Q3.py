import oracledb
import getpass

# READ USERNAME, PASSWORD, DB HOST, DB NAME from command line
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ")  # Enter the pass set for you to access
hostname = input("Enter the hostname:")
database = input("Enter the database:")

# Connects to our Oracle DB.
if hostname[-1] == '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + database)
elif hostname[-1] != '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + '/' + database)

cursor = connection.cursor()

# Drop tables and re-create the 3 tables with cursor.
try:
    cursor.execute('DROP TABLE Reads')
except oracledb.Error:
    pass
finally:
    try:
        cursor.execute('DROP TABLE Articles')
    except oracledb.Error:
        pass
    finally:
        try:
            cursor.execute('DROP TABLE Students')
        except oracledb.Error:
            pass


createQueries = [
    'CREATE TABLE Articles (aid NUMBER(9) PRIMARY KEY, title VARCHAR(40), author VARCHAR(50), pubyear INT)',
    'CREATE TABLE Students (sid NUMBER(9) PRIMARY KEY, name VARCHAR(50), city VARCHAR(40), state VARCHAR(40), age REAL, gpa REAL, CONSTRAINT GPARange CHECK (gpa >= 1 AND gpa <= 4))',
    'CREATE TABLE Reads (aid NUMBER(9), sid NUMBER(9), rday DATE NOT NULL, PRIMARY KEY (aid, sid), FOREIGN KEY (aid) REFERENCES Articles, FOREIGN KEY (sid) REFERENCES Students)']

for q in createQueries:
    cursor.execute(q)

# Uses the cursor to insert two records in each table.
insertArticles = [
    'INSERT INTO Articles VALUES (1, "Why PostgreSQL is Better than MySQL", "Tom Brady", 2020)',
    'INSERT INTO Articles VALUES (2, "5 Reasons Why NoSQL Databases Should Be Widely Adopted", "Steve Jobs", 2019)']
insertStudents = [
    'INSERT INTO Students VALUES (1, "Brendan", "Boston", "MA", 22, 3.3)',
    'INSERT INTO Students VALUES (2, "Dennis", "Los Angeles", "CA", 20, 3.7)']
insertReads = [
    'INSERT INTO Reads (aid, sid, rday) VALUES (1, 1, TO_DATE("12/21/2022", "MM/DD/YYYY"))',
    'INSERT INTO Reads (aid, sid, rday) VALUES (2, 2, TO_DATE("11/09/2020", "MM/DD/YYYY"))']

for a in insertArticles:
    cursor.execute(a)
for s in insertStudents:
    cursor.execute(s)
for r in insertReads:
    cursor.execute(r)

# Uses the cursor to run a select query that extracts all articles.
# Prints all records extracted.
print("Outputting all records in Articles")
cursor.execute('SELECT * FROM Articles')
cursor.fetchall()

# Uses the cursor to run a select query that extracts all students.
# Prints all records extracted.
print("Outputting all records in Students")
cursor.execute('SELECT * FROM Students')
cursor.fetchall()

# Uses the cursor to run a select query that extracts all records from Reads.
# Prints all records extracted.
print("Outputting all records in Reads")
cursor.execute('SELECT * FROM Reads')
cursor.fetchall()

# Commits the transaction
connection.commit()

# Closes the connection
connection.close()
