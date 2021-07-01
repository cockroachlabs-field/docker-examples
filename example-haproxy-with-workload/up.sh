#!/bin/bash

docker compose build --no-cache

docker compose up -d

sleep 30

docker compose exec workload-client /cockroach/cockroach workload init --warehouses=1 tpcc "postgresql://root@lb:26257?sslmode=disable"

sleep 10

docker compose exec workload-client /cockroach/cockroach workload run --warehouses=1 tpcc --tolerate-errors --duration=30m "postgresql://root@lb:26257?sslmode=disable"
