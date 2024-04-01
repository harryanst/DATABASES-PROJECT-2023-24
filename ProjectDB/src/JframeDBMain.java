package projectdb;

import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.util.*;

public class JframeDBMain extends javax.swing.JFrame {

    public JframeDBMain() {
        initComponents();
        // Load the table names in the list
        loadTableNames();
        // set default action of X button to be the same as the logout button
        setDefaultCloseOperation(javax.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                cleanup(evt);
            }
        });
        
        // Button settings initialization
        insert_button.setEnabled(false);
        update_button.setEnabled(false);
        delete_button.setEnabled(false);
        insert_label.setVisible(false);
        text_data.setEnabled(false);
        update_data.setEnabled(false);
    }
    
    // Table clicked on
    private String tableName;
    // Data for row clicked on
    private Object[] specificRowData;
    // Mapping between column names and column values
    private Map<String, Object> selectedRowData = new HashMap<>();

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane2 = new javax.swing.JScrollPane();
        table_list = new javax.swing.JList<>();
        logout_button = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        main_table = new javax.swing.JTable();
        delete_button = new javax.swing.JButton();
        update_button = new javax.swing.JButton();
        insert_button = new javax.swing.JButton();
        insert_label = new javax.swing.JLabel();
        text_data = new javax.swing.JTextField();
        update_data = new javax.swing.JTextField();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        table_list.setBackground(new java.awt.Color(204, 204, 204));
        table_list.setFont(new java.awt.Font("Segoe UI", 0, 24)); // NOI18N

        table_list.addListSelectionListener(new javax.swing.event.ListSelectionListener() {
            public void valueChanged(javax.swing.event.ListSelectionEvent evt) {
                table_listValueChanged(evt);
            }
        });
        jScrollPane2.setViewportView(table_list);

        logout_button.setBackground(new java.awt.Color(255, 0, 51));
        logout_button.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        logout_button.setForeground(new java.awt.Color(255, 255, 255));
        logout_button.setText("Logout");
        logout_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                logout_buttonActionPerformed(evt);
            }
        });

        main_table.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {},
                {},
                {},
                {}
            },
            new String [] {

            }
        ));
        main_table.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                main_tableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(main_table);

        delete_button.setBackground(new java.awt.Color(255, 204, 51));
        delete_button.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        delete_button.setText("Delete");
        delete_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                delete_buttonActionPerformed(evt);
            }
        });

        update_button.setBackground(new java.awt.Color(255, 204, 51));
        update_button.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        update_button.setText("Update");
        update_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                update_buttonActionPerformed(evt);
            }
        });

        insert_button.setBackground(new java.awt.Color(255, 204, 51));
        insert_button.setFont(new java.awt.Font("Segoe UI", 0, 18)); // NOI18N
        insert_button.setText("Add");
        insert_button.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                insert_buttonActionPerformed(evt);
            }
        });

        insert_label.setText("Type data separated with commas and hit enter");

        text_data.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                text_dataActionPerformed(evt);
            }
        });

        update_data.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                update_dataActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 230, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(insert_button, javax.swing.GroupLayout.PREFERRED_SIZE, 129, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(text_data, javax.swing.GroupLayout.PREFERRED_SIZE, 170, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(update_button, javax.swing.GroupLayout.PREFERRED_SIZE, 129, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(update_data, javax.swing.GroupLayout.PREFERRED_SIZE, 170, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(delete_button, javax.swing.GroupLayout.PREFERRED_SIZE, 129, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 36, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(insert_label)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(logout_button, javax.swing.GroupLayout.PREFERRED_SIZE, 129, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 504, Short.MAX_VALUE)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(text_data, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(insert_button, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(update_button, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(update_data, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(delete_button, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(insert_label, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(logout_button, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    // Action for the logout button
    private void logout_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_logout_buttonActionPerformed
        // Logout
        deleteFromActiveAdmin();
        System.out.println("Deleted user from active_admin");

        // Disconnect from the database
        ConnectionDB.disconnectDB();
        System.out.println("Disconnected from the database");

        // Close the window
        dispose();
    }//GEN-LAST:event_logout_buttonActionPerformed

    // Action for when a table name from the list is clicked
    private void table_listValueChanged(javax.swing.event.ListSelectionEvent evt) {//GEN-FIRST:event_table_listValueChanged
    // Get the name of the table clicked on
    String selectedTableName = (String) table_list.getSelectedValue();
    
    // Save that name in a class variable used later
    tableName = selectedTableName;

        // Create a temporary table model
        DefaultTableModel tableModel = new DefaultTableModel();

        // Add columns to the table model
        List<String> columnsList = getColumnsForTable(selectedTableName);
        for (String column : columnsList) {
            tableModel.addColumn(column);
        }

        // Load the data in the temporary table
        List<List<Object>> data = getDataForTable(selectedTableName);
        for (List<Object> row : data) {
            tableModel.addRow(row.toArray());
        }

        // Clear existing columns and rows from main_table
        DefaultTableModel existingModel = (DefaultTableModel) main_table.getModel();
        existingModel.setColumnCount(0);
        existingModel.setRowCount(0);

        // Load the data of the temporary table model to the main table
        main_table.setModel(tableModel);
        // Activate the insert button
        insert_button.setEnabled(true);
    }//GEN-LAST:event_table_listValueChanged

    // Action for the delete button
    private void delete_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_delete_buttonActionPerformed
        try {

            // Check if there is a selected row
            if (!selectedRowData.isEmpty()) {
                // Get the selected table name from the JList
                String selectedTableName = (String) table_list.getSelectedValue();

                // Build a string for the MySQL where clause
                StringBuilder whereClause = new StringBuilder();

                // Iterate through stored data to build the WHERE clause
                for (Map.Entry<String, Object> entry : selectedRowData.entrySet()) {
                    String columnName = entry.getKey();
                    Object storedValue = entry.getValue();

                    if (whereClause.length() > 0) {
                        whereClause.append(" AND ");
                    }

                    whereClause.append(columnName).append(" = '").append(storedValue).append("'");
                }

                // Create and run the delete MySQL command
                String deleteQuery = "DELETE FROM " + selectedTableName + " WHERE " + whereClause.toString();
                Statement statement = ConnectionDB.connection.createStatement();
                statement.executeUpdate(deleteQuery);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_delete_buttonActionPerformed

    // Action for the add button
    private void insert_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_insert_buttonActionPerformed
        insert_label.setVisible(true);
        update_data.setEnabled(false);
        text_data.setVisible(true);
        text_data.setEnabled(true);
    }//GEN-LAST:event_insert_buttonActionPerformed

    // Action for the update button
    private void update_buttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_update_buttonActionPerformed
        insert_label.setVisible(true);
        text_data.setEnabled(false);
        update_data.setVisible(true);
        update_data.setEnabled(true);
    }//GEN-LAST:event_update_buttonActionPerformed
   
    // Action for when a row of the table is clicked
    private void main_tableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_main_tableMouseClicked
        // Activate the buttons
        update_button.setEnabled(true);
        delete_button.setEnabled(true);
        int selectedRow = main_table.getSelectedRow();

        // Store the data here
        specificRowData = new Object[main_table.getColumnCount()];

        for (int i = 0; i < main_table.getColumnCount(); i++) {
            specificRowData[i] = main_table.getValueAt(selectedRow, i);
        }

        DefaultTableModel model = (DefaultTableModel) main_table.getModel();

        // Iterate through columns to get column names and values
        for (int i = 0; i < model.getColumnCount(); i++) {
            String columnName = model.getColumnName(i);
            Object columnValue = model.getValueAt(selectedRow, i);

            // Store the data in the map
            selectedRowData.put(columnName, columnValue);
        }
    }//GEN-LAST:event_main_tableMouseClicked
    
    // Text field action for the insertion of data
    private void text_dataActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_text_dataActionPerformed
        try {
            // Get the table name from the selected item in table_list
            String selectedTableName = (String) table_list.getSelectedValue();

            // Get the values from the text_data field
            String textData = text_data.getText();
            String[] values = textData.split(",\\s*");

            if (values.length > 0) {
                String insertQuery = "INSERT INTO " + selectedTableName + " VALUES (" + String.join(", ", values) + ")";
                Statement statement = ConnectionDB.connection.createStatement();
                statement.executeUpdate(insertQuery);

                // Reset the text field
                text_data.setText("");

            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exception or any other runtime exception, e.g., show an error message
        }
    }//GEN-LAST:event_text_dataActionPerformed

    // Text field action for the update of data
    private void update_dataActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_update_dataActionPerformed
        try {
            // Get the table name from the selected item in table_list
            String selectedTableName = (String) table_list.getSelectedValue();

            // Get the new values from the update_data field
            String updateData = update_data.getText();
            String[] newValues = updateData.split(",\\s*");

            // Build the MySQL command
            if (newValues.length > 0) {
                StringBuilder updateQuery = new StringBuilder("UPDATE " + selectedTableName + " SET ");
                for (int i = 0; i < main_table.getColumnCount(); i++) {
                    updateQuery.append(main_table.getColumnName(i)).append(" = ?");
                    if (i < main_table.getColumnCount() - 1) {
                        updateQuery.append(", ");
                    }
                }
                updateQuery.append(" WHERE ");
                for (int i = 0; i < main_table.getColumnCount(); i++) {
                    updateQuery.append(main_table.getColumnName(i)).append(" = ?");
                    if (i < main_table.getColumnCount() - 1) {
                        updateQuery.append(" AND ");
                    }
                }

                PreparedStatement preparedStatement = ConnectionDB.connection.prepareStatement(updateQuery.toString());

                // Set the new values
                for (int i = 0; i < newValues.length; i++) {
                    preparedStatement.setObject(i + 1, newValues[i]);
                }

                // Set values for WHERE clause
                for (int i = 0; i < specificRowData.length; i++) {
                    preparedStatement.setObject(newValues.length + i + 1, specificRowData[i]);
                }

                // Execute the update
                preparedStatement.executeUpdate();

                // Reset the text field
                update_data.setText("");
                preparedStatement.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_update_dataActionPerformed
    
    // Delete the user from active admin table
    private void deleteFromActiveAdmin() {
        try {
        String query = "DELETE FROM active_admin";
        PreparedStatement preparedStatement = ConnectionDB.connection.prepareStatement(query);
        preparedStatement.executeUpdate();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    
    }
    
    // Load the table names in the list
    private void loadTableNames() {
        // Here the names will be stored
        DefaultListModel<String> listModel = new DefaultListModel<String>();

        try {
            // Get the table names from the database
           DatabaseMetaData metaData = ConnectionDB.connection.getMetaData();
           ResultSet resultSet = metaData.getTables("etaireia_aksiologisis", "null", "%", new String[]{"TABLE"});

              // Load the tables names on the list model
            while (resultSet.next()) {
                String tableName = resultSet.getString("TABLE_NAME");
                listModel.addElement(tableName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // load the list model on the visual list component
        table_list.setModel(listModel);
    }
    
    // X button cleanup
    private void cleanup(java.awt.event.WindowEvent evt) {
            deleteFromActiveAdmin();
            System.out.println("Deleted user from active_admin");
            ConnectionDB.disconnectDB();
            System.out.println("Disconnected from the database");
            dispose();
        }
    
    // Retrieve the names of the columns for each table
    private List<String> getColumnsForTable(String tableName) {
        List<String> columnNames = new ArrayList<>();

        try {
            DatabaseMetaData metaData = ConnectionDB.connection.getMetaData();
            ResultSet resultSet = metaData.getColumns("etaireia_aksiologisis", null, tableName, "%");

            while (resultSet.next()) {
                String columnName = resultSet.getString("COLUMN_NAME");
                columnNames.add(columnName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return columnNames;
    }

    // Retrieve the data of each row for given table
    private List<List<Object>> getDataForTable(String tableName) {
        List<List<Object>> data = new ArrayList<>();

        try {
            Statement statement = ConnectionDB.connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM " + tableName);
            ResultSetMetaData metaData = resultSet.getMetaData();
            
            int columnCount = metaData.getColumnCount();

            while (resultSet.next()) {
                List<Object> rowData = new ArrayList<>();
                for (int i = 1; i <= columnCount; i++) {
                    Object value = resultSet.getObject(i);
                    rowData.add(value);
                }
                data.add(rowData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return data;
    }
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton delete_button;
    private javax.swing.JButton insert_button;
    private javax.swing.JLabel insert_label;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JButton logout_button;
    private javax.swing.JTable main_table;
    private javax.swing.JList<String> table_list;
    private javax.swing.JTextField text_data;
    private javax.swing.JButton update_button;
    private javax.swing.JTextField update_data;
    // End of variables declaration//GEN-END:variables
}
