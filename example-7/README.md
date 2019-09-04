# Example 1b - Basic CockroachDB Cluster (HAProxy)
Simple 3 node CockroachDB cluster with HAProxy acting as load balancer

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer

## Getting started
1) because operation order is important, execute `./up.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
2) visit the HAProxy UI @ http://localhost:8081
3) have fun!

## Helpful Commands

### Create User
The following creates a user called `test` with password `password`.  This can be used to login to the CockroachDB UI.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/mnt/certs/roach-0 --host=roach-0 --execute="CREATE USER test WITH PASSWORD 'password';"
```

### Create Database
The following creates a database called `test`.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/mnt/certs/roach-0 --host=roach-0 --execute="CREATE DATABASE test;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/sh
```