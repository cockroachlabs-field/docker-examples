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
I forked Genie [here](https://github.com/timveil-cockroach/genie) and updated a handful of `gradle` files to pull the custom Hibernate jar (`hibernate-core-5.5.0-SNAPSHOT.jar`) containing the new `org.hibernate.dialect.CockroachDB201Dialect`.  To simplfy testing, I published the custom Hibernate jar to publically assessible custom Maven repository... https://mymavenrepo.com/repo/RxBukD1nCtgtoR5src2I/.  Before testing, I ran the following commands to build Genie and create local updated Docker images with the new dependencies.

```
./gradlew clean build -x check
./gradlew clean dockerBuildAllImages -x check
```

Once the new docker images are ready, run the following.

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

An alternate method would be to simply build Genie from the fork and run something like this (assuming CRDB is up)
```
java -jar genie-app/build/libs/genie-app-4.0.0-SNAPSHOT.jar \
    --spring.jpa.hibernate.ddl-auto=create \
    --spring.flyway.enabled=false \
    --spring.datasource.url=jdbc:postgresql://127.0.0.1:26250/genie?sslmode=disable \
    --spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.CockroachDB201Dialect \
    --spring.datasource.platform=postgresql
```

## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec crdb /bin/bash
docker-compose exec genie /bin/bash
```

## Publishing the custom CRDB Hibernate jar

I downloaded the `hibernate-core-5.5.0-SNAPSHOT.jar` jar (provided by CRDB engineering) to my local `Downloads` folder and ran the below command to upload this jar to a private `mvn` repo that I created here `https://mymavenrepo.com/app/repos/euqQvvGJ8W8mugiThH33/`

```
mvn deploy:deploy-file -DgroupId=org.hibernate \
  -DartifactId=hibernate-core \
  -Dversion=5.5.0-SNAPSHOT \
  -Dpackaging=jar \
  -Dfile=hibernate-core-5.5.0-SNAPSHOT.jar \
  -Durl=https://mymavenrepo.com/repo/bj1Jazo305dltxkS0McV/
```


    