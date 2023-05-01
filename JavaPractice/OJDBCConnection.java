import java.io.*;
import java.sql.*;
import java.util.Scanner;

public abstract class OJDBCConnection {
    /**
     * The server host name
     */
    private static final String oracleServer = "dbs3.cs.umb.edu";
    /**
     * The server instance name/id
     */
    private static final String oracleServerSid = "dbs3";

    /**
     * Establishes a connection to the Oracle SQL database.
     *
     * @return the {@link Connection} object that is connected to the database
     */
    public static Connection getConnection() {
        // First, we need to load the driver
        String jdbcDriver = "oracle.jdbc.OracleDriver";
        try {
            Class.forName(jdbcDriver);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Get username and password
        Scanner input = new Scanner(System.in);
        System.out.print("Username:");
        String username = input.nextLine();
        System.out.print("Password:");
        // The following is used to mask the password
        Console console = System.console();
        String password = new String(console.readPassword());
        String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:" + oracleServerSid;

        System.out.println("Connecting to the database...");

        Connection conn;
        // Connect to the database
        try {
            conn = DriverManager.getConnection(connString, username, password);
            System.out.println("Connection Successful");
        } catch (SQLException e) {
            System.out.println("Connection ERROR");
            e.printStackTrace();
            return null;
        }

        return conn;
    }
}
