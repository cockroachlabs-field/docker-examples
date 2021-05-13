#!/bin/bash

docker compose up --no-start

docker compose start roach-cert

sleep 5

docker compose start roach-0

sleep 5

docker compose start roach-1
docker compose start roach-2
docker compose start lb

sleep 5

docker compose start roach-init