# CockroachDB Docker Examples

## Examples
* [Example 1](example-1/README.md) - Simple 3 node cluster fronted by Nginx
* [Example 2](example-2/README.md) - CockroachDB `BACKUP` to Nginx based "File Server"


## Useful commands

### Generate Debug Archive
Generate `debug.zip` file on `roach-0`.  For more details see https://www.cockroachlabs.com/docs/stable/debug-zip.html
```bash
docker-compose exec roach-0 /cockroach/cockroach debug zip ./cockroach-data/logs/debug.zip --insecure
```

Copy `debug.zip` from `roach-0` to current local director
```bash
docker cp roach-0:/cockroach/cockroach-data/logs/debug.zip .
```

