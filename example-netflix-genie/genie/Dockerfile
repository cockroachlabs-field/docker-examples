FROM netflixoss/genie-app:3.3.20

LABEL maintainer="tjveil@gmail.com"

ARG POSTGRESQL_JDBC_VERSION=42.2.14

COPY application-crdb.yml /usr/local/bin/application-crdb.yml

RUN apt-get update && apt-get install -y --no-install-recommends curl

RUN mkdir /home/.genie/lib

RUN curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o /home/.genie/lib/postgresql-jdbc.jar

EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/usr/local/bin/genie.jar", "--spring.profiles.active=crdb"]

