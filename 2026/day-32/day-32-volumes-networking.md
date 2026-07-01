# Day 32 - Docker Volumes & Networking

## Objective

Learn Docker data persistence using **Named Volumes** and **Bind Mounts**, understand Docker networking concepts, practice container communication, and build a multi-container application using custom networks and persistent storage.

---

# Task 1: The Problem (Container Data Loss)

### 1. Run a MySQL Container

Started a MySQL container and created a sample database with employee records.

![Run MySQL Container](images/01-1.1-run-mysql-container.png)

---

### 2. Create Sample Data

Created a table, inserted sample records, and verified the stored data.

![Create Database and Insert Records](images/02-1.2-created-table.png)

---

### 3. Remove the Container

Stopped and removed the MySQL container.

![Remove MySQL Container](images/03-1.3-stop-remove-container.png)

---

### 4. Create a New Container

Started a new MySQL container using the same image and verified whether the previous data still existed.

![Create New Container](images/04-1.4-new-container.png)

**Key Observation**

- User-created tables and records were lost.
- Containers do not preserve data after removal.
- Docker containers are **ephemeral** by default.

---

# Task 2: Named Volumes

### 1. Create a Docker Named Volume

Created a persistent Docker volume and verified it.

![Create Docker Volume](images/06-2.1-create-volume.png)

---

### 2. Run MySQL with the Volume

Started a MySQL container using the named volume.

![Run MySQL with Volume](images/07-2.2-run-volume-container.png)

---

### 3. Store Database Records

Created the employee table, inserted records, and verified the data.

![Insert Employee Records](images/08-2.3-create-data.png)

---

### 4. Remove the Container

Stopped and removed the database container while keeping the volume.

![Remove Container](images/09-2.4-remove-container.png)

---

### 5. Reuse the Same Volume

Started a new MySQL container using the existing named volume and verified the stored data.

![Verify Persistent Data](images/10-2.5-data-persisted.png)

**Key Observation**

- Docker volume remained after container removal.
- Database records persisted successfully.
- Named volumes provide persistent storage independent of containers.

---

# Task 3: Bind Mounts

### 1. Create a Website Directory

Created a local website directory and added an HTML page.

![Create Website Files](images/11-3.1-create-index.png)

---

### 2. Run an Nginx Container with a Bind Mount

Mounted the local website directory inside the Nginx container.

![Run Nginx Using Bind Mount](images/12-3.2-run-nginx-bind.png)

---

### 3. Access the Website

Verified that the website was served successfully through the browser.

![Open Website](images/13-3.3-browser.png)

---

### 4. Update the Website

Modified the HTML file on the host machine and refreshed the browser.

![Updated Website](images/14-3.4-updated-index.png)

**Key Observation**

- Host files were synchronized instantly.
- No container rebuild or restart was required.
- Bind mounts are ideal for development environments.

---

# Task 4: Docker Networking Basics

### 1. List Docker Networks

Listed all available Docker networks.

![List Docker Networks](images/15-4.1-network-list.png)

---

### 2. Inspect the Default Bridge Network

Verified containers attached to the default bridge network.

![Inspect Bridge Network](images/16-4.2-inspect-network.png)

---

### 3. Test Communication Using IP Address

Retrieved the container IP address and successfully pinged it.

---

### 4. Test Communication Using Container Name

Attempted to ping another container using its name.

![Default Bridge Network Communication](images/17-4.3-ping-ip.png)

**Key Observation**

- Containers communicated successfully using IP addresses.
- Name-based communication failed on the default bridge network.

---

# Task 5: Custom Networks

### 1. Create a Custom Bridge Network

Created a custom Docker bridge network named **my-app-net**.

![Create Custom Network](images/19-5.1-created-network-myappnet.png)

---

### 2. Run Containers on the Custom Network

Started two Alpine containers connected to the custom network.

![Run Containers on Custom Network](images/20-5.2-run-containers-myappnet.png)

---

### 3. Test Name-Based Communication

Verified communication between containers using container names.

![Ping by Container Name](images/21-5.3-ping.png)

**Key Observation**

- Docker automatically resolved container names.
- Containers communicated successfully without using IP addresses.
- User-defined bridge networks include Docker's embedded DNS service.

---

# Task 6: Put It Together

### 1. Create a Project Network and Volume

Created a custom network (**project-net**) and a named volume (**project-data**).

![Create Project Network](images/22-6.1-custome-network.png)

---

### 2. Run the Database Container

Started a MySQL database container attached to the custom network and persistent volume.

![Run Database Container](images/23-6.2-run-cotainer.png)

---

### 3. Run the Application Container

Started an Alpine application container on the same network and verified network configuration.

![Run Application Container](images/24-6.3-rub-other-container.png)

---

### 4. Verify Container Communication

Confirmed that the application container successfully communicated with the database container using its container name.

![Verify Container Communication](images/25-6.4-verifying-container.png)

---

### 5. Cleanup

Removed all containers, custom networks, and Docker volumes created during the lab.

![Docker Cleanup](images/26-6.4.1-cleanup.png)

---

# 🚀 Key Learnings

- Docker container data persistence
- Docker Named Volumes
- Docker Bind Mounts
- Docker Bridge Networks
- Custom Docker Networks
- Docker DNS and service discovery
- Container-to-container communication
- Multi-container application setup
- Docker resource cleanup
