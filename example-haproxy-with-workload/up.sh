#!/bin/bash

docker-compose build --no-cache

docker-compose up -d

sleep 10

docker-compose exec workload-client /cockroach/cockroach workload init tpcc "postgresql://root@lb:5432?sslmode=disable"
docker-compose exec workload-client /cockroach/cockroach workload run tpcc --duration=30m "postgresql://root@lb:5432?sslmode=disable"
