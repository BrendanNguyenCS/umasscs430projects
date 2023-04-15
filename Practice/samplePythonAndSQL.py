import oracledb
import getpass
import pandas.io.sql as pdsql

# READ USERNAME, PASSWORD, DB HOST, DB NAME FROM COMMAND LINE
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

# RUN QUERY AGAINST DB
df = pdsql.read_sql("SELECT * FROM Sailors", con=connection)
# PRINT THE NAMES OF COLUMNS FROM THE DATAFRAME
print(df.columns)
print('Dataframe data')
print(df)
# PRINTS THE FIRST 5 ROWS
print("df head")
print(df.head())
print("df shape")
print(df.shape)
print("df with only name and age")
df2 = df[['SNAME', 'AGE']]
print(df2)
print("df2 shape")
print(df2.shape)

print("Calculate min and mean for all columns")
print(df.agg(['min', 'mean']))

print("Average only for rating column")
print(df.RATING.agg(['mean']))

print("Another way to get the average only for rating column")
print(df[['RATING']].agg(['mean']))

# CLOSE THE CONNECTION
connection.close()
