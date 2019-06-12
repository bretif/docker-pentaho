# description

Launch pentaho 8.2 with postgresql configured as repository

# Quick start

You need to start postgres

```
docker run -d --name db \
    -p 5432:5432 \
    postgres:10-alpine
```

Then start pentaho

```
docker run -d --name pentaho \
    -p 8080:8080 \
    -e PGHOST=localhost \
    -e PGPORT=5432 \
    -e PGDATABASE=postgres \
    -e PGUSER=pgadmin \
    -e PGPASSWORD=<secret> \
    bretif/pentaho:8.2
```

Then you can access pentaho on [http://locahost:8080](http://locahost:8080)

# Configuration


## Variables
- PGHOST
- PGPORT
- PGDATABASE
- PGUSER
- PGPASSWORD

## Behind a Proxy / HTTPS

If pentaho is behind a reverse proxy for https, make sure the file `/opt/pentaho/pentaho-server/tomcat/conf/server.xml` look like this : 

```
    <Connector URIEncoding="UTF-8" port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               scheme="https"
               proxyPort="443"
               secure="true"
               redirectPort="443" />

```


# TODO

A lot of thing

- User docker-entrypoint with run-parts
- Remove by default test user
- postgres optional parameter
- different user / password per db
- Manage URL / host
- Merge with [https://github.com/zhicwu/docker-biserver-ce](https://github.com/zhicwu/docker-biserver-ce) as really more clean/powerfull
- ...
