package com.citrait.listapresenca;
import java.io.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DatabaseFactory {

    public static Connection conn = null;
    public static String DatabaseLocation;

    /* MAKE THE DATABASE CONNECTINO AVAILABLE */
    public static Connection getConnection() throws SQLException {
        if(conn == null){
            try{
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:"+DatabaseLocation);
            }catch(SQLException e){
                e.printStackTrace();
            }catch(ClassNotFoundException e){
                e.printStackTrace();
            }
        }
        
        return conn;
    }


    /* CREATING THE DATABASE */
    public static void createDatabase(String PathToDB, String DefaultAdminPassword) throws SQLException{
        Connection conn = null;
        DatabaseLocation = PathToDB;
        //DatabaseLocation = ":memory:";
        try{
            conn = getConnection();
            Statement stmt = conn.createStatement();
            
            /* CREATE TABLES */
            // stmt.execute("create table users(username TEXT, password TEXT)");
            // stmt.execute("create table computers(computer_name TEXT, connected_user TEXT, computer_ip TEXT, anydesk_id TEXT, last_income TEXT)");

            /* INSERT DEFAULT DATA */
            // PreparedStatement pstmt = conn.prepareStatement("insert into users(username, password) values('admin', ?)");
            // pstmt.setString(1, DefaultAdminPassword);
            // pstmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    
}
