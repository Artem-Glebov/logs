#!/bin/bash

REPO_URL="https://github.com/Artem-Glebov/logs.git"
cd /opt/ || exit 1
git clone "$REPO_URL" || { echo "Error with clone repo"; exit 1; }
cd /opt/logs || exit 1

echo "Starting docker containers"
docker-compose up -d
MY_IP="$(curl 2ip.ru)"
echo "Done! Grafana available: http://$MY_IP:80 or http://localhost:80"