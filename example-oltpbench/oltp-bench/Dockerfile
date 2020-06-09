####################################
#   Multi-stage build
#       1. build oltpbench
#       2. run oltpbench client
####################################

# Stage 1 - Build oltpbench

FROM maven:3-jdk-11 as benchmark-builder

LABEL maintainer="tjveil@gmail.com"

ARG GIT_BRANCH=maven

RUN mkdir -v /opt/oltpbench \
    && git clone https://github.com/timveil-cockroach/oltpbench.git /opt/oltpbench \
    && cd /opt/oltpbench \
    && git checkout -f ${GIT_BRANCH} \
    && mvn clean package -DskipTests=true


# Stage 2 - run oltpbench client

FROM openjdk:11-jdk-slim

LABEL maintainer="tjveil@gmail.com"

RUN apt-get update \
    && mkdir -v /opt/oltpbench

COPY --from=benchmark-builder  /opt/oltpbench/target/*.tgz /opt/oltpbench/oltpbench.tgz

RUN tar -xvf /opt/oltpbench/oltpbench.tgz -C /opt/oltpbench --strip-components=1 \
    && rm -rf /opt/oltpbench/oltpbench.tgz

COPY crdb_tpcc_config.xml /opt/oltpbench/config/crdb_tpcc_config.xml
COPY crdb_tpch_config.xml /opt/oltpbench/config/crdb_tpch_config.xml
COPY crdb_ycsb_config.xml /opt/oltpbench/config/crdb_ycsb_config.xml

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


