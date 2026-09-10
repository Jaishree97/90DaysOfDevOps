# Django + Prometheus Monitoring Integration — Fix Guide

This guide documents how to integrate Prometheus monitoring into the Django Notes App and resolve the `/metrics` endpoint issue that causes Prometheus scraping errors such as:

```text
Error scraping target: server returned HTTP status 404 Not Found
```
## Why This Happens

The Django Notes App can be running correctly while Prometheus reports the target as `DOWN`.

The reason is that the application does not expose the Prometheus `/metrics` endpoint by default.

- Django application is running
- API endpoints are working
- Prometheus can reach the application
- `/metrics` endpoint is missing

---

## Root Cause

The application requires:

- `django-prometheus` integration
- Prometheus middleware configuration
- `/metrics` endpoint configuration

---

## Solution

### 1. Install `django-prometheus`

Add the following dependency to:

```text
notes-app/requirements.txt
```
```text
django-prometheus
```
### 2. Update Django Settings

Edit:

```text
notes-app/notesapp/settings.py
```
Add `django_prometheus` to `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    'django_prometheus',       # MUST be FIRST (important for instrumentation)

    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'api.apps.ApiConfig',
    'rest_framework',
    'corsheaders',
]
```
### 3. Configure Prometheus Middleware

Add the Prometheus middleware at the beginning and end of `MIDDLEWARE`:

```python
MIDDLEWARE = [
    'django_prometheus.middleware.PrometheusBeforeMiddleware',    # MUST be FIRST

    'django.middleware.security.SecurityMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',

    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',

    'django_prometheus.middleware.PrometheusAfterMiddleware',      # MUST be LAST
]
```
### 4. Expose `/metrics` Endpoint

Edit:

```text
notes-app/notesapp/urls.py
```
Add the Prometheus URL configuration:

```python
from django.contrib import admin
from django.urls import path, include
from django.views.generic import TemplateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
    path('', TemplateView.as_view(template_name='index.html')),
    path('', include(django_prometheus_urls)),
]
```
> **django-prometheus provides the `/metrics` Django view through `django_prometheus.urls`.**

### 5. Rebuild the Application

From the `observability-stack` directory:

```bash
docker compose up -d --build
```
Check the containers:

```bash
docker ps
```
Expected:

```text
notes-app
prometheus
```

### 6. Test the Metrics Endpoint

```bash
curl http://localhost:8000/metrics
```
Expected output should contain Prometheus-formatted metrics such as:

```ini
# HELP django_http_requests_total ...
# TYPE django_http_requests_total counter
...
```
> **The `django-prometheus` middleware exposes HTTP request/response metrics for the Django application.**

### 7. Verify the Prometheus Target

Open:

```bash
http://localhost:9090/targets
```
The `notes-app` target should show:

```text
up
```
Expected endpoint:

```bash
http://notes-app:8000/metrics
```
---

## Result

The Django Notes App is now instrumented with Prometheus metrics and can be successfully scraped by the Prometheus server.

```text
Django Notes App
       │
       │ /metrics
       ▼
Prometheus
       │
       ▼
TSDB
```
---

## Key Takeaway

A running application is not automatically a Prometheus-monitored application.

Prometheus requires an exposed metrics endpoint—typically `/metrics`—or an exporter/collector that translates application telemetry into Prometheus-compatible metrics.
