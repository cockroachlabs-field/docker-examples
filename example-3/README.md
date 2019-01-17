# Example 3 - YCSB Benchmark Test
Demonstrates building and executing the YCSB benchmark against a 3 node CockroachDB cluster.  More information on YCSB can be found here: https://github.com/brianfrankcooper/YCSB/wiki.

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - NGINX acting as load balancer
* `ycsb` - YCSB client container responsible for executing benchmark workload

## Getting started
1) because operation order is important, execute `./run.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) have fun!


## Advanced Configuration
For database configuration information, see [db.properties](ycsb/db.properties).  By default this example executes a `workload` called `workload-b-cockroach` (see [workload-cockroach](ycsb/workload-b-cockroach)).  This is a slight modification of the default YCSB `workloadb` configuration.

The following `ARGS` in `docker-compose.yml` are used to control the versions of the Postgres JDBC driver and YCSB.  Feel free to modify if necessary.

```
- POSTGRESQL_JDBC_VERSION=42.2.5
- GIT_BRANCH=0.15.0
```

### db.properties
```properties
db.driver=org.postgresql.Driver
db.url=jdbc:postgresql://lb:5432/ycsb?sslmode=disable&application_name=ycsb&reWriteBatchedInserts=true
db.user=root
db.passwd=
jdbc.fetchsize=10
jdbc.autocommit=true
jdbc.batchupdateapi=true
db.batchsize=1000
```

#### Included Workloads

##### workload-a-cockroach
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

##### workload-b-cockroach
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

##### workload-c-cockroach
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

##### workload-d-cockroach
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

##### workload-e-cockroach
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

##### workload-f-cockroach
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
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="select * from ycsb.usertable;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/bash
docker exec -ti ycsb /bin/bash
```