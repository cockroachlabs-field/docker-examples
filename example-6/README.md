# Example 6 - Data Locality
Simple multi-node example that demonstrates basic locality and partitioning concepts across three virtual data centers and a handful of simple tables pinned to different localities.

* `east_only` table is pinned to the `east` data center only
* `central_only` table is pinned to the `central` data center only
* `west_only` table is pinned to the `west` data center only
* `east_central` table is pinned to the `east` and `west` data centers
* `central_west` table is pinned to the `central` and `west` data centers

This distribution can be verified by the SQL commands below or via the UI... http://localhost:8001/#/data-distribution.

## Services
* `east-1` - CockroachDB node in `east` data center
* `east-2` - CockroachDB node in `east` data center
* `east-3` - CockroachDB node in `east` data center
* `central-1` - CockroachDB node in `central` data center
* `central-2` - CockroachDB node in `central` data center
* `central-3` - CockroachDB node in `central` data center
* `west-1` - CockroachDB node in `west` data center
* `west-2` - CockroachDB node in `west` data center
* `west-3` - CockroachDB node in `west` data center

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