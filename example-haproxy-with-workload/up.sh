#!/bin/bash

docker-compose build --no-cache

docker-compose up -d

sleep 10

docker-compose exec workload-client /cockroach/cockroach workload init --warehouses=3 tpcc "postgresql://root@lb:5432?sslmode=disable"
docker-compose exec workload-client /cockroach/cockroach workload run --warehouses=3 tpcc --tolerate-errors --duration=30m "postgresql://root@lb:5432?sslmode=disable"
