#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift
    exec /bin/sh "$@"
else
    echo "entrypoint.sh:    creating table..."
    java -cp /opt/ycsb/lib/jdbc-binding.jar:/opt/ycsb/lib/postgresql-jdbc.jar com.yahoo.ycsb.db.JdbcDBCreateTable -P /opt/ycsb/conf/db.properties -n usertable

    echo "entrypoint.sh:    loading data based on workloadb-cockroach..."
    /opt/ycsb/bin/ycsb load jdbc -P /opt/ycsb/workloads/workloadb-cockroach -P /opt/ycsb/conf/db.properties

    echo "entrypoint.sh:    executing [$@]"
    exec /opt/ycsb/bin/ycsb "$@"
fi
