#!/bin/bash

docker-compose build --no-cache

## start source database and load balancer
docker-compose up --no-start
docker-compose start roach-0
docker-compose start roach-1
docker-compose start roach-2
docker-compose start lb

echo "waiting for cockroach to initialize..."
sleep 5

# create backup database
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE oltpbench;"

echo "starting oltp-bench..."
docker-compose start oltp-bench
