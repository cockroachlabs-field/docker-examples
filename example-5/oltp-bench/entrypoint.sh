#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift

    echo "****** entrypoint.sh:    executing shell..."
    exec /bin/sh "$@"

else

    if [[ -v "BENCHMARK_NAME" ]] && [[ -v "BENCHMARK_CONFIG_FILE" ]]; then

        echo "****** entrypoint.sh:    executing OLTP Benchmark: benchmark = [${BENCHMARK_NAME}] using config file = [${BENCHMARK_CONFIG_FILE}]..."

        cd  /opt/oltpbench

        java -jar oltpbench-*.jar -b ${BENCHMARK_NAME} -c config/${BENCHMARK_CONFIG_FILE} --create=true --load=true --execute=true -s 5

    else

        echo "****** entrypoint.sh:    BENCHMARK_NAME and BENCHMARK_CONFIG_FILE not specified."
        tail -f /dev/null

    fi

fi
