# Running Original YCSB Workload
Demonstrates building and executing the original YCSB workload against a 3 node CockroachDB cluster.  More information on YCSB can be found here: https://github.com/brianfrankcooper/YCSB/wiki.

> This is included here as a functional example.  This configuration should not be considered the basis for a performance evaluation.

## Services
* `crdb-0` - CockroachDB node
* `crdb-1` - CockroachDB node
* `crdb-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `crdb-init` - Executes some commands against CockroachDB and shuts down. See [here](https://github.com/timveil-cockroach/cockroachdb-remote-client).
* `ycsb` - YCSB client container responsible for executing benchmark workload

## Getting started
1) because operation order is important, execute `./up.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the HAProxy UI @ http://localhost:8081
4) have fun!

## Basic Configuration
The following `environment` variables in `docker-compose.yml` control workload execution...
* `WORKLOAD_NAME` - The name of the workload to run.  The default value is `workload-b-cockroach`.
* `WORKLOAD_TARGET_OPS` - The target Operations per Second (OPS).  The default value is `100`.
* `WORKLOAD_RECORD_COUNT` - The number of records to load into the database.   The default value is `20000`.

## Advanced Configuration
For database configuration information, see [db.properties](ycsb/db.properties). 

The following `args` in `docker-compose.yml` are used to control the versions of the Postgres JDBC driver and YCSB.  Feel free to modify if necessary.
* `POSTGRESQL_JDBC_VERSION` - The version of the Postgres JDBC driver to download and use.  The default value is `42.2.12`.
* `GIT_BRANCH` - The version of YCSB to checkout from `git`.  The default value is `master`.


### db.properties
```properties
db.driver=org.postgresql.Driver
db.url=jdbc:postgresql://lb:26257/ycsb?sslmode=disable&application_name=ycsb&reWriteBatchedInserts=true
db.user=root
db.passwd=
db.batchsize=128
jdbc.fetchsize=10
jdbc.autocommit=true
jdbc.batchupdateapi=true
```

### Included Workloads

* [workload-a-cockroach](ycsb/workload-a-cockroach)
* [workload-b-cockroach](ycsb/workload-b-cockroach) (default)
* [workload-c-cockroach](ycsb/workload-c-cockroach)
* [workload-d-cockroach](ycsb/workload-d-cockroach)
* [workload-e-cockroach](ycsb/workload-e-cockroach)
* [workload-f-cockroach](ycsb/workload-f-cockroach)

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.
```bash
docker-compose exec crdb-0 /cockroach/cockroach sql --insecure --execute="select count(*) from ycsb.usertable;"
```

### Open Interactive Shells
```bash
docker-compose exec crdb-0 /bin/bash
docker-compose exec crdb-1 /bin/bash
docker-compose exec crdb-2 /bin/bash
docker-compose exec lb /bin/sh
docker-compose exec ycsb /bin/bash
```