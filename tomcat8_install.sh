#!/bin/bash

# Create dedicated user for Tomcat
sudo adduser \
  --system \
  --shell /bin/bash \
  --gecos 'Tomcat Java Servlet and JSP engine' \
  --group \
  --disabled-password \
  --home /home/tomcat \
  tomcat

mkdir -p ~/tmp
cd ~/tmp
wget http://www.us.apache.org/dist/tomcat/tomcat-8/v8.5.13/bin/apache-tomcat-8.5.13.tar.gz
tar xvzf ./apache-tomcat-8.5.13.tar.gz
rm ./apache-tomcat-8.5.13.tar.gz
sudo mv ./apache-tomcat-8.5.13 /usr/share

# To make it easy to replace this release with future releases
# create symbolic link that we are going to use when referring to Tomcat
sudo rm -f /usr/share/tomcat
sudo ln -s /usr/share/apache-tomcat-8.5.13 /usr/share/tomcat

# Since tomcat user is created, he should also own all these files
sudo chown -R tomcat:tomcat /usr/share/tomcat/*
sudo chmod +x /usr/share/tomcat/bin/*.sh
