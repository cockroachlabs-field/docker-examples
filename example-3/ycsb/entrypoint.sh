#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift
    exec /bin/sh "$@"
else
    java -cp /opt/ycsb/lib/jdbc-binding.jar:/opt/ycsb/lib/postgresql-jdbc.jar com.yahoo.ycsb.db.JdbcDBCreateTable -P /opt/ycsb/conf/db.properties -n usertable

    /opt/ycsb/bin/ycsb load jdbc -P /opt/ycsb/workloads/workloadb -P /opt/ycsb/conf/db.properties -p recordcount=20000

    exec /opt/ycsb/bin/ycsb "$@"
fi
