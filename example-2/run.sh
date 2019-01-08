#!/bin/bash

docker-compose up -d

echo "waiting for cluster to come up..."
sleep 20

# configure license
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING cluster.organization = 'xxx';"
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING enterprise.license = 'xxx';"

echo "waiting for license to be applied..."
sleep 10

# configure license
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE bank;"
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --database bank --execute="CREATE TABLE accounts (id INT PRIMARY KEY, balance DECIMAL);"
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --database bank --execute="INSERT INTO accounts VALUES (1, 1000.50);"

echo "waiting for tables to be created..."
sleep 10

# execute backup
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="BACKUP DATABASE bank TO 'http://fileserver:20150/bank-backup' AS OF SYSTEM TIME '-10s';"
