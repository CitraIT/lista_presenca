package com.citrait.listapresenca;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.time.LocalDateTime;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class RegisterComputerServlet extends HttpServlet{
    
    public void init(){
        
        /* LOAD INIT PARAMS */
        ServletConfig config = getServletConfig();
        String DefaultAdminPassword = getServletContext().getInitParameter("DefaultAdminPassword");
        String DatabaseName = getServletContext().getInitParameter("DatabaseName");

        /* GET ROOT PHYSICAL PATH OF THIS PROJECT */
        String thisAppRootPath = getServletContext().getRealPath("/");
        String DatabaseLocation = thisAppRootPath.replace("\\", "/") +  DatabaseName;

        /* CREATING THE DATABASE */
        try{
            DatabaseFactory.createDatabase(DatabaseLocation, DefaultAdminPassword);
           
        }catch(SQLException e){
            e.printStackTrace();
        }

        

    }

    /* REGISTERS A COMPUTER */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
        throws IOException,ServletException{

            Computer pc = new Computer();
            pc.loadFromServletRequest(req);

            /* validate some fields */
            if(pc.getComputerName() == "" || pc.getComputerName() == null){
                res.setContentType("text/json");
                PrintWriter out = res.getWriter();
                out.print("{success: false, reason: 'empty computer name'}");
                return;
            }

            ComputerDAO computerDAO = new ComputerDAO();
            if(computerDAO.exists(pc.getComputerName())){
                computerDAO.update(pc);
            }else{
                computerDAO.add(pc);
            }


            res.setContentType("text/json");
            PrintWriter out = res.getWriter();
            out.print("{success: true}");
        }
}