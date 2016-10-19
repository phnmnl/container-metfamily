#!/bin/sh

docker-compose up -d
curl -H Host:metfamily.docker.localhost http://localhost:80

