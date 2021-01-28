# Running Netflix Genie with CockroachDB
Single node CockroachDB instance running as the metastore for [Netflix Genie](https://github.com/Netflix/genie)

## Services
* `crdb` - CockroachDB node
* `crdb-init` - ephemeral CockroachDB node used to create database
* `genie` - Genie app instance

## Testing
1) run `./up.sh`
2) from a local shell run the following to test...
```
curl 'http://localhost:8080/api/v3/applications' -i -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{
  "id" : null,
  "created" : null,
  "updated" : null,
  "version" : "1.5.1",
  "user" : "genie",
  "name" : "spark",
  "description" : "Spark for Genie",
  "metadata" : { "hi": "bye" },
  "tags" : [ "type:spark", "ver:1.5.1" ],
  "configs" : [ "s3://mybucket/spark/1.5.1/spark-env.sh" ],
  "dependencies" : [ "s3://mybucket/spark/1.5.1/spark.tar.gz" ],
  "setupFile" : "s3://mybucket/spark/1.5.1/setupBase-spark.sh",
  "status" : "ACTIVE",
  "type" : "spark"
}'
```

## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec crdb /bin/bash
docker-compose exec genie /bin/bash
```


    