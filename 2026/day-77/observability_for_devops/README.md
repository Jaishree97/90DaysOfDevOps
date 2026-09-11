# Observability Stack for DevOps

Metrics, logs, and traces — one `docker compose up` away.

![Docker + cAdvisor Stack](assets/docker.png)
![NodeExporter Stack](assets/nodeexporter.png)

## What's in the box

```
Prometheus  ← scrapes ← Node Exporter, cAdvisor, OTEL Collector
Loki        ← pushes  ← Promtail (container logs)
OTEL        ← OTLP    → exports metrics to Prometheus
Grafana     → queries  → Prometheus + Loki (auto-provisioned)
Notes App   → demo workload
```

## Quick start

```bash
git clone https://github.com/yourusername/Observability-For-DevOps.git
cd Observability-For-DevOps
docker compose up -d
```

That's it. Open http://localhost:3000 (admin/admin).

## Endpoints

| Service | URL | What it does |
|---------|-----|--------------|
| Grafana | [:3000](http://localhost:3000) | Dashboards for metrics + logs |
| Prometheus | [:9090](http://localhost:9090) | Metrics store, check `/targets` |
| Loki | [:3100](http://localhost:3100) | Log aggregation backend |
| cAdvisor | [:8080](http://localhost:8080) | Container resource metrics |
| OTEL Collector | `:4317` gRPC / `:4318` HTTP | Send OTLP traces, metrics, logs |
| Notes App | [:8000](http://localhost:8000) | Sample Django app |

Node Exporter and Promtail run internally (no exposed ports needed).

## Sending traces to OTEL

The collector accepts OTLP on ports 4317 (gRPC) and 4318 (HTTP). Point your instrumented app at it:

```bash
# quick test
curl -X POST http://localhost:4318/v1/traces \
  -H 'Content-Type: application/json' \
  -d '{"resourceSpans":[{"resource":{"attributes":[{"key":"service.name","value":{"stringValue":"my-app"}}]},"scopeSpans":[{"spans":[{"traceId":"aaaabbbbccccddddaaaabbbbccccdddd","spanId":"aaaabbbbccccdddd","name":"test","kind":1,"startTimeUnixNano":"1000000000","endTimeUnixNano":"2000000000","status":{}}]}]}]}'
```

Metrics from OTLP get exported to Prometheus. Traces go to debug logs (swap in Jaeger/Tempo when ready).

## Project structure

```
.
├── docker-compose.yml
├── prometheus.yml                          # scrape config
├── otel-collector/otel-collector-config.yml
├── loki/loki-config.yml
├── promtail/promtail-config.yml
├── grafana/provisioning/
│   ├── datasources/datasources.yml         # Prometheus + Loki
│   └── dashboards/dashboards.yml           # drop JSON files in dashboards/json/
└── notes-app/                              # Django demo app
```

## Tear down

```bash
docker compose down          # stop everything
docker compose down -v       # stop + delete all data
```
