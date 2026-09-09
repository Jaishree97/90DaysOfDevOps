# Day 75 -- Log Management with Loki and Promtail

## Task 1: Understand the Logging Pipeline

Before writing any config, understand how the pieces fit together:

```text
[Docker Containers]
       |
       | (write JSON logs to /var/lib/docker/containers/)
       v
  [Promtail]
       |
       | (reads log files, adds labels, pushes to Loki)
       v
    [Loki]
       |
       | (stores logs, indexes by labels)
       v
   [Grafana]
       |
       | (queries Loki with LogQL, displays logs)
       v
   [You]
```

Key differences from the ELK stack:
- Loki does **not** index the full text of logs -- it only indexes labels (like container name, job, filename)
- This makes Loki much cheaper to run and simpler to operate
- Think of it as "Prometheus, but for logs" -- same label-based approach

**Document:** Why does Loki only index labels instead of full text? What is the trade-off?

- Loki indexes **only labels** to keep storage and costs low.
- **Benefit**
  - Much **cheaper & faster ingestion**
  - Uses **less storage** than full-text indexing
- **Trade-off**
  - Log searches are **slower** (needs to scan log content)
  - Less powerful than full-text search systems

---

## Task 2: Add Loki to the Stack

Create the Loki configuration file.

```bash
mkdir -p loki
```

Create `loki/loki-config.yml`:
```yaml
auth_enabled: false

server:
  http_listen_port: 3100

common:
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory
  replication_factor: 1
  path_prefix: /loki

schema_config:
  configs:
    - from: 2020-10-24
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h

storage_config:
  filesystem:
    directory: /loki/chunks
```

**What this config does:**

- `auth_enabled: false` -- single-tenant mode, no authentication needed
- `store: tsdb` -- uses Loki's time-series database for indexing
- `object_store: filesystem` -- stores log chunks on local disk
- `replication_factor: 1` -- single instance, no replication (fine for learning)

Add Loki to your `docker-compose.yml`:
```yaml
  loki:
    image: grafana/loki:latest
    container_name: loki
    ports:
      - "3100:3100"
    volumes:
      - ./loki/loki-config.yml:/etc/loki/loki-config.yml
      - loki_data:/loki
    command: -config.file=/etc/loki/loki-config.yml
    restart: unless-stopped
```

Add `loki_data` to your volumes section:
```yaml
volumes:
  prometheus_data:
  grafana_data:
  loki_data:
```

Start Loki:
```bash
docker compose up -d loki
```

Verify Loki is running:
```bash
curl http://localhost:3100/ready
```

You should see `ready`, confirming that Loki is running and ready to receive logs.

![Task 2.1](./images/01-task-2.1-loki-ready.png)

---

## Task 3: Add Promtail to Collect Container Logs

Promtail is the log collection agent. It reads Docker container log files from the host and pushes them to Loki.

```bash
mkdir -p promtail
```

Create `promtail/promtail-config.yml`:
```yaml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:
  - job_name: docker
    static_configs:
      - targets:
          - localhost
        labels:
          job: docker
          __path__: /var/lib/docker/containers/*/*-json.log
    pipeline_stages:
      - docker: {}
```

**What this config does:**

- `positions` -- tracks which log lines have already been shipped (like a bookmark)
- `clients` -- where to send logs (Loki endpoint)
- `__path__` -- the glob pattern to find Docker JSON log files on the host
- `pipeline_stages: docker: {}` -- parses the Docker JSON log format and extracts timestamp, stream (stdout/stderr), and the log message

Add Promtail to your `docker-compose.yml`:
```yaml
  promtail:
    image: grafana/promtail:latest
    container_name: promtail
    volumes:
      - ./promtail/promtail-config.yml:/etc/promtail/promtail-config.yml
      - /var/lib/docker/containers:/var/lib/docker/containers:ro
      - /var/run/docker.sock:/var/run/docker.sock
    command: -config.file=/etc/promtail/promtail-config.yml
    restart: unless-stopped
```

**Why these volume mounts?**

- `/var/lib/docker/containers` -- where Docker stores container log files (read-only)
- `/var/run/docker.sock` -- lets Promtail discover container metadata (names, labels)

Restart the stack:

```bash
docker compose up -d
```

Generate some logs by hitting the notes app:

```bash
for i in $(seq 1 20); do curl -s http://localhost:8000 > /dev/null; done
```
This generates fresh container logs that Promtail can collect and send to Loki. The screenshot confirms that Promtail discovered the Docker containers and their labels.

![Task 3.1](./images/02-task-3.1-promtail-labels.png)

---

## Task 4: Add Loki as a Grafana Datasource

Loki needs to be added to Grafana so Grafana can query and visualize the logs collected by Promtail.

**Provision via YAML:**

Update `grafana/provisioning/datasources/datasources.yml`:
```yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
    editable: false

  - name: Loki
    type: loki
    access: proxy
    url: http://loki:3100
    editable: false
```

Restart Grafana to pick up the new datasource:

```bash
docker compose restart grafana
docker compose ps grafana
```
This applies the datasource configuration and makes Loki available to Grafana.

![Task 4.1](./images/03-task-4.1-grafana-restart-status.png) 

**Verify Loki in Grafana**

Open Grafana: `http://localhost:3000`

