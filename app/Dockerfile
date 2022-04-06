FROM tomcat:9.0
MAINTAINER luciano@citrait.com.br

# Copiando a pasta jsp com a estrutura raiz do projeto
COPY listapresenca/ /usr/local/tomcat/webapps/ROOT


# Compilando as classes
COPY src/java /usr/local/src/app
WORKDIR /usr/local/src/app
ENV classpath=".:./lib/servlet-api.jar:./lib/lombok.jar:./lib/sqlite-jdbc-3.36.0.3.jar"
RUN javac -cp $classpath Computer.java RegisterComputerServlet.java DatabaseFactory.java ComputerDAO.java


# Copiando as classes compiladas para a pasta de classes do tomcat
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/com/citrait/listapresenca
RUN cp *.class /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/com/citrait/listapresenca

# Copiando as bibliotecas externas
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/lib
RUN cp lib/* /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/



EXPOSE 8080
CMD ["catalina.sh", "run"]
