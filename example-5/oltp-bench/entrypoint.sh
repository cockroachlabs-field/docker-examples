#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift

    echo "****** entrypoint.sh:    executing shell..."
    exec /bin/sh "$@"
else

    echo "****** entrypoint.sh:    executing OLTP Benchmark: benchmark = [${BENCHMARK_NAME}] using config file = [${BENCHMARK_CONFIG_FILE}]..."

    # don't like this hack cd; todo make this a bundled jar and remove clunky startup
    cd  /opt/oltpbench
    ./oltpbenchmark -b ${BENCHMARK_NAME} -c config/${BENCHMARK_CONFIG_FILE} --create=true --load=true --execute=true -s 5

fi
