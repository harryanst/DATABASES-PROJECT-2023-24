package projectdb;

public class ProjectDB {

    public static void main(String[] args) {
        // Connect to the database
        ConnectionDB.connectDB();
        
        // Launch the GUI
        java.awt.EventQueue.invokeLater(() -> {
            new JframeDB().setVisible(true);
        });
    }

}
