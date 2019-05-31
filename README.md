# description

Launch pentaho 8.2 with psotgresql configured as repository

# Quick start

You can simply start with default configuration
```
docker-compose up
```

Then you can access pentaho on [http://localhost:18080](http://localhost:18080)


# Configuration

Edit `.env` to match you envisonment

## Variables

- PGPORT
- PGDATABASE
- PGUSER
- PGPASSWORD

# TODO

A lot of thing

- User docker-entrypoint with run-parts
- Remove by default test user
- different user / password per db
- Manage URL / host
- ...