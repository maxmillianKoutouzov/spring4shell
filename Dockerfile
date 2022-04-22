# Vulnerable Tomcat version
FROM lunasec/tomcat-9.0.59-jdk11

ADD src/ /spring4shell/src
ADD pom.xml /spring4shell

#  Build spring app
RUN apt update && apt install maven -y
WORKDIR /spring4shell/
RUN mvn clean package

#  Deploy to tomcat
RUN mv target/spring4shell-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/

# Put flag in app working directory
RUN mv flag.txt /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
