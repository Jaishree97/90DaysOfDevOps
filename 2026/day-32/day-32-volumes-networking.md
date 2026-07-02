# Day 32 - Docker Volumes & Networking

## Objective

Learn how Docker manages persistent data using Named Volumes and Bind Mounts, understand Docker networking concepts, enable container-to-container communication, and build a multi-container application using custom networks and persistent storage.

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

![Delete Containers](images/05-1.5-deleted-containers.png)

**Key Observation**

- User-created tables and records were lost.
- Containers do not preserve data after removal.
- Docker containers are **ephemeral** by default.

---

# Task 2: Named Volumes

### 1. Create a Docker Named Volume

Created a persistent Docker volume and verified it.

![Create Docker Volume](images/06-2.1-created-volume.png)

---

### 2. Run MySQL with the Volume

Started a MySQL container using the named volume.

![Run MySQL with Volume](images/07-2.2-run-container-attached-volume.png)

---

### 3. Store Database Records

Created the employee table, inserted records, and verified the data.

![Insert Employee Records](images/08-2.3.1-created-data.png)

---

### 4. Remove the Container

Stopped and removed the database container while keeping the volume.

![Remove Container](images/09-2.3.2-stop-remove-container.png)

---

### 5. Reuse the Same Volume

Started a new MySQL container using the existing named volume and verified the stored data.

![Reuse Named Volume](images/10-2.4-created-new-container-with-attached-volume.png)

**Key Observation**

- Docker volume remained after container removal.
- Database records persisted successfully.
- Named volumes provide persistent storage independent of containers.

---

# Task 3: Bind Mounts

### 1. Create a Website Directory

Created a local website directory and added an HTML page.

![Create Website Folder](images/11-3.1-created-folder.png)

---

### 2. Run an Nginx Container with a Bind Mount

Mounted the local website directory inside the Nginx container.

![Run Nginx Container](images/12-3.2-run-container.png)

---

### 3. Access the Website

Verified that the website was served successfully through the browser.

![Browser Output](images/13-3.3-browser-output.png)

---

### 4. Update the Website

Modified the HTML file on the host machine and refreshed the browser.

![Updated index.html](images/14-3.4.1-updated-indexfile.png)

![Updated Browser Output](images/15-3.4.2-updated-browser-output.png)

**Key Observation**

- Host files were synchronized instantly.
- No container rebuild or restart was required.
- Bind mounts are ideal for development environments.

---

# Task 4: Docker Networking Basics

### 1. List Docker Networks

Listed all available Docker networks.

![List Docker Networks](images/16-4.1-list-network.png)

---

### 2. Inspect the Default Bridge Network

Verified containers attached to the default bridge network.

![Inspect Bridge Network](images/17-4.2-inspect-network.png)

---

### 3. Test Communication Using IP Address

Retrieved the container IP address and successfully pinged it.

![Ping by IP and Name](images/18-4.3-run-by-name-ip.png)

---

### 4. Test Communication Using Container Name

Attempted to ping another container using its container name on the default bridge network. Docker could not resolve the container name because the default bridge network does not provide automatic DNS-based name resolution.

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

![Ping Using Container Name](images/21-5.3-ping.png)

**Key Observation**

- Docker automatically resolved container names.
- Containers communicated successfully without using IP addresses.
- User-defined bridge networks include Docker's embedded DNS service.

---

# Task 6: Build a Multi-Container Application

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

![Verify Communication](images/25-6.4-verifying-container.png)

---

### 5. Cleanup

Removed all containers, custom networks, and Docker volumes created during the lab.

![Cleanup](images/26-6.4.1-cleanup.png)

---

# Key Learnings

- Containers are ephemeral and lose data when removed.
- Docker Named Volumes provide persistent storage independent of containers.
- Bind Mounts synchronize host files directly with containers.
- Docker Bridge Networks enable container communication using IP addresses.
- User-defined Bridge Networks provide automatic DNS-based name resolution.
- Container names can be used instead of IP addresses on custom networks.
- Volumes and custom networks simplify multi-container application deployment.
- Cleaning up unused Docker resources helps maintain a healthy Docker environment.
