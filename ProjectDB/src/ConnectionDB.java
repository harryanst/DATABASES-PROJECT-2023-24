package projectdb;

import java.sql.*;

public class ConnectionDB {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/etaireia_aksiologisis";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "556782340";
    public static Connection connection;

    // Establish a database connection
    public static void connectDB() {
        try {
            connection = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            System.out.println("Connected to the Database");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Break database connection
    public static void disconnectDB() {
        try {
            connection.close();
        } catch (SQLException e) {
                e.printStackTrace();
        }
    }
}
