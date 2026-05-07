#!/bin/bash

BASEDIR=$(dirname "$(realpath "$0")")
export DB="$1"

DBS=$(ls "$BASEDIR/db")

function print_help() {
   echo "To run the script you have to:"
   echo " * provide the db name as parameter: $DBS"
   echo " * define the following environment variable:"
   echo "   * PGHOST"
   echo "   * PGPORT"
   echo "   * PGPASSWORD"
   echo "   * PGUSERNAME"
}

function checkEnv() {
    if [ -z "$(printenv "$1")" ]
    then
      print_help
      echo "An error occurred: $1 is not set"
      exit 1
    fi
}

checkEnv PGHOST
checkEnv PGPORT
checkEnv DB
checkEnv PGUSERNAME
checkEnv PGPASSWORD

DBDIR="$BASEDIR/db/$DB"

if [ ! -d "$DBDIR" ]; then
	   exitWhenError "DB name provided not valid! Must be one of $DBS"
fi

echo "Applying $DB migration"

docker run --rm  \
  -v "/$DBDIR:/liquibase/changelog" \
  --network="host" \
  \
  public.ecr.aws/liquibase/liquibase:4.33 \
  --url="jdbc:postgresql://$PGHOST:$PGPORT/$DB" \
  --username="$PGUSERNAME" \
  --password="$PGPASSWORD" \
  --searchPath "/liquibase/changelog" \
  --changelogFile "changelog.xml" \
  \
  update