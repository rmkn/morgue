#!/bin/sh

service mysqld start
mysql -u root -e "GRANT ALL PRIVILEGES ON morgue.* TO morgue@localhost IDENTIFIED BY 'morgue_password';"
if [ $? -eq 0 ]; then
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "create database morgue;"
	mysql -u root -h localhost morgue < schemas/postmortems.sql
	mysql -u root -h localhost morgue < schemas/anniversary.sql
fi

exec "$@"
