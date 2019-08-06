# Example 1b - Basic CockroachDB Cluster (HAProxy)
Simple 3 node CockroachDB cluster with HAProxy acting as load balancer

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer

## Getting started
1) run `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
2) visit the HAProxy UI @ http://localhost:8081
3) have fun!

## Helpful Commands

### Execute SQL
Use the following to execute arbitrary SQL on the CockroachDB cluster.  The following creates a database called `test`.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="CREATE DATABASE test;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/sh
```

### Stop Individual nodes
```bash
docker-compose stop roach-0
docker-compose stop roach-1
docker-compose stop roach-2
```