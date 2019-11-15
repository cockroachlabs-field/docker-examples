# Secure CockroachDB Cluster
Simple 3 node *secure* CockroachDB cluster with HAProxy acting as load balancer

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `roach-cert` - Holds certificates as volume mounts

## Getting started
>If you are using Google Chrome as your browser, you may want to navigate here `chrome://flags/#allow-insecure-localhost` and set this flag to `Enabled`. 

1) because operation order is important, execute `./up.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ https://localhost:8080 and login with username `test` and password `password`
3) visit the HAProxy UI @ http://localhost:8081
4) have fun!

## Helpful Commands

### Create User
The following creates a user called `test` with password `password`.  This can be used to login to the CockroachDB UI.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/certs --host=roach-0 --execute="CREATE USER test WITH PASSWORD 'password';"
```

### Create Database
The following creates a database called `test`.
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --certs-dir=/certs --host=roach-0 --execute="CREATE DATABASE test;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/sh
docker exec -ti roach-cert /bin/sh
```