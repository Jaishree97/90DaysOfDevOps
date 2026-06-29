# Day 29 – Introduction to Docker

---

# Task 1: What is Docker?

Research and write short notes on:

- What is a container and why do we need them?
- Containers vs Virtual Machines — What's the real difference?
- What is the Docker architecture? (Client, Daemon, Images, Containers, Registry)
- Draw or describe the Docker architecture.

---

## What is a Container?

A **container** is a lightweight, isolated runtime environment that packages an application along with all its dependencies, libraries, and configuration files.

### Why do we need Containers?

- Eliminates **"Works on my machine"** problems.
- Provides consistent environments across Development, Testing, and Production.
- Lightweight and starts within seconds.
- Uses fewer system resources than Virtual Machines.
- Makes application deployment fast and portable.

---

## Containers vs Virtual Machines

| Feature | Containers | Virtual Machines |
|----------|------------|------------------|
| Virtualization | OS-level | Hardware-level |
| Operating System | Shares Host OS | Separate Guest OS |
| Startup Time | Seconds | Minutes |
| Size | MBs | GBs |
| Performance | Faster | Slower |
| Resource Usage | Low | High |
| Isolation | Process Level | Full OS Isolation |
| Portability | High | Moderate |
| Best Use Case | Microservices, CI/CD | Multiple Operating Systems |

---

# Docker Architecture

Docker consists of five main components.

## Docker Client

### What is it?

The Docker Client is the command-line interface (CLI) used to communicate with Docker.

### Example Commands

```bash
docker build
docker run
docker pull
docker push
docker ps
```

---

## Docker Daemon

### What is it?

The Docker Daemon (`dockerd`) is the background service responsible for managing Docker resources.

### Responsibilities

- Builds Docker images
- Creates containers
- Starts and stops containers
- Manages networks
- Manages volumes

---

## Docker Images

### What is it?

A Docker Image is a **read-only template** used to create Docker containers.

### Characteristics

- Immutable
- Contains application code
- Includes dependencies
- Stores configuration files

---

## Docker Containers

### What is it?

A Docker Container is a **running instance of a Docker Image**.

### Characteristics

- Lightweight
- Isolated
- Portable
- Can be started or stopped anytime

---

## Docker Registry

### What is it?

A Docker Registry stores Docker Images.

### Types

- **Public Registry** → Docker Hub
- **Private Registry** → Enterprise Registries

### Usage

- Pull images
- Push images
- Share images with teams

---

# Docker Architecture Diagram

```text
                +----------------------+
                |    Docker Client     |
                | (docker commands)    |
                +----------+-----------+
                           |
                           | Docker API
                           ▼
                +----------------------+
                |    Docker Daemon     |
                |      (dockerd)       |
                +----------+-----------+
                           |
         +-----------------+-----------------+
         |                                   |
         ▼                                   ▼
+---------------------+             +----------------------+
|    Docker Images    |             | Docker Containers    |
+---------------------+             +----------------------+
                           |
                           ▼
                +----------------------+
                |   Docker Registry    |
                |     Docker Hub       |
                +----------------------+
```

---
# Task 2: Install Docker

Install Docker on an Ubuntu EC2 instance, verify the installation, and run the first Docker container.

---

## Step 1: Verify Docker Installation

Initially, Docker commands returned a permission error because the current user was not added to the Docker group.

### Commands

```bash
sudo usermod -aG docker $USER
newgrp docker
docker -v
docker ps
```

### Output

<img src="./images/01-2.1-docker-version.png" width="900">

---

## Step 2: Run the Hello World Container

Pull and run Docker's official **hello-world** image to verify that Docker is working correctly.

### Command

```bash
docker run hello-world
```

### Output

<img src="./images/02-2.3-hello-world.png" width="900">

---

## What Happened?

When the `hello-world` container was executed, Docker performed the following steps:

1. Checked for the image locally.
2. Downloaded the image from Docker Hub.
3. Created a new container from the image.
4. Started the container.
5. Executed the application inside the container.
6. Displayed the success message and exited.

---
# Task 3: Run Real Containers

---

## 1. Run an Nginx Container and Access It in the Browser

Created an Nginx container and exposed it on **Port 80**. Verified that the web server was running successfully by accessing the EC2 Public IP from a web browser.

### Container

<img src="./images/04-3.1-nginx-80-80.png" width="900">

### Browser Output

<img src="./images/03-3.0-nginx.png" width="900">

---

## 2. Run an Ubuntu Container in Interactive Mode

Launched an Ubuntu container and explored it like a lightweight Linux machine.

Verified:

- Updated package repository
- Checked current user
- Listed directories
- Verified shell environment
- Exited the container

<img src="./images/05-3.2-ubuntu.png" width="900">

---

## 3. List Running Containers

Displayed all currently running Docker containers.

<img src="./images/06-3.3-docker-ps.png" width="900">

---

## 4. List All Containers

Displayed all Docker containers, including running and stopped containers.

<img src="./images/07-3.4-all-containers.png" width="900">

---

## 5. Stop and Remove a Container

Stopped the running container and removed it from the Docker host.

<img src="./images/08-3.5-stop-remove.png" width="900">

---
