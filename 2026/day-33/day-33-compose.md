# Day 33 - Docker Compose: Multi-Container Applications

## Objective

Learn how Docker Compose simplifies the deployment and management of multi-container applications using a single YAML configuration file. Build a WordPress and MySQL application, understand Docker Compose networking, persistent storage, environment variables, and commonly used Compose commands.

---

## Prerequisites

- Docker Engine installed
- Docker Compose v2 installed
- Ubuntu EC2 Instance
- Basic Docker knowledge

---

## Technologies Used

- Docker
- Docker Compose
- MySQL 8.0
- WordPress
- Ubuntu EC2

---

# Task 1: Install & Verify Docker Compose

### Install Docker Compose

Installed Docker Compose v2 and configured it on the EC2 instance.

![Docker Compose Installation](images/01-1.1-installation.png)

---

### Verify Installation

Verified that both Docker Engine and Docker Compose were installed successfully.

![Docker Compose Verification](images/02-1.2-verification.png)

### Key Observation

- Docker Compose extends Docker by allowing multiple containers to be managed through a single configuration file.
- The installation was verified successfully.

---

# Task 2: Create the First Docker Compose Application

### Create the Compose Project

Created a new project directory named **compose-basics** and added a Docker Compose configuration for an Nginx container.

**Docker Compose File**

[compose-basics/docker-compose.yml](compose-basics/docker-compose.yml)

![Compose Basics](images/03-2.0-compose-basics.png)

---

### Deploy the Application

Started the Nginx application using Docker Compose.

Docker Compose automatically:

- Pulled the required image
- Created an isolated network
- Created the container
- Started the service

---

### Verify Browser Output

Verified that the Nginx web server was accessible from the browser.

![Browser Output](images/04-2.1-browser-output.png)

### Key Observation

- A single Compose file was enough to deploy the application.
- Docker Compose automatically created the required network.
- The container became accessible through the configured port.

---

# Task 3: Build a Two-Container WordPress Application

### Create the WordPress Project

Created a new Docker Compose project consisting of:

- WordPress
- MySQL

The MySQL container uses a named volume for persistent storage, while WordPress connects to MySQL through the Compose network.

**Docker Compose File**

[wordpress-mysql/docker-compose.yml](wordpress-mysql/docker-compose.yml)

![Create WordPress Project](images/05-3.1-created-dir-wordpress-mysql.png)

---

### Deploy the Multi-Container Application

Started both services together using Docker Compose.

![Compose Up](images/07-3.3-docker-up.png)

---

### Verify Running Containers

Verified that both WordPress and MySQL containers were running successfully.

![Running Containers](images/06-3.2-docker-ps.png)

---

### Verify Docker Network

Verified that Docker Compose automatically created a dedicated bridge network for the project.

![Docker Network](images/08-3.4-docker-network.png)

---

### Inspect Network Configuration

Inspected the automatically created network and confirmed that both containers were connected to the same network.

![Inspect Network](images/09-3.5-docker-network-inspect.png)

---

### Verify Persistent Storage

Verified that Docker Compose created a named volume for MySQL data persistence.

![Docker Volume](images/10-3.6-docker-volume.png)

---

### Verify Data Persistence

Stopped and recreated the application while confirming that the WordPress data remained available.

![Compose Up and Down](images/11-3.7-up-down.png)

---

### Configure WordPress

Completed the WordPress installation through the browser.

![WordPress Installation](images/11-3.8-setup-wordpress.png)

---

### Verify WordPress Dashboard

Successfully logged into the WordPress Admin Dashboard.

![WordPress Dashboard](images/12-3.8-browser-output.png)

### Key Observation

- Docker Compose created the network automatically.
- WordPress communicated with MySQL using the service name.
- Named volumes preserved database data even after recreating containers.
- Multi-container applications can be deployed with a single Compose configuration.

---

# Task 4: Docker Compose Commands

### Manage Compose Services

Practiced common Docker Compose operations including:

- Starting services
- Viewing running services
- Viewing logs
- Viewing service-specific logs
- Stopping services
- Restarting services
- Removing containers and networks

Verified the behavior of each operation successfully.

---

### Start Services

![Compose Up](images/13-4.1-up-in-detached-mode.png)

---

### View Logs

![Compose Logs](images/14-4.2-logs.png)

---

### View Service Logs

![WordPress Logs](images/15-4.3-logs-specific-service.png)

---

### Manage Services

Verified stop, start, restart, remove, and recreate operations.

![Compose Operations](images/16-4.4-other-operation-performing.png)

---

### Verify WordPress After Restart

Confirmed that the WordPress application remained accessible after restarting the services.

![Login Page](images/16-4.5-login-page.png)

### Key Observation

- Docker Compose simplifies container lifecycle management.
- Individual services can be managed independently.
- Application data remains available because of persistent volumes.
- Restarting services does not require rebuilding containers.

---

# Task 5: Environment Variables

### Create Environment File

Created a dedicated `.env` file to store sensitive database configuration values.

> The `.env` file is intentionally excluded from the repository because it contains credentials.

![Environment File](images/17-5.1-created-env-file.png)

---

### Update Compose Configuration

Modified the Docker Compose configuration to load variables from the `.env` file.

**Docker Compose File**

[wordpress-mysql-env/docker-compose.yml](wordpress-mysql-env/docker-compose.yml)

![Updated Compose File](images/18-5.2-edited-compose-file.png)

---

### Verify Environment Variables

Verified that Docker Compose successfully loaded the environment variables and started the application.

![Compose Configuration](images/19-5.3-compose-config.png)

---

### Validate Deployment

Confirmed that the application deployed successfully using the externalized configuration.

![Compose Deployment](images/20-5.4-up-down.png)

### Key Observation

- Sensitive configuration values were separated from the Compose file.
- Docker Compose automatically loaded variables from the `.env` file.
- The Compose configuration became cleaner, reusable, and easier to maintain.

---

# 🚀 Key Learnings

- Docker Compose simplifies multi-container deployments using a single YAML file.
- Services communicate automatically through the default Compose network.
- Docker Compose creates project-specific networks and volumes automatically.
- Named volumes ensure persistent database storage.
- WordPress can communicate with MySQL using the service name instead of an IP address.
- Docker Compose provides simple commands to start, stop, restart, inspect, and manage services.
- Environment variables improve security by separating sensitive configuration from application code.
- Docker Compose makes multi-container applications easier to deploy, manage, and reproduce.
