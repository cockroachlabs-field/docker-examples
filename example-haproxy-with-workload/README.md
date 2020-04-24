# Basic CockroachDB Cluster with HAProxy
Simple 3 node CockroachDB cluster with HAProxy acting as load balancer

## Services
* `crdb-0` - CockroachDB node
* `crdb-1` - CockroachDB node
* `crdb-2` - CockroachDB node
* `workload-client` - CockroachDB node serving as the `workload` client
* `lb` - HAProxy acting as load balancer

## Getting started
1) run `./up.sh`
2) visit the CockroachDB UI @ http://localhost:8080
2) visit the HAProxy UI @ http://localhost:8081
3) have fun!

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.  The following creates a database called `test`.
```bash
docker-compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE test;"
```

### Run the TPC-C Workload
Use the following command to run the `tpcc` sample `workload` for 10 minutes.  For more details see [this](https://www.cockroachlabs.com/docs/stable/cockroach-workload.html#run-the-tpcc-workload).

```bash
docker-compose exec workload-client /cockroach/cockroach workload run tpcc --duration=10m "postgresql://root@lb:5432?sslmode=disable"
```

### Open Interactive Shells
```bash
docker exec -ti crdb-0 /bin/bash
docker exec -ti crdb-1 /bin/bash
docker exec -ti crdb-2 /bin/bash
docker exec -ti workload-client /bin/bash
docker exec -ti lb /bin/sh
```

### Stop Individual nodes
```bash
docker-compose stop crdb-0
docker-compose stop crdb-1
docker-compose stop crdb-2
```