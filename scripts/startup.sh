#!/bin/sh

service ntpd start
service mysqld start
service nginx start
service sshd start

if [ ! -d /var/lib/mysql/hrforecast ]; then
  /home/hrforecast/scripts/mysqld-setup.sh
fi

/home/hrforecast/scripts/timezone.sh
/usr/bin/supervisord
