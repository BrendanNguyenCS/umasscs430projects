import java.io.Console;
import java.sql.*;
import java.util.Scanner;

public class Q2 {
    public static void main(String[] args) {
        // Set up command line input scanner
        Scanner input = new Scanner(System.in);

        // Establish connection to database
        Connection conn;
        conn = getConnection(input);
        if (conn == null) {
            System.out.println("Connection failed.");
            System.exit(1);
        }

        // Get info about customers in database
        System.out.println("Printing customer information...");
        getCustomerInfo(conn);

        // Get info about customers and the movies they watched
        System.out.println("Printing about information about customers and the movies they watched...");
        getCustomerWatchedMovies(conn);

        // Get number of movies in database
        getNumberOfMovies(conn);

        // Get Customers table metadata
        getCustomerMetadata(conn);

        // Get movies produced on the prompted year
        getMoviesFromYear(conn, input);

        // Close the connection
        System.out.println("Closing the connection...");
        try {
            conn.close();
            System.out.println("Connection has been closed.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    /**
     * Establishes a connection to the Oracle SQL database.
     *
     * @return the {@link Connection} object that is connected to the database
     */
    public static Connection getConnection(Scanner input) {
        // First, we need to load the driver
        String jdbcDriver = "oracle.jdbc.OracleDriver";
        try {
            Class.forName(jdbcDriver);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Get username and password
        System.out.print("Username:");
        String username = input.nextLine();
        System.out.print("Password:");
        // The following is used to mask the password
        Console console = System.console();
        String password = new String(console.readPassword());
        // Get the server host name
        System.out.print("Host name:");
        String oracleServer = input.nextLine();
        // Get oracle db instance id
        System.out.print("DB name:");
        String oracleServerSid = input.nextLine();

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

    /**
     * Prints all information about all customers in the database
     *
     * @param connection the database connection instance
     */
    private static void getCustomerInfo(Connection connection) {
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Customers");
            if (rs.next()) {
                do {
                    System.out.println(
                            "Customer id = " + rs.getString("cid") +
                            ", Name = " + rs.getString("name") +
                            ", City = " + rs.getString("city") +
                            ", State = " + rs.getString("state") +
                            ", Age = " + rs.getString("age")
                    );
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting customer information");
            e.printStackTrace();
        }
    }

    /**
     * Prints information about customers and the movies they watched
     *
     * @param connection the database connection instance
     */
    private static void getCustomerWatchedMovies(Connection connection) {
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT c.cid, c.name, m.mid, m.title, w.watchedon FROM Customers c JOIN Watch w ON c.cid = w.cid JOIN Movies m ON w.mid = m.mid");
            if (rs.next()) {
                do {
                    System.out.println(
                            "Customer id = " + rs.getString("cid") +
                            ", Customer name = " + rs.getString("name") +
                            ", Movie id = " + rs.getString("mid") +
                            ", Movie title = " + rs.getString("title") +
                            ", Watched on = " + rs.getString("watchedon")
                    );
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting customers and the movies they watched");
            e.printStackTrace();
        }
    }

    /**
     * Prints the number of movies in the database
     *
     * @param connection the database connection instance
     */
    private static void getNumberOfMovies(Connection connection) {
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Movies");
            if (rs.next()) {
                do {
                    System.out.println("There are " + rs.getString("COUNT(*)") + " movies in this database.");
                } while (rs.next());
            }
            else
                System.out.println("There are no movies in this database.");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting the number of movies in the database");
            e.printStackTrace();
        }
    }

    /**
     * Prints the metadata for the Customers table
     *
     * @param connection the database connection instance
     */
    private static void getCustomerMetadata(Connection connection) {
        try {
            DatabaseMetaData md = connection.getMetaData();
            // Get Customers table metadata
            ResultSet trs = md.getTables(null, null, "CUSTOMERS", null);
            if (trs.next()) {
                do {
                    // Get table name
                    String tableName = trs.getString("TABLE_NAME");
                    System.out.println("The metadata for the Customers table...");
                    // Get table column names and types
                    ResultSet crs = md.getColumns(null, null, tableName, null);
                    while (crs.next()) {
                        System.out.println(
                                "COL_NAME = " + crs.getString("COLUMN_NAME") +
                                ", TYPE = " + crs.getString("TYPE_NAME")
                        );
                    }
                } while (trs.next());
            }
            else
                System.out.println("The CUSTOMER table doesn't exist");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting getting Customer table metadata");
            e.printStackTrace();
        }
    }

    /**
     * Prints the movies released in the year given from standard input
     *
     * @param connection the database connection instance
     * @param input      the command line input scanner
     */
    private static void getMoviesFromYear(Connection connection, Scanner input) {
        // Get user prompted year
        System.out.print("Enter a year to find the movies from that year: ");
        int year = input.nextInt();
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT mid, title, director FROM Movies WHERE releaseyear = " + year);
            if (rs.next()) {
                do {
                    System.out.println(
                            "Movie id = " + rs.getString("mid") +
                            ", Movie title = " + rs.getString("title") +
                            ", Director = " + rs.getString("director")
                    );
                } while (rs.next());
            }
            else
                System.out.println("There were no records for the year " + year);
        } catch (Exception e) {
            System.out.println("ERROR OCCURRED while getting ");
        }
    }
}
