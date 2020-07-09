# Enterprise Backup with NGINX File Server
Demonstrates backing up a 3 node cluster to a remote file server using NGINX.  The relevant documentation can be found here:

* https://www.cockroachlabs.com/docs/stable/backup-and-restore.html
* https://www.cockroachlabs.com/docs/stable/backup.html
* https://www.cockroachlabs.com/docs/stable/create-a-file-server.html

## Services
* `crdb-0` - CockroachDB node
* `crdb-1` - CockroachDB node
* `crdb-2` - CockroachDB node
* `lb` - HAProxy acting as load balancer
* `fileserver` - NGINX acting as remote file server

## Getting started
1) because operation order is important, execute `./up.sh CRDB_ORG CRDB_LICENSE_KEY` instead of `docker-compose up` where `CRDB_ORG` is your CockroachDB Enterprise License Organization and `CRDB_LICENSE_KEY` is your CockroachDB Enterprise License Key.   
2) visit the CockroachDB UI @ http://localhost:8080
3) visit the HAProxy UI @ http://localhost:8081
4) run the following command to view the contents of the `backup` directory...  `docker exec -t fileserver ls -la /mnt/cockroach-backups/bank-backup`

## Helpful Commands

### Open Interactive Shells
```bash
docker-compose exec crdb-0 /bin/bash
docker-compose exec crdb-1 /bin/bash
docker-compose exec crdb-2 /bin/bash
docker-compose exec lb /bin/sh
docker-compose exec fileserver /bin/sh
```