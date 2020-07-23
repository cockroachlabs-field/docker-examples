# Running Netflix Genie with CockroachDB
Single node CockroachDB cluster with Netflix Genie https://github.com/Netflix/genie

## Services
* `crdb` - CockroachDB node
* `crdb-init` - ephemeral CockroachDB node used to create database
* `genie` - Genie app instance
* `genie-apache` - Genie Demo Apache
* `genie-client` - Genie Demo Client
* `genie-hadoop-prod` - Simple Hadoop instance
* `genie-hadoop-test` - Simple Hadoop test instance
* `genie-presto` - Presto instance

## Testing
I forked https://github.com/Netflix/genie and ran the following to build Genie and create local updated Docker images.
```
./gradlew clean build -x check
./gradlew clean dockerBuildAllImages -x check
```

Then...

1) run `./up.sh`
3) from a local shell run the following to test...
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

Currently CockroachDB fails with the following error in Genie

```
2020-07-16 14:47:01.315  WARN 1 --- [nio-8080-exec-1] o.h.e.j.s.SqlExceptionHelper             : SQL Error: 0, SQLState: 99999
2020-07-16 14:47:01.316 ERROR 1 --- [nio-8080-exec-1] o.h.e.j.s.SqlExceptionHelper             : The fastpath function lo_creat is unknown.
```


## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec crdb /bin/bash
docker-compose exec genie /bin/bash
```

## Testing with CRDB Hibernate Dialect Alpha

I downloaded the `hibernate-core-5.5.0-SNAPSHOT.jar` jar to my local `Downloads` folder and ran the below command to upload this jar to a private `mvn` repo that I created here `https://mymavenrepo.com/app/repos/euqQvvGJ8W8mugiThH33/`

```
mvn deploy:deploy-file -DgroupId=org.hibernate \
  -DartifactId=hibernate-core \
  -Dversion=5.5.0-SNAPSHOT \
  -Dpackaging=jar \
  -Dfile=hibernate-core-5.5.0-SNAPSHOT.jar \
  -Durl=https://mymavenrepo.com/repo/bj1Jazo305dltxkS0McV/
```

I then modified the `build.properties` and `build.gradle` files to refer this new Hibernate version. 

`org.hibernate:hibernate-core:5.5.0-SNAPSHOT`

Not clear why, but this custom jar does not provide dependency information.  As a result, I had to also manually include its transitive dependencies.  These were added to `genie-web` > `build.gradle`.