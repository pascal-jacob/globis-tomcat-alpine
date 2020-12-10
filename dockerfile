FROM tomcat:9-jre8-alpine

LABEL maintainer="Pascal Jacob <pascal.jacob@globis-software.com>"

# Set Java parameters
ENV JAVA_OPTS="-Xmx4g -XX:+UseG1GC -XX:+DisableExplicitGC"

# Expose ports
EXPOSE 1099

# Create shared folder
RUN mkdir /opt/servoy-uploads
RUN chmod 777 /opt/servoy-uploads

# To install missing fonts, otherwise datastream plugin will throw errors.
RUN apk add --update ttf-dejavu

# Set timezone
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime

# Copy Tomcat files
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY catalina-context.xml /usr/local/tomcat/conf/context.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY globis-online#uploads.xml /usr/local/tomcat/conf/Catalina/localhost/globis-online#uploads.xml
