#FROM tomcat:9.0.76-jre11
#COPY target/*.war /usr/local/tomcat/webapps/cohort7.war
#CMD ["catalina.sh", "run"]

FROM maven:3-jdk-11 as builder
# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build
#Download all required dependencies into one layer
RUN mvn -B dependency:resolve dependency:resolve-plugins
#Copy source code
COPY src /build/src
# Build application
RUN mvn package
