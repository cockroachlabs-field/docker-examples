# Example 4 - YCSB Benchmark Test (1 node)
Demonstrates building and executing the YCSB benchmark against a single CockroachDB node.  More information on YCSB can be found here: https://github.com/brianfrankcooper/YCSB/wiki.

## Services
* `cockroachdb` - CockroachDB node
* `ycsb` - YCSB client container responsible for executing benchmark workload

## Getting started
1) because operation order is important, execute `./run.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) have fun!

## Basic Configuration
The following `environment` variables in `docker-compose.yml` control workload execution...
* `WORKLOAD_NAME` - The name of the workload to run.  The default value is `workload-b-cockroach`.
* `WORKLOAD_TARGET_OPS` - The target Operations per Second (OPS).  The default value is `100`.
* `WORKLOAD_RECORD_COUNT` - The number or records to load into the database.   The default value is `20000`.

## Advanced Configuration
For database configuration information, see [db.properties](ycsb/db.properties). 

The following `args` in `docker-compose.yml` are used to control the versions of the Postgres JDBC driver and YCSB.  Feel free to modify if necessary.
* `POSTGRESQL_JDBC_VERSION` - The version of the Postgres JDBC driver to download and use.  The default value is `42.2.5`.
* `GIT_BRANCH` - The version of YCSB to checkout from `git`.  The default value is `master`.


### db.properties
```properties
db.driver=org.postgresql.Driver
db.url=jdbc:postgresql://cockroachdb:26257/ycsb?sslmode=disable&application_name=ycsb&reWriteBatchedInserts=true
db.user=root
db.passwd=
db.batchsize=25
jdbc.fetchsize=10
jdbc.autocommit=true
jdbc.batchupdateapi=true
```

### Included Workloads

#### workload-a-cockroach
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0.5
updateproportion=0.5
scanproportion=0
insertproportion=0

requestdistribution=zipfian
```

#### workload-b-cockroach (default)
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0.95
updateproportion=0.05
scanproportion=0
insertproportion=0

requestdistribution=zipfan
```

#### workload-c-cockroach
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=1
updateproportion=0
scanproportion=0
insertproportion=0

requestdistribution=zipfian
```

#### workload-d-cockroach
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0.95
updateproportion=0
scanproportion=0
insertproportion=0.05

requestdistribution=latest
```

#### workload-e-cockroach
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0
updateproportion=0
scanproportion=0.95
insertproportion=0.05

requestdistribution=zipfian

maxscanlength=100

scanlengthdistribution=uniform
```

#### workload-f-cockroach
```properties
recordcount=20000
operationcount=1000
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0.5
updateproportion=0
scanproportion=0
insertproportion=0
readmodifywriteproportion=0.5

requestdistribution=zipfian
```

You can also run the following workloads 

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.
```bash
docker-compose exec cockroachdb /cockroach/cockroach sql --insecure --execute="select count(*) from ycsb.usertable;"
```

### Open Interactive Shells
```bash
docker exec -ti cockroachdb /bin/bash
docker exec -ti ycsb /bin/bash
```