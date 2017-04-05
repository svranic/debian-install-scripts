#!/bin/bash

debianVersion='jessie'
pgVersion=9.6
postgisVersion=2.3

# If the file doesn't exist create new file
# Pay attention to OS version (currently Jessie - 8)
cat > /etc/apt/sources.list.d/pgdg.list << FILE_CONTENT
deb http://apt.postgresql.org/pub/repos/apt/ $debianVersion-pgdg main
FILE_CONTENT

apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get install postgresql-9.6
apt-get install postgresql-contrib-9.6 postgresql-9.6-postgis-2.3
apt-get install postgresql-9.6-pgrouting
#apt-get install postgresql-9.6-plpython
#apt-get install postgresql-9.6-plpython3

sudo -u postgres psql

echo 'CREATE EXTENSION adminpack;'

echo 'CREATE DATABASE gisdb;'
echo '\connect gisdb;'
echo 'CREATE SCHEMA postgis;'
echo 'ALTER DATABASE gisdb SET search_path=public, postgis, contrib;'
echo '\connect gisdb;' # -- this is to force new search path to take effect
echo 'CREATE EXTENSION postgis SCHEMA postgis';

echo 'CREATE EXTENSION postgis_sfcgal SCHEMA postgis;'
echo 'SELECT postgis_full_version();'

echo 'CREATE EXTENSION pgrouting SCHEMA postgis;'
echo 'SELECT pgr_version();'

#echo 'CREATE EXTENSION plpython2u SCHEMA postgis;'
#echo 'CREATE EXTENSION plpython3u SCHEMA postgis;'

echo 'CREATE LANGUAGE plpythonu;' # Default language plpythonu = plpython2u
echo 'CREATE LANGUAGE plpython3u;'

# Allow acces from external
echo "ALTER SYSTEM SET listen_addresses='*';"

#Change manually and restart PostgreSQL server sudo service postgresql restart 
# sudo nano /etc/postgresql/9.6/main/pg_hba.conf
# hostssl    all             all             0.0.0.0/0               md5

echo '\q'
