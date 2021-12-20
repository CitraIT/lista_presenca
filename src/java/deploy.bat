@echo off
copy /Y *.class "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\app1\WEB-INF\classes\com\citrait\listapresenca"
del /q /s *.class >nul