#!/bin/bash

CRDB_ORG=$1
CRDB_LICENSE_KEY=$2

if [[ -z "$CRDB_ORG" ]]; then
    echo "Must provide CRDB_ORG as the first parameter. Example './up.sh CRDB_ORG CRDB_LICENSE_KEY'." 1>&2
    exit 1
fi

if [[ -z "$CRDB_LICENSE_KEY" ]]; then
    echo "Must provide CRDB_LICENSE_KEY as the second parameter. Example './up.sh CRDB_ORG CRDB_LICENSE_KEY'." 1>&2
    exit 1
fi

docker compose build --no-cache
docker compose up -d

echo "waiting for cluster to come up..."
sleep 20

echo "configuring cluster and database with cluster.organization = ${CRDB_ORG} and enterprise.license = ${CRDB_LICENSE_KEY}"
docker compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING cluster.organization = '${CRDB_ORG}';"
docker compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING enterprise.license = '${CRDB_LICENSE_KEY}';"

echo "executing workload to generate tables and data..."
docker compose exec crdb-0 /cockroach/cockroach workload init bank 'postgresql://root@localhost:26257?sslmode=disable'
docker compose exec crdb-0 /cockroach/cockroach workload run bank --duration=1m 'postgresql://root@localhost:26257?sslmode=disable'

echo "waiting before executing backup..."
sleep 20

echo "executing backup..."
docker compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="BACKUP DATABASE bank TO 'http://fileserver:20150/bank-backup' AS OF SYSTEM TIME '-10s';"
