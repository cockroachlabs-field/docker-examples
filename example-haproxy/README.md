# Basic CockroachDB Cluster with HAProxy
Simple 3 node CockroachDB cluster with HAProxy acting as load balancer

## Services
* `crdb-0` - CockroachDB node
* `crdb-1` - CockroachDB node
* `crdb-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `crdb-init` - Executes some commands against CockroachDB and shuts down. See [here](https://github.com/timveil-cockroach/cockroachdb-remote-client).

## Getting started
1) run `docker compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the HAProxy UI @ http://localhost:8081
4) have fun!

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.  The following creates a database called `test`.
```bash
docker compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE test;"
```

### Initialize and Run the TPC-C Workload
Use the following commands to initialize and run the `tpcc` sample `workload`.  For more details see [this](https://www.cockroachlabs.com/docs/stable/cockroach-workload.html#run-the-tpcc-workload).

to initialize...
```bash
docker compose exec crdb-0 /cockroach/cockroach workload init tpcc "postgresql://root@localhost:26257?sslmode=disable"
```

to run for `10m`...
```bash
docker compose exec crdb-0 /cockroach/cockroach workload run tpcc --duration=10m "postgresql://root@localhost:26257?sslmode=disable"
```

### Open Interactive Shells
```bash
docker compose exec crdb-0 /bin/bash
docker compose exec crdb-1 /bin/bash
docker compose exec crdb-2 /bin/bash
docker compose exec lb /bin/sh
```

### Stop Individual nodes
```bash
docker compose stop crdb-0
docker compose stop crdb-1
docker compose stop crdb-2
```