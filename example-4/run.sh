#!/bin/bash

docker-compose build --no-cache

docker-compose up --no-start
docker-compose start cockroachdb

sleep 5

docker-compose exec cockroachdb /cockroach/cockroach sql --insecure --execute="CREATE DATABASE ycsb;"

echo "starting ycsb..."
docker-compose start ycsb
