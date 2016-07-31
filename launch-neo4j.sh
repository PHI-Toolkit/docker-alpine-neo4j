#!/bin/bash
# See reference for environment variables that can be passed through docker run here:
#   https://neo4j.com/developer/docker-30/
docker run -itd \
-v $(pwd)/data:/data \
-p 0.0.0.0:7474:7474 \
-p 0.0.0.0:7473:7473 \
-p 0.0.0.0:7687:7687 \
-p 0.0.0.0:1337:1337 \
--env=NEO4J_AUTH=none \
--name neo4j \
hermantolentino/docker-alpine-neo4j:v1
