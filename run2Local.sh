#!/bin/bash

# to test using local postgres
# docker run --name postgres -e POSTGRES_USER=mypay4 -e POSTGRES_PASSWORD=mypay4 -p 5432:5432 -d postgres
# then you need to create the db to test

export PGHOST=localhost
export PGPORT=5432
export PGUSERNAME=mypay4
export PGPASSWORD=mypay4

printf "\n************\n"
./run.sh citizen
printf "\n************\n"
./run.sh payhub
printf "\n************\n"
./run.sh analytics
