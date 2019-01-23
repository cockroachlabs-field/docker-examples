# Example 6 - Data Locality
Simple multi-node example that demonstrates basic locality and partitioning concepts across three virtual datacenters and a handful of simple tables pinned to different localities.

## Services
* `east-1` - CockroachDB node in `east` datacenter
* `east-2` - CockroachDB node in `east` datacenter
* `east-3` - CockroachDB node in `east` datacenter
* `central-1` - CockroachDB node in `central` datacenter
* `central-2` - CockroachDB node in `central` datacenter
* `central-3` - CockroachDB node in `central` datacenter
* `west-1` - CockroachDB node in `west` datacenter
* `west-2` - CockroachDB node in `west` datacenter
* `west-3` - CockroachDB node in `west` datacenter

## Getting started
1) because operation order is important, execute `./run.sh` instead of `docker-compose up`
2) visit the CockroachDB UI @ http://localhost:8001
3) have fun!

## Helpful Commands

### Show Ranges
Ranges and data distribution can be viewed in the UI here (http://localhost:8001/#/data-distribution) or via the following commands:
```bash
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SHOW EXPERIMENTAL_RANGES FROM TABLE example6.east_only;"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SHOW EXPERIMENTAL_RANGES FROM TABLE example6.central_only;"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SHOW EXPERIMENTAL_RANGES FROM TABLE example6.west_only;"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SHOW EXPERIMENTAL_RANGES FROM TABLE example6.east_central;"
docker-compose exec east-1 /cockroach/cockroach sql --insecure --execute="SHOW EXPERIMENTAL_RANGES FROM TABLE example6.central_west;"
```

### Open Interactive Shells
```bash
docker exec -ti east-1 /bin/bash
docker exec -ti east-2 /bin/bash
docker exec -ti east-3 /bin/bash
docker exec -ti central-1 /bin/bash
docker exec -ti central-2 /bin/bash
docker exec -ti central-3 /bin/bash
docker exec -ti west-1 /bin/bash
docker exec -ti west-2 /bin/bash
docker exec -ti west-3 /bin/bash
```