####################################
#   Multi-stage build
#       1. build oltpbench
#       2. build ycsb client
####################################

# Stage 1 - Build oltpbench

FROM frekele/ant:latest as benchmark-builder

ARG GIT_BRANCH=master

RUN mkdir -v /opt/oltpbench \
    && apt-get update \
    && apt-get install -y git \
    && git clone https://github.com/timveil-cockroach/oltpbench.git /opt/oltpbench \
    && cd /opt/oltpbench \
    && git checkout -f ${GIT_BRANCH} \
    && export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
    && ant


# Stage 2 - Build oltpbench client

FROM openjdk:8-jdk-slim

LABEL maintainer="tjveil@gmail.com"

ARG POSTGRESQL_JDBC_VERSION=42.2.5

RUN apt-get update \
    && apt-get install -y curl \
    && mkdir -v /opt/oltpbench

COPY --from=benchmark-builder  /opt/oltpbench /opt/oltpbench
#
#RUN tar -xvf /opt/ycsb/ycsb.tar.gz -C /opt/ycsb --strip-components=1 \
#    && rm -rfv /opt/ycsb/ycsb.tar.gz \
#    && curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o /opt/ycsb/lib/postgresql-jdbc.jar \
#    && ln -s /opt/ycsb/lib/jdbc-binding-*.jar /opt/ycsb/lib/jdbc-binding.jar
#
#COPY db.properties /opt/ycsb/conf/db.properties
#COPY workload-a-cockroach /opt/ycsb/workloads/workload-a-cockroach
#COPY workload-b-cockroach /opt/ycsb/workloads/workload-b-cockroach
#COPY workload-c-cockroach /opt/ycsb/workloads/workload-c-cockroach
#COPY workload-d-cockroach /opt/ycsb/workloads/workload-d-cockroach
#COPY workload-e-cockroach /opt/ycsb/workloads/workload-e-cockroach
#COPY workload-f-cockroach /opt/ycsb/workloads/workload-f-cockroach

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


