#!/bin/bash

docker-compose build --no-cache

## start source database and load balancer
docker-compose up --no-start
docker-compose start cockroachdb

echo "waiting for cockroach to initialize..."
sleep 5

# create backup database
docker-compose exec cockroachdb /cockroach/cockroach sql --insecure --execute="CREATE DATABASE ycsb;"

echo "starting ycsb..."
docker-compose start ycsb
