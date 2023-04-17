# UMass Boston CS430 (Database Management Systems)

This is a remote repository for all my CS430 homework, projects, and other associated files. This repository contains my solutions for each of the given assignments. View at your own discretion as answers/solutions may not be correct.

## Running SQL Code Exclusively on UNIX

To run the SQL code, you will need to connect to the UMB CS UNIX machine with your given credentials using the SSH protocol. Once you are in the UNIX machine, you can launch `sqlplus`, the SQL CLI that is used to execute queries against the Oracle database. The command to connect is as follows:

```console
sqlplus username/pass@//dbs3.cs.umb.edu/dbs3
```

Where `username` and `pass` are the Oracle account credentials given to you by the professor. Once you connect, the CLI allows you to execute SQL statements.

## Running Python Code on UNIX

The python scripts in this repository utilize the [python-oracledb](https://oracle.github.io/python-oracledb/) package to connect to the Oracle database. In the directory where the python script lies, you can run the following command to run the code.

```console
python3 samplePythonAndSQL.py
```

The python script will prompt you to enter the username and password of the Oracle account that was created by the professor. In addition, it will prompt you for the DB hostname and database instance, which are `dbs3.cs.umb.edu` and `dbs3` respectively.

## Running Java Code on UNIX

The Java files in this repository utilize the JDBC (Java DataBase Connectivity) API and its Driver to connect to the Oracle database. Run the given jar file which contains the files needed to compile and run the programs.

```console
export CLASSPATH=/home/yourPath/ojdbc11.jar
```

Where `/home/yourPath` is replaced by the full path of the directory where `ojdbc11.jar` lies.

Use `cd` to go to the folder where the java code lies.

You must compile the java files before running them.

```console
javac P1.java
```

Then you can run the java file.

```console
java P1.java
```

The program will prompt you to enter your Oracle account credentials (just like the previous sections).