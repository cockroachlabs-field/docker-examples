#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift

    echo "****** entrypoint.sh:    executing shell..."
    exec /bin/sh "$@"
else

    tail -f /dev/null

#    echo "****** entrypoint.sh:    creating table..."
#    java -cp /opt/ycsb/lib/jdbc-binding.jar:/opt/ycsb/lib/postgresql-jdbc.jar com.yahoo.ycsb.db.JdbcDBCreateTable -P /opt/ycsb/conf/db.properties -n usertable
#
#    echo "****** entrypoint.sh:    loading data based on ${WORKLOAD_NAME} with ${WORKLOAD_RECORD_COUNT} records..."
#    /opt/ycsb/bin/ycsb load jdbc -P /opt/ycsb/workloads/${WORKLOAD_NAME} -P /opt/ycsb/conf/db.properties -p recordcount=${WORKLOAD_RECORD_COUNT}
#
#    echo "****** entrypoint.sh:    executing benchmark for workload ${WORKLOAD_NAME}, target OPS is ${WORKLOAD_TARGET_OPS}"
#    exec /opt/ycsb/bin/ycsb run jdbc -target ${WORKLOAD_TARGET_OPS} -s -P /opt/ycsb/workloads//${WORKLOAD_NAME} -P /opt/ycsb/conf/db.properties
fi
