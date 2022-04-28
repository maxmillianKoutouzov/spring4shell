# Vulnerable Tomcat version
FROM lunasec/tomcat-9.0.59-jdk11

LABEL name="spring4shell_poc"
LABEL version="1.0"
LABEL tag="spring4shell_app"

ADD src/ /spring4shell/src
ADD pom.xml /spring4shell

ENV CATALINA_OPTS="-Xms1024m -Xmx4096m -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=512m -Xss512k"

#  Build spring app
RUN apt update && apt install maven -y
WORKDIR /spring4shell/
# Put flag in app working directory
RUN echo "{<!!W000H00000!!>}" >> /spring4shell/flag.txt
RUN mvn package

#  Deploy to tomcat
RUN mv target/spring4shell-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

ENTRYPOINT [ "sh", "-c", "java -jar /usr/local/tomcat/webapps/spring4shell-0.0.1-SNAPSHOT.war"]
EXPOSE 8080
CMD ["catalina.sh", "run"]
