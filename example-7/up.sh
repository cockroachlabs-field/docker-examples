#!/bin/bash

docker-compose build --no-cache
docker-compose up -d

docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/mnt/certs/roach-0 --host=roach-0 --execute="CREATE DATABASE test;"
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/mnt/certs/roach-0 --host=roach-0 --execute="CREATE USER test WITH PASSWORD 'password';"
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/mnt/certs/roach-0 --host=roach-0 --execute="SET CLUSTER SETTING server.remote_debugging.mode = \"any\";"