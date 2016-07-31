#!/bin/bash
# "neo4j" referred to below assumes this as the container name when the container is launched
#   with launch-neo4j.sh
docker stop neo4j
docker rm neo4j
docker build -t hermantolentino/docker-alpine-java:v1 -f Dockerfile-alpine-java .
docker build -t hermantolentino/docker-alpine-neo4j:v1 .
