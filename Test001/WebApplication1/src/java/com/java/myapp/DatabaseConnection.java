
package com.java.myapp;

import java.sql.Connection; 
import java.sql.DriverManager; 
import java.sql.SQLException; 
  
    // This class can be used to initialize the database connection 
public class DatabaseConnection {
    protected static Connection initializeDatabase() throws SQLException, ClassNotFoundException 
    { 
        // Initialize all the information regarding 
        // Database Connection 
        String dbDriver = "org.postgresql.Driver"; 
        String dbURL = "jdbc:postgresql://127.0.0.1:5432/"; 
        // Database name to access 
        String dbName = "dbstom"; 
        String dbUsername = "postgres"; 
        String dbPassword = "gomplayer"; 
  
        try{
            Class.forName(dbDriver);
        }catch(ClassNotFoundException e){
            System.out.println(e.getMessage());
        }
        //Class.forName(dbDriver); 
        Connection connect  = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
        //Connection con = DriverManager.getConnection(dbURL + dbName, 
        //                                             dbUsername,  
        //                                             dbPassword); 
        return connect; 
    } 
} 
