import java.sql.*;
import java.util.*;

public class P4 extends OJDBCConnection {
    /**
     * This program hosts several programs which shows off the abilities of Oracle OJDB.
     *
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Establish connection to database
        Connection conn;
        conn = getConnection();
        if (conn == null)
            System.exit(1);

        // Set up command line input scanner
        Scanner input = new Scanner(System.in);
        boolean exit = false;

        // Looping program
        while (true) {
            System.out.print("""
                    Select one of the following programs to launch:
                    1- Ratings Statistics of Sailors of All Age Groups
                    2- Average Ages per Rating
                    3- Ages and Their Actors
                    4- Years and Its Movies
                    5- Studios and Their Movies
                    6- Movie Information
                    7- Boat Color Counts
                    8- Boat Reservation History
                    9- Books and Their Authors
                    -1- Exit
                    :""");
            int option;
            try {
                option = input.nextInt();
            } catch (InputMismatchException e) {
                System.out.println("Your selection must be the number next to the program you want to launch. Please try again.");
                continue;
            }

            switch (option) {
                case 1 -> printRatingsPerAge(conn);
                case 2 -> printAverageAgePerRating(conn);
                case 3 -> printActorsByAge(conn, input);
                case 4 -> printMoviesByYear(conn, input);
                case 5 -> printMoviesByStudio(conn, input);
                case 6 -> printMovieInfo(conn, input);
                case 7 -> printBoatCountByColor(conn);
                case 8 -> printBoatReservationHistory(conn);
                case 9 -> printBooksAndAuthors(conn);
                case -1 -> exit = true;
                default -> System.out.println("Not a valid option.");
            }
            if (exit) {
                System.out.println("The program will terminate.");
                break;
            }
        }
    }

    /**
     * Prints out the ratings statistics of sailors of all age groups.
     *
     * @param connection the database connection instance
     */
    private static void printRatingsPerAge(Connection connection) {
        if (connection == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT age, MIN(rating), MAX(rating), AVG(rating) FROM Sailors GROUP BY age");
            if (rs.next()) {
                do {
                    System.out.println(
                            "Age = " + rs.getString("age") +
                            ", Min Rating = " + rs.getString("MIN(rating)") +
                            ", Max Rating = " + rs.getString("MAX(rating)") +
                            ", Avg Rating = " + rs.getString("AVG(rating)")
                    );
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting rating statistics for age groups");
            e.printStackTrace();
        }
    }

    /**
     * Prints out the average age of sailors for each rating.
     *
     * @param connection the database connection instance
     */
    private static void printAverageAgePerRating(Connection connection) {
        if (connection == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT rating, AVG(age) FROM Sailors GROUP BY rating HAVING COUNT(*) >= 3");
            if (rs.next()) {
                do {
                    System.out.println(
                            "Rating = " + rs.getString("rating") +
                            ", Avg Age = " + rs.getString("AVG(age)")
                    );
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting age statistics for rating groups");
            e.printStackTrace();
        }
    }

    /**
     * Recursively prints the names of actors of the requested age.
     *
     * @param connection the database connection instance
     * @param input      the command line input scanner
     */
    private static void printActorsByAge(Connection connection, Scanner input) {
        if (connection == null || input == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            while (true) {
                System.out.print("Enter the age to find actors (enter -1 to return to main menu): ");
                int age = input.nextInt();
                if (age == -1) {
                    System.out.println("Program will exit. You will be returned to the main menu.");
                    break;
                }
                ResultSet rs = stmt.executeQuery("SELECT name FROM Actors WHERE age = " + age);
                if (rs.next()) {
                    System.out.println("The actors of age " + age + " are: ");
                    do {
                        System.out.println(rs.getString("name"));
                    } while (rs.next());
                }
                else
                    System.out.println("There are no actors of age " + age + " in this database.");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting actors of the given age");
            e.printStackTrace();
        } catch (InputMismatchException e) {
            System.out.println("ERROR OCCURRED while reading the age");
            e.printStackTrace();
        }
    }

    /**
     * Recursively prints the titles of movies produced in the requested year.
     *
     * @param connection the database connection instance
     * @param input      the command line input scanner
     */
    private static void printMoviesByYear(Connection connection, Scanner input) {
        if (connection == null || input == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            while (true) {
                System.out.print("Enter the year to find movies from that year (enter -1 to return to main menu): ");
                int year = input.nextInt();
                if (year == -1) {
                    System.out.println("Program will exit. You will be returned to the main menu.");
                    break;
                }
                ResultSet rs = stmt.executeQuery("SELECT title FROM Movies WHERE year = " + year);
                if (rs.next()) {
                    do {
                        System.out.print(rs.getString("title"));
                    } while (rs.next());
                }
                else
                    System.out.println("There are no movies from the year " + year + "in this database.");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting movies by the given year");
            e.printStackTrace();
        } catch (InputMismatchException e) {
            System.out.println("ERROR OCCURRED while reading the year");
            e.printStackTrace();
        }
    }

    /**
     * Recursively prints the titles and year of movies produced by the requested studio (case-insensitive).
     *
     * @param connection the database connection instance
     * @param input      the command line input scanner
     */
    private static void printMoviesByStudio(Connection connection, Scanner input) {
        if (connection == null || input == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            while (true) {
                System.out.println("Enter the studio to find movies from that studio (enter -1 to return to main menu): ");
                String studio = input.nextLine();
                if (studio.equals("-1")) {
                    System.out.println("Program will exit. You will be returned to the main menu.");
                    break;
                }
                ResultSet rs = stmt.executeQuery("SELECT title, year FROM Movies WHERE LOWER(studio) = " + studio.toLowerCase());
                if (rs.next()) {
                    do {
                        System.out.println(
                                rs.getString("title") + " (" + rs.getString("year") + ")"
                        );
                    } while (rs.next());
                }
                else
                    System.out.println("There are no movies from " + studio + "in this database.");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting movies from the given studio");
            e.printStackTrace();
        }
    }

    /**
     * Recursively prints the studio and cast list for the requested movie (case-insensitive).
     *
     * @param connection the database connection instance
     * @param input      the command line input scanner
     */
    private static void printMovieInfo(Connection connection, Scanner input) {
        if (connection == null || input == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            while (true) {
                System.out.println("Enter the movie to find the actors who participated and their characters (enter -1 to return to main menu): ");
                String movie = input.nextLine();
                if (movie.equals("-1")) {
                    System.out.println("Program will exit. You will be returned to the main menu.");
                    break;
                }
                ResultSet rs = stmt.executeQuery("SELECT a.name, p.character, m.studio FROM Movies m JOIN PlaysIn p ON m.movie_id = p.movie_id JOIN Actors a ON a.actor_id = p.actor_id WHERE LOWER(m.title) = " + movie.toLowerCase());
                if (rs.next()) {
                    System.out.println("This movie was produced by " + rs.getString("studio") + ".");
                    System.out.println("Its cast list is as follows:");
                    do {
                        System.out.println("\t" + rs.getString("name") + " -> " + rs.getString("character"));
                    } while (rs.next());
                }
                else
                    System.out.println(movie + " does not exist in this database.");
            }
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting the cast list for the given movie");
            e.printStackTrace();
        }
    }

    /**
     * Prints out the number of boats for each color in the database.
     *
     * @param connection the database connection instance
     */
    private static void printBoatCountByColor(Connection connection) {
        if (connection == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT color, COUNT(*) FROM Boats GROUP BY color");
            if (rs.next()) {
                do {
                    System.out.println(rs.getString("color") + " : " + rs.getString("COUNT(*)"));
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting totals per boat color");
            e.printStackTrace();
        }
    }

    /**
     * Prints the boat reservation history of sailors who have reserved more than 2 boats.
     *
     * @param connection the database connection instance
     */
    private static void printBoatReservationHistory(Connection connection) {
        if (connection == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT s.sid, COUNT(*) FROM Sailors s JOIN Reserves r ON s.sid = r.sid JOIN Boats b ON b.bid = r.bid GROUP BY s.sid HAVING COUNT(*) >= 2");
            if (rs.next()) {
                do {
                    System.out.println(rs.getString("sid") + ": " + rs.getString("COUNT(*)") + " boats");
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting boat reservation history");
            e.printStackTrace();
        }
    }

    /**
     * Prints the names, publication year, and author for all books in the database.
     *
     * @param connection the database connection instance
     */
    private static void printBooksAndAuthors(Connection connection) {
        if (connection == null) {
            System.out.println("ERROR OCCURRED: null parameter");
            return;
        }
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT a.aid, a.name, b.bid, b.bname, b.pubyear FROM Authors a JOIN Write w ON a.aid = w.aid JOIN Books b ON w.bid = b.bid");
            if (rs.next()) {
                do {
                    System.out.println(
                            rs.getString("bname") + " (" + rs.getString("pubyear") + ") by " + rs.getString("name")
                    );
                } while (rs.next());
            }
            else
                System.out.println("No Records Retrieved");
        } catch (SQLException e) {
            System.out.println("ERROR OCCURRED while getting authors and the books they wrote");
            e.printStackTrace();
        }
    }
}
