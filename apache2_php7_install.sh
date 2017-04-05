#!/bin/bash

debianVersion='jessie'

# Check to see if there are any updates of OS
apt-get update

# Install apache2 latest version
# Default document root location /var/www
# Main configuration file /etc/apache2/apache2.conf
# Additional conf in /etc/apache2 such as /etc/apache2/mods-enabled (Apache modules)
# /etc/apache2/sites-enabled (virtual hosts) and /etc/apache2/conf-enabled
apt-get -y install apache2

#Additional repository for Debian (Containts PHP 7.0.13. for Debian Jessie)
# Add repository
echo '' >> /etc/apt/sources.list
echo "#PHP7 repository" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org $debianVersion all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org $debianVersion all" >> /etc/apt/sources.list

cd /tmp
wget https://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
#rm dotdeb.gpg

apt-get update
apt-get install php7.0

# Install PHP extensions which are not installed by default
apt-get -y install php-mysqli
apt-get -y install php-pgsql
apt-get -y install php-sqlite3

# Check versions
# If running apachectl from shell needs to be root or use sudo
apachectl -V
php -v

# Restart Apache in order for changes to take effect
service apache2 restart

#Test PHP installation
cat > /var/www/html/info.php << FILE_CONTENT
<?php
    phpinfo();
?>
FILE_CONTENT
