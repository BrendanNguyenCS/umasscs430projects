import java.sql.*;
import java.util.Scanner;

/**
 * Practice Java SQL app
 */
public class P3 {
    /**
     * Practice code to show how to the column information for a given table in the database.
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Establish connection to database
        Connection conn;
        conn = P1.getConnection();
        if (conn == null)
            System.exit(1);

        // Inspect metadata
        Scanner input = new Scanner(System.in);
        try {
            // Retrieve info about tables matching input
            while (true) {
                // Get table name from user
                System.out.print("Table Name (in UPPER CASE). <Enter -1 to exit>: ");
                String filter = input.nextLine();
                if (filter.equals("-1")) {
                    System.out.println("Program will exit.");
                    break;
                }
                // Retrieve table data
                DatabaseMetaData md = conn.getMetaData();
                ResultSet trs = md.getTables(null, null, filter, null);
                if (trs.next()) {
                    do {
                        String tableName = trs.getString("TABLE_NAME");
                        System.out.println("Table: " + tableName);
                        // Retrieve and print this table's column info
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
                    System.out.println("No Such Table");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED");
            e.printStackTrace();
        }
    }
}
