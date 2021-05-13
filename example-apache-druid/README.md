# CockroachDB + Apache Druid
A single node CRDB instance serving as the metadata store for Apache Druid instead of Postgres or MySQL.

## Services
* `crdb` - CockroachDB node
* `crdb-init` - Executes some commands against CockroachDB and shuts down. See [here](https://github.com/timveil-cockroach/cockroachdb-remote-client).
* `zookeeper` - Apache Druid required service
* `coordinator` - Apache Druid required service
* `historical` - Apache Druid required service
* `middlemanager` - Apache Druid required service
* `router` - Apache Druid required service

## Getting started
1) run `docker compose up`
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the Apache Druid UI @ http://localhost:8888
4) have fun!