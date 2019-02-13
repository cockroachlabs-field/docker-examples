# Example 2 - Enterprise Backup with Remote File Server
Demonstrates backing up a 3 node cluster to a remote file server using NGINX.  Relevant documentation can be found here:

* https://www.cockroachlabs.com/docs/stable/backup-and-restore.html
* https://www.cockroachlabs.com/docs/stable/backup.html
* https://www.cockroachlabs.com/docs/stable/create-a-file-server.html

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `fileserver` - NGINX acting as remote file server

## Getting started
1) modify `run.sh` with your `cluster.organization` and `enterprise.license`.
2) because operation order is important, execute `./run.sh` instead of `docker-compose up`
3) visit the CockroachDB UI @ http://localhost:8080
4) visit the HAProxy UI @ http://localhost:8081
5) have fun!

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
docker exec -ti fileserver /bin/bash
```