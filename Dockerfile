FROM tomcat:9.0.76-jre11
COPY target/*.war /usr/local/tomcat/webapps/cohort7.war
CMD ["catalina.sh", "run"]
