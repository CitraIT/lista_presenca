@echo off



:: delete old classes 
del /q /s ..\..\ListaPresenca\WEB-INF\classes\com\citrait\listapresenca\*.*

:: Copy classes files
copy /Y *.class "..\..\ListaPresenca\WEB-INF\classes\com\citrait\listapresenca\"

:: Copy file to tomcat webapps folder
copy /Y *.class "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\app1\WEB-INF\classes\com\citrait\listapresenca"
copy .\lib\*.* "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\app1\WEB-INF\lib\"

:: .jsp files
copy ..\..\ListaPresenca\*.jsp "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\app1\"

:: web.xml deployment
copy ..\..\ListaPresenca\WEB-INF\web.xml "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\app1\WEB-INF\"


:: local build folder cleanup
del /q /s *.class >nul