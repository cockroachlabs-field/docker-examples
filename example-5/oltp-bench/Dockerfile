####################################
#   Multi-stage build
#       1. build oltpbench
#       2. build oltpbench client
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
    && ant


# Stage 2 - Build oltpbench client

FROM openjdk:8-jdk-slim

LABEL maintainer="tjveil@gmail.com"

RUN apt-get update \
    && apt-get install -y curl \
    && mkdir -v /opt/oltpbench

COPY --from=benchmark-builder  /opt/oltpbench /opt/oltpbench

COPY crdb_tpcc_config.xml /opt/oltpbench/config/crdb_tpcc_config.xml
COPY crdb_ycsb_config.xml /opt/oltpbench/config/crdb_ycsb_config.xml

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


