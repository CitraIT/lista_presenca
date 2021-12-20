@echo off

set javac="C:\Program Files\Java\jdk1.8.0_202\bin\javac.exe"
set classpath="servlet-api.jar;log4j-api-2.12.2.jar;lombok.jar"
rem :

%javac% -cp %classpath% Computer.java RegisterComputerServlet.java  ListComputersServlet.java