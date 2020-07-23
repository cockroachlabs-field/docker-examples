#!/bin/bash

docker rmi example-netflix-genie_genie

docker rmi -f $(docker images -a -q "netflixoss/*")
