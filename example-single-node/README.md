# Single CockroachDB instance
Simple single node CockroachDB instance.

## Services
* `crdb` - CockroachDB node

## Getting started
1) run `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) have fun!

## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec crdb /bin/bash
```