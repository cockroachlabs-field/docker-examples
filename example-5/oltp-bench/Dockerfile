####################################
#   Multi-stage build
#       1. build oltpbench
#       2. build oltpbench client
####################################

# Stage 1 - Build oltpbench

FROM maven:3-jdk-8 as benchmark-builder

ARG GIT_BRANCH=maven

RUN mkdir -v /opt/oltpbench \
    && git clone https://github.com/timveil-cockroach/oltpbench.git /opt/oltpbench \
    && cd /opt/oltpbench \
    && git checkout -f ${GIT_BRANCH} \
    && mvn clean package -DskipTests=true


# Stage 2 - Build oltpbench client

FROM openjdk:8-jdk-slim

LABEL maintainer="tjveil@gmail.com"

RUN apt-get update \
    && mkdir -v /opt/oltpbench

COPY --from=benchmark-builder  /opt/oltpbench/target/*.tgz /opt/oltpbench/oltpbench.tgz

RUN tar -xvf /opt/oltpbench/oltpbench.tgz -C /opt/oltpbench --strip-components=1 \
    && rm -rf /opt/oltpbench/oltpbench.tgz

COPY crdb_auctionmark_config.xml/opt/oltpbench/config/crdb_auctionmark_config.xml
COPY crdb_chbenchmark_config.xml/opt/oltpbench/config/crdb_chbenchmark_config.xml
COPY crdb_chbenchmark_mixed_config.xml/opt/oltpbench/config/crdb_chbenchmark_mixed_config.xml
COPY crdb_epinions_config.xml/opt/oltpbench/config/crdb_epinions_config.xml
COPY crdb_linkbench_config.xml/opt/oltpbench/config/crdb_linkbench_config.xml
COPY crdb_noop_config.xml/opt/oltpbench/config/crdb_noop_config.xml
COPY crdb_resourcestresser_config.xml/opt/oltpbench/config/crdb_resourcestresser_config.xm
COPY crdb_seats_config.xml/opt/oltpbench/config/crdb_seats_config.xml
COPY crdb_sibench_config.xml/opt/oltpbench/config/crdb_sibench_config.xml
COPY crdb_smallbank_config.xml/opt/oltpbench/config/crdb_smallbank_config.xml
COPY crdb_tatp_config.xml/opt/oltpbench/config/crdb_tatp_config.xml
COPY crdb_tpcc_config.xml/opt/oltpbench/config/crdb_tpcc_config.xml
COPY crdb_tpcds_config.xml/opt/oltpbench/config/crdb_tpcds_config.xml
COPY crdb_tpch_config.xml/opt/oltpbench/config/crdb_tpch_config.xml
COPY crdb_twitter_config.xml/opt/oltpbench/config/crdb_twitter_config.xml
COPY crdb_voter_config.xml/opt/oltpbench/config/crdb_voter_config.xml
COPY crdb_wikipedia_config.xml/opt/oltpbench/config/crdb_wikipedia_config.xml
COPY crdb_ycsb_config.xml/opt/oltpbench/config/crdb_ycsb_config.xml

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


