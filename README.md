docker-hrforecast
=================

Dockerfile of hrforecast.

How to using?
-------------

```
> vagrant up --provision
> open http://192.168.33.100/
```

Mount with host
---------------

```
> docker run -p 80:80 -v /var/host/mysql:/var/lib/mysql -d ${CONTAINER_ID} 
```

LICENSE
-------

[Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/futoase/docker-hrforecast/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

