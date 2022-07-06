FROM tomcat:9.0-jdk8

RUN rm -rf /usr/local/tomcat/webapps/*

# note: place pcws.war in this directory for building image
ADD pcws.war /usr/local/tomcat/webapps/ROOT.war