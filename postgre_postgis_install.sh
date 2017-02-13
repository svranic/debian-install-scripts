#!/bin/bash

# If the file doesn't exist create new file
# Pay attention to OS version (currently Jessie - 8)
cat > /etc/apt/sources.list.d/pgdg.list << FILE_CONTENT
deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
FILE_CONTENT

apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-9.5-postgis-2.2
apt-get install postgresql-9.5-pgrouting
apt-get install postgresql-plpython-9.5
apt-get install postgresql-plpython3-9.5

sudo -u postgres psql

echo 'CREATE EXTENSION postgis;'
echo 'SELECT postgis_full_version();'

echo 'CREATE EXTENSION pgrouting;'
echo 'SELECT pgr_version();'

echo 'CREATE EXTENSION plpython2u;'
echo 'CREATE EXTENSION plpython3u;'

echo 'CREATE LANGUAGE plpythonu;' # Default language plpythonu = plpython2u
echo 'CREATE LANGUAGE plpython3u;'

echo '\q'