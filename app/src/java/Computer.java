package com.citrait.listapresenca;
import java.io.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import lombok.Data;
import javax.servlet.http.HttpServletRequest;


public @Data class Computer{
    String computerName;
    String computerIp;
    String connectedUser;
    String AnydeskID;
    String lastIncome;


    /* LOADS A COMPUTER FROM POST REQUEST DATA */
    public void loadFromServletRequest(HttpServletRequest req){
        /* Computer Name */
        this.setComputerName(req.getParameter("ComputerName"));
        
        /* Computer IP */
        this.setComputerIp(req.getParameter("ComputerIP"));
        
        /* Connected User */
        this.setConnectedUser(req.getParameter("ConnectedUser"));

        /* Anydesk ID */
        this.setAnydeskID(req.getParameter("AnydeskID"));

        /* Last Income */
        DateTimeFormatter dtFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        this.setLastIncome( LocalDateTime.ofInstant(Instant.now(), ZoneOffset.of("-03:00")).format(dtFormatter) );

    }

}