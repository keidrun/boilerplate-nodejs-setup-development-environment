#!/bin/bash

##### DATABASE #####
# wait for db to come up
while ! nc -z db 3306 ; do
    sleep 10;
    echo "db not up yet...."
done

# setup database

echo "create database"
mysql -h db -u root -proot -e "CREATE DATABASE IF NOT EXISTS testdb;"
mysql -h db -u root -proot -e "GRANT SELECT, INSERT, UPDATE, DELETE,EXECUTE, ALTER, CREATE, DROP, CREATE, CREATE ROUTINE ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -h db -u root -proot -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -h db -u root -proot -e "GRANT SELECT, INSERT, UPDATE, DELETE,EXECUTE, ALTER, CREATE, DROP, CREATE, CREATE ROUTINE ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -h db -u root -proot -e "GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;"

# upgrade schema to latest version
echo "update testdb database"
pushd ./database
    db-migrate up
popd

##### WEB #####
# install npm modules
cd /srv
npm install

# start website process
# TODO: Add debugging process
pm2 start /srv/server.js --watch=true &

# dont let container end
echo "run container"
while true; do sleep 10000; done
