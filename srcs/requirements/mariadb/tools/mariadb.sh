#!/bin/bash

echo "[.] Starting MySQL Service"
service mysql start

echo "[.] Writing MySQL Instructions"
cat << EOF > mariadb.sql
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DATABASE_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER IF NOT EXISTS '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_USER_PASSWORD';
GRANT ALL ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DATABASE_USER_PASSWORD';
FLUSH PRIVILEGES;
USE $DATABASE_NAME;
CREATE TABLE info (name VARCHAR(255), level INT);
INSERT INTO info (name, level) VALUES ('amait-ou', 6);
EOF

echo "[.] Running MySQL Instructions ..."
mysql -u root < mariadb.sql

echo "[.] Stoping MySQL Service ..."
service mysql stop

echo "[.] Running MySQL Daemon ..."
exec $@
