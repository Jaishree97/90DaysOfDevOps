# Task Manager API - Dockerized Application

## Project Overview

This project is a simple Task Manager API built with **Node.js**, **Express**, and **MongoDB**. The application has been containerized using **Docker** and deployed with **Docker Compose**.

---

## Tech Stack

- Node.js
- Express.js
- MongoDB
- Docker
- Docker Compose

---

## Project Structure

```
task-manager-api/
├── models/
├── routes/
├── public/
├── views/
├── server.js
├── package.json
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
└── README.md
```

---

## Features

- Create Task
- Get Tasks
- Update Task
- Delete Task
- MongoDB Database
- Dockerized Application
- Multi-stage Docker Build
- Non-root User
- Docker Compose Deployment

---

## Build Docker Image

```bash
docker compose build
```

---

## Run Application

```bash
docker compose up -d
```

---

## Verify

```bash
docker compose ps
```

---

## Test APIs

### Get Tasks

```
GET /tasks
```

### Create Task

```
POST /tasks
```

### Update Task

```
PUT /tasks/:id
```

### Delete Task

```
DELETE /tasks/:id
```

---

## Docker Hub Image

```
jaishreechaure/task-manager-api:v1
```

---

## Author

**Jaishree Chaure**
