package com.citrait.listapresenca;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ComputerDAO extends Computer{
    

    /* ADD'S A NEW COMPUTERS */
    public void add(Computer pc){
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "insert into computers(computer_name, computer_ip, connected_user, anydesk_id, last_income) values (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, pc.getComputerName());
            stmt.setString(2, pc.getComputerIp());
            stmt.setString(3, pc.getConnectedUser());
            stmt.setString(4, pc.getAnydeskID());
            stmt.setString(5, pc.getLastIncome());
            stmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }


    /* UPDATES AN EXISTING COMPUTER */
    public void update(Computer pc){
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "update computers set computer_ip=?, connected_user=?, last_income=?, anydesk_id=? where computer_name=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, pc.getComputerIp());
            stmt.setString(2, pc.getConnectedUser());
            stmt.setString(3, pc.getLastIncome());
            stmt.setString(4, pc.getAnydeskID());
            stmt.setString(5, pc.getComputerName());
            stmt.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }

    }


    /* QUERIES ALL COMPUTERS */
    public List<Computer> all(){
        List<Computer> allComputers = new ArrayList<Computer>();
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "Select * From computers";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                Computer computer = new Computer();
                computer.setComputerName(rs.getString("computer_name"));
                computer.setComputerIp(rs.getString("computer_ip"));
                computer.setConnectedUser(rs.getString("connected_user"));
                computer.setAnydeskID(rs.getString("anydesk_id"));
                computer.setLastIncome(rs.getString("last_income"));
                allComputers.add(computer);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }

        return allComputers;
    }



    /* QUERIES COMPUTERS BY ITS COMPUTERNAME */
    public Computer findByComputerName(String computerName){
        Computer pc = new Computer();
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "Select * From computers Where computer_name Like ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, computerName);
            ResultSet rs = stmt.executeQuery(query);
            rs.last();
            int rowsCount = rs.getRow();
            rs.beforeFirst();
            if(rowsCount < 1){
                pc =  null;
            }else if(rowsCount == 1){
                rs.first();
                pc.setComputerName(rs.getString("computer_name"));
                pc.setComputerIp(rs.getString("computer_ip"));
                pc.setConnectedUser(rs.getString("connected_user"));
                pc.setAnydeskID(rs.getString("anydesk_id"));
                pc.setLastIncome(rs.getString("last_income"));
                
            }
        }catch(SQLException e){
            e.printStackTrace();
        }

        return pc;
        
    }


    /* CHECK IF A CERTAIN COMPUTER EXISTS IN DATABASE */
    public Boolean exists(String computerName){
        Boolean found = false;
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "Select Count(*) From computers Where computer_name = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, computerName);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            int resultCount = rs.getInt(1);
            if(resultCount > 0){
                found = true;
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }

        return found;
        
    }


    /* QUERIES COMPUTERS BY ITS CONNECTED USER */
    public List<Computer> findByConnectedUser(String connectedUser){
        List<Computer> userComputers = new ArrayList<Computer>();
        try{
            Connection conn = DatabaseFactory.getConnection();
            String query = "Select * From computers Where connected_user LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, connectedUser);
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                Computer computer = new Computer();
                computer.setComputerName(rs.getString("computer_name"));
                computer.setComputerIp(rs.getString("computer_ip"));
                computer.setConnectedUser(rs.getString("connected_user"));
                computer.setAnydeskID(rs.getString("anydesk_id"));
                computer.setLastIncome(rs.getString("last_income"));
                userComputers.add(computer);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }

        return userComputers;
        

    }


}
