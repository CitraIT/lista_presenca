package com.citrait.listapresenca;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class ListComputersServlet extends HttpServlet{

    public void doGet(HttpServletRequest req, HttpServletResponse res)
        throws IOException,ServletException{

            String rootPath = getServletConfig().getServletContext().getRealPath("/");

            File computersDirectory = new File(rootPath + "/computers");
            File[] computersFiles = computersDirectory.listFiles();
            List<Computer> RegisteredComputers = new ArrayList<Computer>();

            for(File computerFile : computersFiles){
                Computer pc = new Computer();
                BufferedReader in = new BufferedReader(new FileReader(computerFile));
                String line;
                while((line = in.readLine())!=null){
                    String[] computerAttribute = line.split("=");
                    switch(computerAttribute[0]){
                        case "COMPUTERNAME":
                            pc.setComputerName(computerAttribute[1]);
                            break;
                        case "COMPUTERIP":
                            pc.setComputerIp(computerAttribute[1]);
                            break;
                        case "USER":
                            pc.setConnectedUser(computerAttribute[1]);
                            break;
                        case "LASTINCOME":
                            pc.setLastIncome(computerAttribute[1]);
                            break;
                        default:
                            break;
                    }
                }
                
                RegisteredComputers.add(pc);
  
            }

            ServletContext ctx = getServletContext();
            RequestDispatcher rd = ctx.getRequestDispatcher("/list.jsp");
            req.setAttribute("RegisteredComputers", RegisteredComputers);
            rd.forward(req, res);

        }
}