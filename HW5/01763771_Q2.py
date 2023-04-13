import oracledb
import getpass
import pandas.io.sql as pdsql

# Reads from the input: an Oracle username, Oracle password, Oracle hostname, Oracle DB name.
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ")
hostname = input("Enter the hostname:")
database = input("Enter the database:")

# Connects to our Oracle DB.
if hostname[-1] == '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + database)
elif hostname[-1] != '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + '/' + database)

# Uses PANDAS library to run a query against the DB.
# Saves the results in a pandas dataframe.
q1 = "SELECT * FROM Students"
df1 = pdsql.read_sql(q1, con=connection)

# Prints out the name of the columns of the dataframe.
print("The name of the columns of the first dataframe.")
print(df1.columns)

# Prints out the shape of the dataframe.
print("First dataframe shape.")
print(df1.shape)

# Prints out the first 3 records from the dataframe.
# Uses pandas aggregates to extract the average and min age of students.
# Prints the value.
print("The first 3 records from the first dataframe.")
print(df1.head(3))
print("Calculating the average and minimum age of students.")
print(df1.AGE.agg(['mean', 'min']))

# Uses pandas aggregates to get the minimum and maximum gpa for students.
# Prints the result.
print("Calculating the minimum and maximum gpa for students.")
print(df1.GPA.agg(['min', 'max']))

# Uses pandas aggregates to get the sum of gpa values. Prints that result.
print("Calculating the sum of gpa values.")
print(df1.GPA.agg(['sum']))

# Runs a second query against the DB.
q2 = "SELECT s.sid, s.name, s.state, a.aid, a.title FROM Students s, Reads r, Articles a\
 WHERE s.sid = r.sid AND a.aid = r.aid"
df2 = pdsql.read_sql(q2, con=connection)

# Prints this new dataframe.
print("Second dataframe data.")
print(df2)

# Prints how many records are in the new dataframe.
print("The number of records in the second dataframe.")
print(len(df2.index))

# Prints how many columns are in the new dataframe.
print("The number of columns in the second dataframe.")
print(len(df2.columns))

# Prints the name of the columns from the new dataframe
print("The name of the columns of the second dataframe.")
print(df2.columns)

# Close the connection
print("Closing connection.")
connection.close()
