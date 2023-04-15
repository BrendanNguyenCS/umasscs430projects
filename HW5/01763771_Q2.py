import oracledb
import getpass
import pandas.io.sql as pdsql

# READ USERNAME, PASSWORD, DB HOST, DB NAME.
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ")
hostname = input("Enter the hostname:")
database = input("Enter the database:")

# CONNECTS TO OUR ORACLE DB.
if hostname[-1] == '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + database)
elif hostname[-1] != '/':
    connection = oracledb.connect(user=username,
                                  password=userpwd, dsn=hostname + '/' + database)

# USES PANDAS LIBRARY TO RUN A QUERY AGAINST THE DB.
# SAVES THE RESULTS IN A PANDAS DATAFRAME.
q1 = "SELECT * FROM Students"
df1 = pdsql.read_sql(q1, con=connection)

# PRINTS OUT THE NAME OF THE COLUMNS OF THE DATAFRAME.
print("The name of the columns of the first dataframe.")
print(df1.columns)

# PRINTS OUT THE SHAPE OF THE DATAFRAME.
print("First dataframe shape.")
print(df1.shape)

# PRINTS OUT THE FIRST 3 RECORDS FROM THE DATAFRAME.
# USES PANDAS AGGREGATES TO EXTRACT THE AVERAGE AND MIN AGE OF STUDENTS.
# PRINTS THE VALUE.
print("The first 3 records from the first dataframe.")
print(df1.head(3))
print("Calculating the average and minimum age of students...")
print(df1.AGE.agg(['mean', 'min']))

# USES PANDAS AGGREGATES TO GET THE MINIMUM AND MAXIMUM GPA FOR STUDENTS.
# PRINTS THE RESULT.
print("Calculating the minimum and maximum gpa for students...")
print(df1.GPA.agg(['min', 'max']))

# USES PANDAS AGGREGATES TO GET THE SUM OF GPA VALUES. PRINTS THAT RESULT.
print("Calculating the sum of gpa values...")
print(df1.GPA.agg(['sum']))

# RUNS A SECOND QUERY AGAINST THE DB.
q2 = "SELECT s.sid, s.name, s.state, a.aid, a.title FROM Students s, Reads r, Articles a\
 WHERE s.sid = r.sid AND a.aid = r.aid"
df2 = pdsql.read_sql(q2, con=connection)

# PRINTS THIS NEW DATAFRAME.
print("Second dataframe data.")
print(df2)

# PRINTS HOW MANY RECORDS ARE IN THE NEW DATAFRAME.
print("The number of records in the second dataframe.")
print(len(df2.index))

# PRINTS HOW MANY COLUMNS ARE IN THE NEW DATAFRAME.
print("The number of columns in the second dataframe.")
print(len(df2.columns))

# PRINTS THE NAME OF THE COLUMNS FROM THE NEW DATAFRAME.
print("The name of the columns of the second dataframe.")
print(df2.columns)

# USES PANDAS TO FILTER THIS DATAFRAME TO KEEP ONLY STUDENTS FROM STATE MA.
# SAVES THE RESULT INTO A THIRD DATAFRAME.
df3 = df2[df2['STATE'] == 'MA']

# USE PANDAS GROUP BY TO EXTRACT HOW MANY ARTICLES EACH STUDENT FROM MA READ.
# PRINTS THE RESULT.
print("Printing the number of articles read by each student from MA...")
print(df3.groupby('SID').count())

# CLOSE THE CONNECTION.
print("Closing connection...")
connection.close()
