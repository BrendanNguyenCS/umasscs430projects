import java.sql.*;
import java.util.Scanner;

public class P2 {
    public static void main(String[] args) {
        Connection conn;
        conn = P1.getConnection();
        if (conn == null)
            System.exit(1);

        // now execute query
        Scanner input = new Scanner(System.in);
        try {
            // Create statement object
            Statement stmt = conn.createStatement();
            while (true) {
                // get a minimum rating for sailors
                System.out.print("Enter the minimum rating (enter -1 to exit the program): ");
                int rating_no = input.nextInt();
                if (rating_no == -1) {
                    System.out.println("Program will exit.");
                    break;
                }
                ResultSet rs = stmt.executeQuery("SELECT sname, rating, age, FROM Sailors" + " WHERE rating >= " + rating_no);
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
