docker-hrforecast
=================

Dockerfile of hrforecast.

How to running of hrforecast?
-----------------------------

This docker image registered on docker index.
If you need running in your machine on the docker daemon, then you must be execute command to below.

```
> docker run -p 80:80 -d futoase/docker-hrforecast
```

If you need save datum of hrforecast on docker host, must be add option volumen '-v'.

```
> docker run -p 80:80 -v /var/hrforecast/mysql:/var/lib/mysql -d futoase/docker-hrforecast
```

## set time zone to docker container

- set timezone for the tokyo

```
> docker run -p 80:80 -i -t -e TIME_ZONE=tokyo futoase/hrforecast /bin/bash
# date
# Fri Apr 11 12:24:46 JST 2014
```

How to development?
-------------------

## build the docker image

```
> vagrant up --provision
> vagrant ssh
> cd /vagrant
> docker build .
```

LICENSE
-------

[Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/futoase/docker-hrforecast/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
