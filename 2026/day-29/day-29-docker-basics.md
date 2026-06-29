# Day 29 – Introduction to Docker

---

# Task 1

## What is Docker?

Docker is an open-source containerization platform that packages applications along with their dependencies, making them portable and consistent across different environments.

## Why Docker?

- Consistent development environment
- Lightweight compared to Virtual Machines
- Fast deployment
- Easy application portability
- Simplifies CI/CD pipelines

---

## Containers vs Virtual Machines

| Feature | Virtual Machine | Container |
|----------|----------------|------------|
| Virtualization | Hardware Level | OS Level |
| Boot Time | Minutes | Seconds |
| Size | GBs | MBs |
| Performance | Slower | Faster |
| Isolation | Complete OS | Process Level |
| Portability | Limited | High |

---

## Docker Architecture

### Docker Client

The Docker Client is the command-line interface used to communicate with Docker.

Example Commands

```bash
docker build
docker run
docker pull
docker push
```

---

### Docker Daemon

The Docker daemon is the background service responsible for building, running and managing containers.

Responsibilities

- Build Images
- Run Containers
- Manage Networks
- Manage Volumes

---

### Docker Hub

Docker Hub is the public registry used to download and share Docker images.

It allows you to

- Pull Images
- Push Images
- Share Images

---

### Docker Registry

A Docker Registry stores Docker Images.

Examples

- Docker Hub
- Private Registry
- AWS ECR
- Azure Container Registry

---

# Task 2 – Install Docker

## Install Docker

```bash
sudo apt update

sudo apt install docker.io -y

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker $USER

newgrp docker
```

### Output

![](images/01-docker-install.png)

---

## Verify Docker

```bash
docker -v
```

![](images/02-docker-version.png)

---

## Run Hello World

```bash
docker run hello-world
```

![](images/03-hello-world.png)

---

### Output Explanation

- Docker searched the image locally.
- Pulled the image from Docker Hub.
- Created a container.
- Executed the application.
- Displayed the success message.

---

# Task 3 – Run Containers

## Run Nginx Container

```bash
docker run -d -p 80:80 nginx
```

![](images/04-nginx-container.png)

---

## Verify Running Containers

```bash
docker ps
```

![](images/05-docker-ps.png)

---

## Access Nginx in Browser

```
http://<Public-IP>:80
```

![](images/06-nginx-browser.png)

---

## Run Ubuntu Container

```bash
docker run -it ubuntu bash
```

![](images/07-ubuntu-container.png)

---

## Running Containers

```bash
docker ps
```

![](images/08-running-containers.png)

---

## List All Containers

```bash
docker ps -a
```

![](images/09-all-containers.png)

---

## Stop & Remove Container

```bash
docker stop <container-id>

docker rm <container-id>
```

![](images/10-stop-remove.png)

---

# Task 4 – Explore Docker Commands

## Run Container in Detached Mode

```bash
docker run -d ubuntu
```

![](images/11-detached-container.png)

---

## Create Named Container

```bash
docker run -d --name nginx -p 81:80 nginx
```

![](images/12-custom-container.png)

---

## View Container Logs

```bash
docker logs nginx
```

![](images/13-docker-logs.png)

---

## Execute Commands Inside Container

```bash
docker exec -it nginx bash
```

![](images/14-docker-exec.png)

---

## Copy File to Container

```bash
docker cp index.html nginx:/usr/share/nginx/html/index.html
```

![](images/15-docker-cp.png)

---

## Verify Custom Web Page

```
http://<Public-IP>:81
```

![](images/16-final-output.png)

---

# Commands Practiced

| Command | Description |
|----------|-------------|
| docker run | Create Container |
| docker ps | Running Containers |
| docker ps -a | All Containers |
| docker stop | Stop Container |
| docker rm | Remove Container |
| docker exec | Execute Inside Container |
| docker logs | View Logs |
| docker cp | Copy Files |
| docker images | List Images |

---

# Key Learnings

- Docker Installation
- Docker Architecture
- Docker Images
- Docker Containers
- Docker Hub
- Docker Registry
- Container Lifecycle
- Detached Mode
- Port Mapping
- Interactive Containers
- Docker Logs
- Docker Exec
- Docker Copy
