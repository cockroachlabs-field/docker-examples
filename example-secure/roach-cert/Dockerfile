FROM debian:9.8-slim

# todo: make this a multi-stage build where simple final simple node is just a file server
# todo: see if i can fix the slowness.  is this  not specifying correct alias for create-node
# todo: should secure run under something than 8080


LABEL maintainer="tjveil@gmail.com"

ARG CRDB_DOWNLOAD_URL=https://binaries.cockroachdb.com/cockroach-latest.linux-amd64.tgz
ARG CRDB_DOWNLOAD_DIR=/tmp/crdb
ARG CRDB_HOME=/opt/crdb

ENV PATH=$CRDB_HOME:$PATH

# For deployment, we need
# libc6 - dynamically linked by cockroach binary
# wget - fetch binary
# ca-certificates - to authenticate TLS connections for telemetry and
#                   bulk-io with S3/GCS/Azure
# tzdata - for time zone functions
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y libc6 curl ca-certificates tzdata && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -pv $CRDB_DOWNLOAD_DIR \
    && mkdir -pv $CRDB_DOWNLOAD_DIR \
    && curl -fSL "$CRDB_DOWNLOAD_URL" -o /tmp/crdb.tgz \
    && tar -xvf /tmp/crdb.tgz -C $CRDB_DOWNLOAD_DIR --strip-components=1 \
    && mv -v $CRDB_DOWNLOAD_DIR /opt \
    && rm -rfv /tmp/crdb.tgz

RUN mkdir -pv /mnt/certs/ca /mnt/certs/client /mnt/certs/roach-0 /mnt/certs/roach-1 /mnt/certs/roach-2 /mnt/safe

RUN cockroach cert create-ca --certs-dir=/mnt/certs/ca --ca-key=/mnt/safe/ca.key \
    && cp -v /mnt/certs/ca/ca.crt /mnt/certs/client \
    && cp -v /mnt/certs/ca/ca.crt /mnt/certs/roach-0 \
    && cp -v /mnt/certs/ca/ca.crt /mnt/certs/roach-1 \
    && cp -v /mnt/certs/ca/ca.crt /mnt/certs/roach-2

RUN cockroach cert create-client root --certs-dir=/mnt/certs/client --ca-key=/mnt/safe/ca.key

RUN cp -v /mnt/certs/client/client.* /mnt/certs/roach-0 \
    && cp -v /mnt/certs/client/client.* /mnt/certs/roach-1 \
    && cp -v /mnt/certs/client/client.* /mnt/certs/roach-2

RUN cockroach cert create-node roach-0 172.22.0.100 localhost 127.0.0.1 lb 172.22.0.2 --certs-dir=/mnt/certs/roach-0 --ca-key=/mnt/safe/ca.key
RUN cockroach cert create-node roach-1 172.22.0.101 localhost 127.0.0.1 lb 172.22.0.2 --certs-dir=/mnt/certs/roach-1 --ca-key=/mnt/safe/ca.key
RUN cockroach cert create-node roach-2 172.22.0.102 localhost 127.0.0.1 lb 172.22.0.2 --certs-dir=/mnt/certs/roach-2 --ca-key=/mnt/safe/ca.key


