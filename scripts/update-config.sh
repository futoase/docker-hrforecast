#!/bin/sh

cd /home/hrforecast/HRForecast
sed -i -e "s/username => ''/username => 'hrforecast'/g" config.pl
sed -i -e "s/password => ''/password => 'hrforecast'/g" config.pl
sed -i -e "s/front_proxy => \[\]/front_proxy => \['127.0.0.1'\]/g" config.pl

