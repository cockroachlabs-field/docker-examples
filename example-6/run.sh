#!/bin/bash

docker-compose up -d

sleep 10

docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="INSERT into system.locations VALUES ('datacenter', 'east', 33.836082, -81.163727), ('datacenter', 'central', 42.032974, -93.581543), ('datacenter', 'west', 43.804133, -120.554201);"

docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE example6;"

docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE TABLE example6.east_only (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name STRING);"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE TABLE example6.central_only (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name STRING);"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE TABLE example6.west_only (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name STRING);"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE TABLE example6.east_central (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name STRING);"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="CREATE TABLE example6.central_west (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name STRING);"


docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="ALTER TABLE example6.east_only CONFIGURE ZONE USING constraints='[+datacenter=east]';"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="ALTER TABLE example6.central_only CONFIGURE ZONE USING constraints='[+datacenter=central]';"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="ALTER TABLE example6.west_only CONFIGURE ZONE USING constraints='[+datacenter=west]';"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="ALTER TABLE example6.east_central CONFIGURE ZONE USING constraints='{+datacenter=east: 2, +datacenter=central: 1}';"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="ALTER TABLE example6.central_west CONFIGURE ZONE USING constraints='{+datacenter=central: 1, +datacenter=west: 2}';"
