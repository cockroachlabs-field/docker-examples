####################################
#   Multi-stage build
#       1. build ycsb
#       2. build ycsb client
####################################

# Stage 1 - Build YCSB

FROM maven:3.5 as ycsb-builder

LABEL maintainer="tjveil@gmail.com"

ARG GIT_BRANCH=master

RUN mkdir -v /opt/ycsb \
    && git clone https://github.com/brianfrankcooper/YCSB.git /opt/ycsb \
    && cd /opt/ycsb \
    && git checkout -f ${GIT_BRANCH} \
    && mvn -pl site.ycsb:jdbc-binding -am clean package -DskipTests=true


# Stage 2 - Build YCSB client

FROM openjdk:8-jdk-slim

LABEL maintainer="tjveil@gmail.com"

ARG POSTGRESQL_JDBC_VERSION=42.2.12

RUN apt-get update \
    && apt-get install -y python curl \
    && mkdir -v /opt/ycsb

COPY --from=ycsb-builder  /opt/ycsb/jdbc/target/ycsb-jdbc-binding-*.tar.gz /opt/ycsb/ycsb.tar.gz

RUN tar -xvf /opt/ycsb/ycsb.tar.gz -C /opt/ycsb --strip-components=1 \
    && rm -rfv /opt/ycsb/ycsb.tar.gz \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o /opt/ycsb/lib/postgresql-jdbc.jar \
    && ln -s /opt/ycsb/lib/jdbc-binding-*.jar /opt/ycsb/lib/jdbc-binding.jar

COPY db.properties /opt/ycsb/conf/db.properties
COPY workload-a-cockroach /opt/ycsb/workloads/workload-a-cockroach
COPY workload-b-cockroach /opt/ycsb/workloads/workload-b-cockroach
COPY workload-c-cockroach /opt/ycsb/workloads/workload-c-cockroach
COPY workload-d-cockroach /opt/ycsb/workloads/workload-d-cockroach
COPY workload-e-cockroach /opt/ycsb/workloads/workload-e-cockroach
COPY workload-f-cockroach /opt/ycsb/workloads/workload-f-cockroach

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


