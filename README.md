## This docker image runs Tomcat 9 with Java 8 JRE on Alpine Linux, ready to deploy a WAR file with the Globis Software application.

First, create a folder on the docker host to share files with the container:

sudo mkdir -p /mnt/docker/[container-name]/uploads

To spin up a container use the following run command:

docker run --restart always -v /mnt/docker/[container-name]:/opt/servoy-uploads -p [port]:8080 -e JAVA_OPTS='-Xmx[memory]g -XX:+UseG1GC -XX:+DisableExplicitGC' --name [container-name] -d d4rkf1r3fly/tomcat-9-jre8-alpine

Use this link to test your setup: http://localhost:[port]

Initial login - pwd: globisadmin - Docker4Globis.
To use your own credentials, update tomcat-users.xml file.

WARNING: Do not use this image in a production environment, this is for testing purposes only!

For more information about the Globis Software company, please visit https://globis-software.com/