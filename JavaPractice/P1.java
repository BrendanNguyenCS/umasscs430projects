import java.sql.*;

/**
 * Practice Java SQL app
 */
public class P1 extends OJDBCConnection {
    /**
     * Practice code to show how to connect to the database from a Java app.
     *
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
}
