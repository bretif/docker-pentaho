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
    -e PGPORT=5432 \
    -e PGDATABASE=postgres \
    -e PGUSER=pgadmin \
    -e PGPASSWORD=<secret> \
    bretif/pentaho:8.2
```

Then you can access pentaho on [http://locahost:8080](http://locahost:8080)

# Configuration

## Variables

- PGPORT
- PGDATABASE
- PGUSER
- PGPASSWORD

# TODO

A lot of thing

- User docker-entrypoint with run-parts
- Remove by default test user
- postgres optional parameter
- different user / password per db
- Manage URL / host
- Merge with [https://github.com/zhicwu/docker-biserver-ce](https://github.com/zhicwu/docker-biserver-ce) as really more clean/powerfull
- ...