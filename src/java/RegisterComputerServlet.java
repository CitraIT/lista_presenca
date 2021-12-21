package com.citrait.listapresenca;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.time.LocalDateTime;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;

public class RegisterComputerServlet extends HttpServlet{

    public void doPost(HttpServletRequest req, HttpServletResponse res)
        throws IOException,ServletException{

            Computer pc = new Computer();

            /* Computer Name */
            pc.setComputerName( req.getParameter("ComputerName") );
            
            /* Computer IP */
            if(req.getParameter("ComputerIP") == null || req.getParameter("ComputerIP") == "") {
                pc.setComputerIp( req.getRemoteAddr() );
            }else{
                pc.setComputerIp( req.getParameter("ComputerIP") );
            }
            
            /* Connected User */
            pc.setConnectedUser( req.getParameter("ConnectedUser") );
            
            /* Last income */
            DateTimeFormatter dtFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            pc.setLastIncome( LocalDateTime.ofInstant(Instant.now(), ZoneOffset.of("-03:00")).format(dtFormatter) );

            /* validation of user parameters */
            if(pc.getConnectedUser() == null) {
                pc.setConnectedUser("n/a");
            }


            String rootPath = getServletConfig().getServletContext().getRealPath("/");
            String filename = rootPath + "computers/" + pc.getComputerName() + ".txt";
            PrintWriter outfile = new PrintWriter(new FileWriter(filename));
            outfile.println("COMPUTERNAME="+pc.getComputerName());
            outfile.println("COMPUTERIP="+pc.getComputerIp());
            outfile.println("USER="+pc.getConnectedUser());
            outfile.println("LASTINCOME="+pc.getLastIncome());
            outfile.flush();
            outfile.close();

            res.setContentType("text/json");
            PrintWriter out = res.getWriter();
            out.print("{success: true}");
        }
}