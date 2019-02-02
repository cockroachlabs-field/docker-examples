# CockroachDB Docker Examples

## Examples
* [Example 1](example-1/README.md) - Simple 3 node cluster with `NGINX`
* [Example 1b](example-1b/README.md) - Simple 3 node cluster with `HAProxy`
* [Example 2](example-2/README.md) - CockroachDB `BACKUP` to `NGINX` based "File Server"
* [Example 3](example-3/README.md) - Building and running `YCSB` against a 3 node CockroachDB cluster
* [Example 4](example-4/README.md) - Building and running `YCSB` against a single CockroachDB node
* [Example 5](example-5/README.md) - Building and running `OLTPBench` against a 3 node CockroachDB cluster
* [Example 6](example-6/README.md) - 9 node cluster spread across 3 "virtual" data centers 


## Useful commands

### Generate and Download Debug Archive
Generate `debug.zip` file on `roach-0`.  For more details see https://www.cockroachlabs.com/docs/stable/debug-zip.html
```bash
docker-compose exec roach-0 /cockroach/cockroach debug zip ./cockroach-data/logs/debug.zip --insecure
```

Copy `debug.zip` from `roach-0` to current local director
```bash
docker cp roach-0:/cockroach/cockroach-data/logs/debug.zip .
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

