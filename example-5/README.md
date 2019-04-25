# Example 5 - OLTP-Bench Suite
Demonstrates building and executing the `OLTP-Bench` suite against a 3 node CockroachDB cluster.  More information on `OLTP-Bench` can be found here: https://github.com/timveil-cockroach/oltpbench.

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `db-ui` - Instance of PgAdmin for browsing CockroachDB
* `oltp-bench` - `OLTP-Bench` client container responsible for executing benchmark workloads

## Getting started
1) because operation order is important, execute `./run.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the HAProxy UI @ http://localhost:8081
3) visit the PgAdmin UI @ http://localhost:8082 (username: `test@crdb.io`, password: `password`)
4) have fun!

## Basic Configuration
The following `environment` variables in `docker-compose.yml` control workload execution...
* `BENCHMARK_NAME` - The name of the workload to run.  The default value is `tpcc`.
    * Supported Values:
        * `acutionmark`
        * `chbenchmark`
        * `epinions`
        * `linkbench`
        * `noop`
        * `resourcestresser`
        * `seats`
        * `sibench`
        * `smallbank`
        * `tatp`
        * `tpcc`
        * `tpcds`
        * `tpch`
        * `twitter`
        * `voter`
        * `wikipedia`
        * `ycsb`
* `BENCHMARK_CONFIG_FILE` - The benchmark configuration file.  The default is `crdb_tpcc_config.xml`.

## Helpful Commands

### Execute SQL
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="create database tpcc;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/sh
docker exec -ti db-ui /bin/sh
docker exec -ti oltp-bench /bin/bash
```
