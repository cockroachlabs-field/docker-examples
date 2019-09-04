# CockroachDB Docker Examples

## Examples
* [NGINX Example](example-nginx/README.md) - Simple 3 node cluster with `NGINX`
* [HAProxy Example](example-haproxy/README.md) - Simple 3 node cluster with `HAProxy`
* [Enterprise Backup Example](example-enterprise-backup/README.md) - CockroachDB `BACKUP` to `NGINX` based "File Server"
* [YCSB Functional Example](example-ycsb/README.md) - Building and running [YCSB](https://github.com/brianfrankcooper/YCSB) against a 3 node CockroachDB cluster
* [OLTPBench Functional Example](example-oltpbench/README.md) - Building and running a fork of [OLTPBench](https://github.com/timveil-cockroach/oltpbench) against a 3 node CockroachDB cluster
* [Example 6](example-6/README.md) - 9 node cluster spread across 3 "virtual" data centers 


## Useful commands

### Generate and Download Debug Archive
Generate `debug.zip` file on `crdb-0`.  For more details see https://www.cockroachlabs.com/docs/stable/debug-zip.html
```bash
docker-compose exec crdb-0 /cockroach/cockroach debug zip ./cockroach-data/logs/debug.zip --insecure
```

Copy `debug.zip` from `crdb-0` to current local director
```bash
docker cp crdb-0:/cockroach/cockroach-data/logs/debug.zip .
```

### Prune Docker Images, etc.
Prune all images matching label
```bash
docker system prune -a -f --volumes --filter "label=maintainer=tjveil@gmail.com"
```

Prune all images
```bash
docker system prune -a -f --volumes
```

