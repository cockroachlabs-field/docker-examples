# Example 5 - OLTP Bench

Very much a work in progress, but a good start.  Not functional! Do not use!

## Helpful Commands

### Execute SQL
```bash
docker-compose exec roach-0 /cockroach/cockroach sql --insecure --execute="create database tpcc;"
```

### Open Interactive Shells
```bash
docker exec -ti roach-0 /bin/bash
docker exec -ti roach-1 /bin/bash
docker exec -ti roach-2 /bin/bash
docker exec -ti lb /bin/bash
docker exec -ti oltp-bench /bin/bash
```