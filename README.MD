# Prometheus/Grafana and Docker Logs Aggregation
This is an easy setup to monitor your docker containers logs
## What it contains
- Prometheus
- Grafana
- Node-exporter
- Filebeat (beat-exporter) to collect docker logs
## How to start
```
cd /opt/
git clone https://github.com/Artem-Glebov/logs.git
cd /opt/logs/
docker-compose up -d
```
Or just use setup.sh

Grafana will be available at http://<your_ip>:80

The status of jobs at Prometheus http://<your_ip>:9090/targets

## How to inspect docker containers logs locally
```
tail -f /var/log/test*.ndjson
```
Or use **jq** to sort by a container name:
```
tail -F /var/log/test*.ndjson | jq 'select(.container.name == "grafana")'
```
or only messages 
```
tail -F /var/log/test*.ndjson | jq 'select(.container.name == "grafana") | .message'
```
## Prometheus metrics 
To see metrics from Prometheus add a prometheus datasource in grafana as http://prometheus:9090

Now in "Explore" you can see metrics from filebeat by job "beat-exporter". 

Example: **filebeat_filebeat_events{job="beats-exporter"}**

Or use job "node-exporter" to get metrics from host. Examples:

CPU usage: **node_load1{job="node-exporter"}**

CPU usage by time: **100 - rate(node_cpu_seconds_total{mode="idle"}[5m])**

## Install local Filebeat by Ansible
Just run
```
ansible-playbook deploy_filebeat.yml
```
It automatically determines your architecture (aarch64 or amd64) and installs Filebeat locally. Then you can view Docker logs.
```
tail -f /var/log/test*.ndjson
```
Or use **jq** to sort by a container name:
```
tail -F /var/log/test*.ndjson | jq 'select(.container.name == "grafana")'
```
or only messages 
```
tail -F /var/log/test*.ndjson | jq 'select(.container.name == "grafana") | .message'
```