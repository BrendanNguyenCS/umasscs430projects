import java.sql.*;
import java.util.Scanner;

/**
 * Practice Java SQL app
 */
public class P2 extends OJDBCConnection {
    /**
     * Practice code to show how to get information about sailors above a given rating threshold.
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Establish connection to database
        Connection conn;
        conn = getConnection();
        if (conn == null)
            System.exit(1);

        // Now execute query
        Scanner input = new Scanner(System.in);
        try {
            // Create statement object
            Statement stmt = conn.createStatement();
            while (true) {
                // Get a minimum rating for sailors
                System.out.print("Enter the minimum rating (enter -1 to exit the program): ");
                int rating_no = input.nextInt();
                if (rating_no == -1) {
                    System.out.println("Program will exit.");
                    break;
                }
                // Execute the query statement
                ResultSet rs = stmt.executeQuery("SELECT sname, rating, age, FROM Sailors WHERE rating >= " + rating_no);
                // Print all records from query result
                if (rs.next()) {
                    do {
                        System.out.println(
                            "Name = " + rs.getString("sname") +
                            ", Rating = " + rs.getString("rating") +
                            ", Age = " + rs.getString("age")
                        );
                    } while (rs.next());
                }
                else
                    System.out.println("No Records Retrieved");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED");
            e.printStackTrace();
        }
    }
}
