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

# Closes the connection
connection.close()
