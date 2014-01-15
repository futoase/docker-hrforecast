#!/bin/sh

/root/iptables-setting.sh

service sshd start
service mysqld start
service nginx start

perl /root/HRForecast/hrforecast.pl --config /root/HRForecast/config.pl
