# Running OLTP-Bench Suite Fork
Demonstrates building and executing a fork of the `OLTP-Bench` suite against a 3 node CockroachDB cluster.  More information on the `OLTP-Bench` fork can be found here: https://github.com/timveil-cockroach/oltpbench.

> This is included here as a functional example.  This configuration should not be considered the basis for a performance evaluation.

## Services
* `crdb-0` - CockroachDB node
* `crdb-1` - CockroachDB node
* `crdb-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `oltp-bench` - `OLTP-Bench` client container responsible for executing benchmark workloads

## Getting started
1) because operation order is important, execute `./up.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the HAProxy UI @ http://localhost:8081
4) have fun!

## Basic Configuration
The following `environment` variables in `docker-compose.yml` control workload execution...
* `BENCHMARK_NAME` - The name of the workload to run.  The default value is `tpcc`.
    * Supported Values:
        * `tpcc`
        * `tpch`
        * `ycsb`
* `BENCHMARK_CONFIG_FILE` - The benchmark configuration file.  The default is `crdb_tpcc_config.xml`.

## Helpful Commands

### Execute SQL
```bash
docker-compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="create database tpcc;"
```

### Open Interactive Shells
```bash
docker exec -ti crdb-0 /bin/bash
docker exec -ti crdb-1 /bin/bash
docker exec -ti crdb-2 /bin/bash
docker exec -ti lb /bin/sh
docker exec -ti oltp-bench /bin/bash
```
