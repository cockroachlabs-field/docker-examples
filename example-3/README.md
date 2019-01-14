# Example 3
Demonstrates building and executing the YCSB benchmark against a 3 node CockroachDB cluster.  More information on YCSB can be found here: https://github.com/brianfrankcooper/YCSB/wiki.

For database configuration information, see [db.properties](ycsb/db.properties).
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

By default this example executes a `workload` called `workload-cockroach` (see [workkload-cockroach](ycsb/workload-cockroach)).  This is a slight modification of the default YCSB `workloadb` configuration.
```properties
# modified workload B from YCSB
#   changed recordcount from 1000 to 20000
#   changed operationcount from 1000 to 0
#   changed requestdistribution from zipfan to uniform

# Yahoo! Cloud System Benchmark
# Workload B: Read mostly workload
#   Application example: photo tagging; add a tag is an update, but most operations are to read tags
#                        
#   Read/update ratio: 95/5
#   Default data size: 1 KB records (10 fields, 100 bytes each, plus key)
#   Request distribution: zipfian

recordcount=20000
operationcount=0
workload=com.yahoo.ycsb.workloads.CoreWorkload

readallfields=true

readproportion=0.95
updateproportion=0.05
scanproportion=0
insertproportion=0

requestdistribution=uniform
```

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

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="select * from ycsb;"
```