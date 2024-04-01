package projectdb;

import java.sql.*;

public class JframeDB extends javax.swing.JFrame {

    public JframeDB() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        java.awt.GridBagConstraints gridBagConstraints;

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        username_textfield = new java.awt.Label();
        password_textfield = new java.awt.Label();
        username_field = new java.awt.TextField();
        login_button = new javax.swing.JButton();
        top_label = new javax.swing.JLabel();
        password_field = new javax.swing.JPasswordField();
        status_label = new javax.swing.JLabel();

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new java.awt.GridBagLayout());

        username_textfield.setFont(new java.awt.Font("Dialog", 1, 18)); // NOI18N
        username_textfield.setName(""); // NOI18N
        username_textfield.setText("username");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(84, 216, 0, 0);
        getContentPane().add(username_textfield, gridBagConstraints);

        password_textfield.setFont(new java.awt.Font("Dialog", 1, 18)); // NOI18N
        password_textfield.setText("password");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 216, 0, 0);
        getContentPane().add(password_textfield, gridBagConstraints);

        username_field.setFont(new java.awt.Font("Dialog", 0, 18)); // NOI18N
        username_field.setText("");
        
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.ipadx = 105;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(84, 10, 0, 0);
        getContentPane().add(username_field, gridBagConstraints);

        login_button.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        login_button.setText("Login");
        login_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                login_buttonActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(18, 10, 0, 0);
        getContentPane().add(login_button, gridBagConstraints);

        top_label.setFont(new java.awt.Font("Segoe UI", 0, 24)); // NOI18N
        top_label.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        top_label.setText("Employee Evaluation Database Management");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(62, 166, 0, 215);
        getContentPane().add(top_label, gridBagConstraints);

        password_field.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.ipadx = 141;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 10, 0, 0);
        getContentPane().add(password_field, gridBagConstraints);

        status_label.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        status_label.setForeground(new java.awt.Color(255, 0, 0));
        status_label.setToolTipText("");
        status_label.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.ipadx = 472;
        gridBagConstraints.ipady = 32;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(40, 166, 6, 215);
        getContentPane().add(status_label, gridBagConstraints);

        pack();
    }// </editor-fold>//GEN-END:initComponents
    
    // Method called when the login button is pressed
    private void login_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_login_buttonActionPerformed
        String username = username_field.getText();
        String password = new String(password_field.getPassword());
        
      try {
           // Check if the provided username and password exist in the user table
           String loginQuery = "SELECT * FROM user WHERE username = ? AND password = ?";
           PreparedStatement loginStatement = ConnectionDB.connection.prepareStatement(loginQuery);
           loginStatement.setString(1, username);
           loginStatement.setString(2, password);

           ResultSet loginResult = loginStatement.executeQuery();

            if (loginResult.next()) { // User exists
                // Check if the user is also an active administrator
                String adminQuery = "SELECT * FROM administrator WHERE admin_name = ? AND end_date IS NULL";
                PreparedStatement adminStatement = ConnectionDB.connection.prepareStatement(adminQuery);
                adminStatement.setString(1, username);
               
                ResultSet adminResult = adminStatement.executeQuery();

                if (adminResult.next()) { // Admin exists
                   // Successful login as an administrator
                   System.out.println("Login successful");

                   // Insert the username into the active_admin table
                   insertIntoActiveAdmin(username);

                   // Launch the main GUI
                   java.awt.EventQueue.invokeLater(() -> {
                       new JframeDBMain().setVisible(true);
                   });

                   // Dispose the login window
                   dispose();
                } else {
                  // User is not an administrator or the end_date is not NULL
                    status_label.setText("User is not an active administrator");
                }
            } else {
                // Failed login
                status_label.setText("Invalid username or password");
            }

        } catch (SQLException e) {
           e.printStackTrace();
        }
    }//GEN-LAST:event_login_buttonActionPerformed

    // Stating that the user logged in is the active admin
    private void insertIntoActiveAdmin(String username) {
        try {
            String query = "INSERT INTO active_admin (username) VALUES (?)";
            PreparedStatement preparedStatement = ConnectionDB.connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
           e.printStackTrace();
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel jPanel1;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JButton login_button;
    private javax.swing.JPasswordField password_field;
    private java.awt.Label password_textfield;
    private javax.swing.JLabel status_label;
    private javax.swing.JLabel top_label;
    private java.awt.TextField username_field;
    private java.awt.Label username_textfield;
    // End of variables declaration//GEN-END:variables
}
