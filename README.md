# p4pa-db
This repository contains a [liquibase](https://docs.liquibase.com/home.html) project configured to initialize databases and run the migration scripts provided during application evolution.

## Pre-requisites
To apply the schema, it's required:
* The existence of the following databases:
  * citizen
  * payhub
  * analytics
* The existence of a user with permissions on the previous databases

## Execution
In order to execute the schema migration, you have to:
* Define the following environment variables:

    | ENV                                 | Description       |
    |-------------------------------------|-------------------|
    | PGHOST                              | Database hostname |
    | PGPORT                              | Database port     |
    | PGUSERNAME                          | Database user     |
    | PGPASSWORD                          | Database password |

* Execute the `/run.sh` script providing as unique parameter the database name (eg: `./run.sh payhub`)
