#!/bin/sh

/root/iptables-setting.sh

service ntpd start
service mysqld start
service nginx start

if [ ! -d /var/lib/mysql/hrforecast ]; then
  /root/mysqld-setup.sh
fi

/usr/bin/supervisord
#perl /root/HRForecast/hrforecast.pl --config /root/HRForecast/config.pl
