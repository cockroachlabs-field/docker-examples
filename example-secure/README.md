# Secure CockroachDB Cluster
Simple 3 node *secure* CockroachDB cluster with HAProxy acting as load balancer

## Services
* `roach-0` - CockroachDB node
* `roach-1` - CockroachDB node
* `roach-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `roach-cert` - Holds certificates as volume mounts
* `roach-init` - Executes some commands against CockroachDB and shuts down. See [here](https://github.com/timveil-cockroach/cockroachdb-remote-client).

## Getting started
>If you are using Google Chrome as your browser, you may want to navigate here `chrome://flags/#allow-insecure-localhost` and set this flag to `Enabled`. 

1) execute `./up.sh` to start the cluster
2) visit the CockroachDB UI @ https://localhost:8080 and login with username `test` and password `password`
3) visit the HAProxy UI @ http://localhost:8081
4) have fun!

## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec roach-0 /bin/bash
docker-compose exec roach-1 /bin/bash
docker-compose exec roach-2 /bin/bash
docker-compose exec lb /bin/sh
docker-compose exec roach-cert /bin/sh
```

### Copy Client Certificate and Key
Use these commands to copy `client.root.*` files from the `roach-cert` docker image to your local machine
```bash
docker cp roach-cert:/certs/client/client.root.crt .
docker cp roach-cert:/certs/client/client.root.key .
docker cp roach-cert:/certs/client/client.root.key.pk8 .
```
