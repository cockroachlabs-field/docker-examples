# CockroachDB Docker Examples

## Useful commands

### Generate Debug Archive
Generate `debug.zip` file on `roach-0`
```bash
docker-compose exec roach-0 /cockroach/cockroach debug zip ./cockroach-data/logs/debug.zip --insecure
```

Copy `debug.zip` from `roach-0` to current local director
```bash
docker cp roach-0:/cockroach/cockroach-data/logs/debug.zip .
```

