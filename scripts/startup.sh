#!/bin/sh

service ntpd start
service mysqld start
service nginx start

if [ ! -d /var/lib/mysql/hrforecast ]; then
  /home/hrforecast/scripts/mysqld-setup.sh
fi

/usr/bin/supervisord
