import java.sql.*;
import java.io.*;
import java.util.Scanner;

/**
 * Practice Java SQL app
 */
public class P1 {
    /**
     * The server host name
     */
    public static final String oracleServer = "dbs3.cs.umb.edu";
    /**
     * The server instance name/id
     */
    public static final String oracleServerSid = "dbs3";

    /**
     * Practice code to show how to connect to the database from a Java app.
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Establish connection to database
        Connection conn;
        try {
            conn = getConnection();
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    /**
     * Establishes a connection to the Oracle SQL database.
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
