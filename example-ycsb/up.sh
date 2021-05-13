#!/bin/bash

docker compose build --no-cache

docker compose up --no-start
docker compose start crdb-0
docker compose start crdb-1
docker compose start crdb-2
docker compose start lb
docker compose start crdb-init

sleep 5

echo "starting ycsb..."
docker compose start ycsb
