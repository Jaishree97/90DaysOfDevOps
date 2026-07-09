# Task Manager API — Dockerized with Node.js & MongoDB

A simple **Task Manager REST API** built with **Node.js**, **Express.js**, and **MongoDB**. The application is fully containerized using **Docker** and orchestrated with **Docker Compose** as part of the **90 Days of DevOps** challenge.

![Node.js](https://img.shields.io/badge/Node.js-22-green)
![Express](https://img.shields.io/badge/Express-4.x-black)
![MongoDB](https://img.shields.io/badge/MongoDB-8-green)
![Docker](https://img.shields.io/badge/Docker-Ready-blue)
![Docker Compose](https://img.shields.io/badge/Docker%20Compose-v2-blue)

---

# What the Application Does

This application provides a REST API for managing tasks.

### Features

- Create new tasks
- Retrieve all tasks
- Update existing tasks
- Delete tasks
- Store task data in MongoDB
- Deploy the complete application using Docker Compose

---

# Tech Stack

| Component | Technology |
|-----------|------------|
| Runtime | Node.js 22 |
| Framework | Express.js |
| Database | MongoDB 8 |
| Containerization | Docker |
| Orchestration | Docker Compose v2 |

---

# Project Structure

```text
task-manager-api/
│
├── models/
│   └── Task.js
│
├── routes/
│   └── taskRoutes.js
│
├── views/
│   └── index.ejs
│
├── public/
│   └── style.css
│
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .gitignore
├── package.json
├── package-lock.json
├── server.js
└── README.md
```

---

# Application Architecture

```text
              Client
                 │
           Port 3000
                 │
      Node.js + Express API
                 │
        Docker Container
                 │
       Docker Bridge Network
                 │
        MongoDB Container
                 │
      Persistent Docker Volume
```

---

# Prerequisites

Before running the project, make sure you have:

- Git
- Docker Engine
- Docker Compose v2

---

# Environment Variables

Create a `.env` file in the project root.

```env
PORT=3000
MONGO_URI=mongodb://mongodb:27017/taskdb
```

| Variable | Description |
|----------|-------------|
| PORT | Port used by the application |
| MONGO_URI | MongoDB connection string |

---

# Dockerfile Highlights

This project uses a **multi-stage Docker build**.

### Builder Stage

- Uses Node.js Alpine image
- Installs project dependencies
- Copies application source code

### Production Stage

- Uses lightweight Alpine image
- Copies only required application files
- Creates a non-root user
- Runs the application securely

### Benefits

- Smaller production image
- Faster deployments
- Better security
- Improved layer caching

---

# Docker Compose Services

The application consists of two containers.

## Application

- Node.js
- Express.js
- Port 3000

## Database

- MongoDB 8
- Persistent Docker Volume
- Healthcheck using `mongosh`

Docker Compose also creates:

- Custom Docker Network
- Named Docker Volume

---

# Quick Start

## 1. Clone the Repository

```bash
git clone git@github.com:Jaishree97/90DaysOfDevOps.git
```

## 2. Navigate to the Project

```bash
cd 2026/day-36/task-manager-api
```

## 3. Build the Docker Images

```bash
docker compose build
```

## 4. Start the Application

```bash
docker compose up -d
```

---

# Verify Running Containers

```bash
docker compose ps
```

Expected output:

```text
mongodb             Up (healthy)
task-manager-app    Up
```

---

# View Application Logs

```bash
docker compose logs app
```

Expected output:

```text
MongoDB Connected
Server running on port 3000
```

---

# Access the Application

Local

```
http://localhost:3000
```

EC2

```
http://<EC2-PUBLIC-IP>:3000
```

---

# API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | / | Home Page |
| GET | /tasks | Retrieve all tasks |
| POST | /tasks | Create a task |
| PUT | /tasks/:id | Update a task |
| DELETE | /tasks/:id | Delete a task |

---

# API Testing

## Get All Tasks

```bash
curl http://localhost:3000/tasks
```

## Create Task

```bash
curl -X POST http://localhost:3000/tasks \
-H "Content-Type: application/json" \
-d '{"title":"Learn Docker","completed":false}'
```

## Update Task

```bash
curl -X PUT http://localhost:3000/tasks/<TASK_ID> \
-H "Content-Type: application/json" \
-d '{"completed":true}'
```

## Delete Task

```bash
curl -X DELETE http://localhost:3000/tasks/<TASK_ID>
```

---

# Docker Hub

Repository

```text
jaishreechaure/task-manager-api
```

Image

```text
jaishreechaure/task-manager-api:v1
```

Pull the image

```bash
docker pull jaishreechaure/task-manager-api:v1
```

---

# Deployment Verification

The published Docker image was verified by:

- Pulling the image from Docker Hub
- Starting containers using Docker Compose
- Connecting successfully to MongoDB
- Verifying the REST API endpoints

---

# Docker Best Practices Used

- Multi-stage Docker Build
- Alpine Linux Base Image
- Non-root User
- Docker Compose
- Custom Docker Network
- Named Docker Volume
- MongoDB Healthcheck
- Environment Variables
- Lightweight Production Image

---

# Learning Outcomes

Through this project I learned:

- Building Docker images
- Multi-stage Docker builds
- Docker Compose orchestration
- MongoDB containerization
- Docker networking and service communication
- Persistent Docker volumes
- Container healthchecks
- Publishing Docker images to Docker Hub
- Production-style deployments
- Container troubleshooting
