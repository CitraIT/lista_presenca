@echo off


:: Java compiler path
set javac="C:\Program Files\Java\jdk1.8.0_202\bin\javac.exe"

:: Necessary external library files
set classpath=".;./lib/servlet-api.jar;./lib/lombok.jar;./lib/sqlite-jdbc-3.36.0.3.jar"

:: Compiling
%javac% -cp %classpath% Computer.java RegisterComputerServlet.java DatabaseFactory.java ComputerDAO.java

:: 