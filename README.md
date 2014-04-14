[![Build Status](https://travis-ci.org/theodi/uk-postcodes.png)](https://travis-ci.org/theodi/uk-postcodes)
[![Coverage Status](https://coveralls.io/repos/theodi/uk-postcodes/badge.png)](https://coveralls.io/r/theodi/uk-postcodes)
[![License](http://img.shields.io/license/mit.png?color=green)](http://theodi.mit-license.org/)

# UK Postcodes

This is the next generation version of [http://www.uk-postcodes.com](http://www.uk-postcodes.com). The functionality is largely unchanged, but improvements include:

* Better codebase (bye bye PHP)
* PostGIS backend
* (Hopefully) better support
* New design
* Easy setup for local installs

## Running a local version

I've included all the necessary data in this repo (which I will keep updated). To get this up and running locally (I'm assuming you have Ruby installed).

### Install PostgreSQL and PostGIS

If you're running a Mac, the easiest way to install Postgres and PostGIS is to install [Postgres.app](http://postgresapp.com/), otherwise follow the instructions at http://postgis.net/install/. Then do the following:

```
psql -c 'CREATE USER root with SUPERUSER;' -U postgres
psql -c 'CREATE DATABASE uk_postcodes_development;' -U postgres
psql -d uk_postcodes_development -c 'CREATE SCHEMA postgis; CREATE EXTENSION postgis WITH SCHEMA postgis;' -U postgres
```

### Clone the repo

    git clone git@github.com:theodi/uk-postcodes.git

### Run bundler

    bundle install

### Run migrations

    rake db:migrate

### Import the data

    rake import:all

(This will take a couple of hours, so go outside and play, or something)

### Run the app

    rails s

Obviously if you're running this in production, you may need to do some other steps, but these steps should be all you need to get it running locally.
