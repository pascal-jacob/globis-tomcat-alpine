FROM amazoncorretto:15-alpine-jdk

LABEL maintainer="Pascal Jacob <pascal.jacob@globis-software.com>"

# Environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION_MAJOR 9
ENV TOMCAT_VERSION_FULL 9.0.43

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

# Install Tomcat
RUN mkdir $CATALINA_HOME && \
wget -O $CATALINA_HOME/apache-tomcat.tar.gz http://www-us.apache.org/dist/tomcat/tomcat-$TOMCAT_VERSION_MAJOR/v$TOMCAT_VERSION_FULL/bin/apache-tomcat-$TOMCAT_VERSION_FULL.tar.gz && \
tar -zxvf $CATALINA_HOME/apache-tomcat.tar.gz -C $CATALINA_HOME --strip-components=1

# Copy Tomcat files
COPY tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml
COPY catalina-context.xml $CATALINA_HOME/conf/context.xml
COPY context.xml $CATALINA_HOME/webapps/manager/META-INF/context.xml
COPY globis-online#uploads.xml $CATALINA_HOME/conf/Catalina/localhost/globis-online#uploads.xml

WORKDIR $CATALINA_HOME
EXPOSE 8080
CMD ["catalina.sh", "run"]