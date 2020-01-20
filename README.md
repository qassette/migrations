# Migrations

Repository contains migration files as well as convenient interface to run migrations, supports only postgresql as backend

## Configuration

Database connection string is expected as environment variable:

`ENV['DATABASE_URL'] = postgres://user:secret@dbhost:5432/mydatabasename`

## Usage

### Create database

`rake db:create`

### See current schema version

`rake db:version`

### Run migration

`rake db:migrate`

### Rollback migration

`rake db:rollback`

### Drop database

`rake db:drop`
