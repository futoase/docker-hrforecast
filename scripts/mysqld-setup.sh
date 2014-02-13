#!/bin/sh

service mysqld start

chkconfig --level 2345 mysqld on
mysqladmin -h localhost -u root create hrforecast
sleep 10;

cd /home/hrforecast/HRForecast && mysql -h localhost -u root hrforecast < schema.sql
sleep 10;

mysql -u root -e "GRANT CREATE, ALTER, DELETE, INSERT, UPDATE, SELECT ON hrforecast.* TO 'hrforecast'@'localhost' IDENTIFIED BY 'hrforecast';"