Then:
1. Go to **Connections > Data Sources**
2. If a duplicate **Prometheus** datasource exists, delete the duplicate and keep the correctly configured **Prometheus** datasource
3. Verify that both **Prometheus** and **Loki** are listed
4. Open **Loki**
5. Verify the URL is `http://loki:3100`
6. Click **Save & Test** if needed
7. Confirm that the Loki datasource is connected successfully

Grafana now shows both Loki and Prometheus, confirming that Loki was successfully connected as a datasource.

![Task 4.2](./images/04-task-4.2-grafana-datasources.png)

---

## Task 5: Query Logs with LogQL

LogQL is Loki's query language -- similar to PromQL but for logs.

Go to Grafana > Explore (compass icon). Select Loki as the datasource.

### 1. Stream Selector

filter logs by labels:

```logql
{job="docker"}
```
This returns logs from all Docker containers.

![Task 5.1](./images/05-task-5.1-loki-docker-logs.png) 

The same label-based approach can be used to focus on a specific container, such as `notes-app`.

![Task 5.2](./images/06-task-5.2-notes-app-logs.png)

This shows all Docker container logs.

### 2. Filter by container name:

Query logs from the Prometheus container:

```logql
{container_name="prometheus"}
```
This isolates Prometheus container logs.

![Task 5.3](./images/07-task-5.3-prometheus-logs.png) 

### 3. Keyword search

filter log lines by content:

```logql
{job="docker"} |= "error"
```
`|=` means "line contains". This finds all log lines with the word "error".

![Task 5.4](./images/08-task-5.4-loki-error-logs.png)

### 4. Negative filter:

```logql
{job="docker"} != "health"
```
This excludes lines containing `health`, which can be useful for filtering out health-check noise.

![Task 5.5](./images/09-task-5.5-loki-exclude-health.png) 

### 5. Regex filter:

```logql
{job="docker"} |~ "status=[45]\\d{2}"
```
This finds log lines containing HTTP 4xx or 5xx status codes.

![Task 5.6](./images/10-task-5.6-loki-status-filter.png) 

### 6. Log metric queries

count log lines over time:

```logql
count_over_time({job="docker"}[5m])
```
This counts log entries over a 5-minute window.

![Task 5.7](./images/11-task-5.7-loki-log-count.png)

### 7. Rate of logs per second:

```logql
rate({job="docker"}[5m])
```
This calculates the rate of log entries over a 5-minute window.

![Task 5.8](./images/12-task-5.8-loki-log-rate.png)

### 8. Top containers by log volume:

```logql
topk(5, sum by (container_name) (rate({job="docker"}[5m])))
```
This shows the top 5 containers by log rate.

![Task 5.9](./images/13-task-5.9-loki-top-containers.png)

**Exercise:** Write a LogQL query that finds all error logs from the notes-app container in the last 1 hour. Then write another query that counts how many error lines per minute.

**Filter `notes-app` logs for HTTP 500 responses:**

```bash
{container_name="notes-app"} |= "500"
```
This returns the matching HTTP 500 log lines from the `notes-app` container.

![Task 5.10](./images/14-task-5.10-notes-app-500-logs.png) 

**Then Count the 500 errors per minute:**

```bash
count_over_time({container_name="notes-app"} |= "500" [1m])
```
This converts the matching error logs into a time-series showing the number of 500 errors per minute.

![Task 5.11](./images/15-task-5.11-notes-app-500-errors.png)

---

## Task 6: Correlate Metrics and Logs in Grafana

The real power of observability is correlation -- seeing metrics and logs together.

1. **Add a logs panel to your dashboard:**

   - Open the dashboard you built on Day 74
   - Add a new panel
   - Select **Loki** as the datasource
   - Query: `{job="docker"}`
   - Visualization: **Logs**
   - Title: **Container Logs**

This adds container logs directly to the same dashboard as the existing metrics, making it easier to investigate issues from one place.

![Task 6.1](./images/16-task-6.1-devops-observability-dashboard.png)

2. **Use the Explore split view:**

   - Go to **Explore**
   - Click the **Split** button to open two panels side by side
   - Left panel: **Prometheus**
    - Query: `rate(container_cpu_usage_seconds_total{name="notes-app"}[5m])`
   - Right panel: **Loki**
    - Query: `{container_name="notes-app"}`
   - Use the same time range for both panels

This allows you to compare CPU usage with the corresponding `notes-app` logs on the same timeline.

![Task 6.2](./images/17-task-6.2-prometheus-loki-correlation.png) 

3. **Time sync:** Click on a spike in the metrics graph and both panels will zoom to that time range. This is how you debug in production -- you see a metric anomaly and immediately check the logs from that exact moment.

**Document:** How does having metrics and logs in the same tool (Grafana) help during incident response compared to checking separate systems?

- Having metrics and logs in the same tool helps because you can quickly go from seeing a problem in metrics to checking the related logs without switching systems.
- This makes troubleshooting faster during incidents.

---

## Comparison: Loki vs ELK Stack

**Loki vs ELK:**

- **Loki** → best for **cheap, simple, high-volume logging** tied to services (works great with Grafana/Prometheus). Limited full-text search, relies on labels.
- **ELK Stack (Elasticsearch + Logstash + Kibana)** → best for **powerful full-text search, deep log analysis, and security/audit use cases**, but heavier and more expensive to run.

---

## Logging Architecture

This diagram shows how Docker container logs flow through Promtail → Loki → Grafana, from log collection and label-based storage to querying and visualization.

![architecture-diagram](./images/architecture-diagram.png)