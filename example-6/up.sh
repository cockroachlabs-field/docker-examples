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


docker-compose up -d

sleep 10

docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="INSERT into system.locations VALUES ('datacenter', 'east', 33.836082, -81.163727), ('datacenter', 'central', 42.032974, -93.581543), ('datacenter', 'west', 43.804133, -120.554201);"

echo "configuring cluster and database with cluster.organization = ${CRDB_ORG} and enterprise.license = ${CRDB_LICENSE_KEY}"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING cluster.organization = '${CRDB_ORG}';"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SET CLUSTER SETTING enterprise.license = '${CRDB_LICENSE_KEY}';"
