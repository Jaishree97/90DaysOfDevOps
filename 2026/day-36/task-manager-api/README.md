# 🚀 Task Manager API

A simple **Task Manager REST API** built with **Node.js**, **Express.js**, and **MongoDB**. The application is fully containerized using **Docker** and deployed with **Docker Compose** as part of the **90 Days of DevOps** challenge.

---

## 📌 What the Application Does

This application provides a REST API to manage tasks.

### Features

- Create a new task
- View all tasks
- Update an existing task
- Delete a task
- Store data in MongoDB
- Run the complete application using Docker Compose

---

## 🛠 Tech Stack

- Node.js
- Express.js
- MongoDB
- Docker
- Docker Compose

---

## 📁 Project Structure

```text
task-manager-api/
├── models/
│   └── Task.js
├── routes/
│   └── taskRoutes.js
├── views/
│   └── index.ejs
├── public/
│   └── style.css
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── package.json
├── package-lock.json
├── server.js
└── README.md
```

---

# ⚙ Environment Variables

Create a `.env` file in the project root.

```env
PORT=3000
MONGO_URI=mongodb://mongodb:27017/taskdb
```

| Variable | Description |
|----------|-------------|
| PORT | Port on which the application runs |
| MONGO_URI | MongoDB connection string used by the application |

---

# 🐳 Run with Docker Compose

## 1. Clone the Repository

```bash
git clone git@github.com:Jaishree97/90DaysOfDevOps.git
```

## 2. Navigate to the Project

```bash
cd 2026/day-36/task-manager-api
```

## 3. Build the Docker Image

```bash
docker compose build
```

## 4. Start the Application

```bash
docker compose up -d
```

## 5. Verify Running Containers

```bash
docker compose ps
```

Expected output:

```text
mongodb            Up (healthy)

task-manager-app   Up
```

## 6. View Application Logs

```bash
docker compose logs app
```

Expected output:

```text
MongoDB Connected
Server running on port 3000
```

---

# 🌐 Access the Application

Local

```
http://localhost:3000
```

EC2

```
http://<EC2-PUBLIC-IP>:3000
```

---

# 📡 Available API Endpoints

| Method | Endpoint | Description |
|---------|----------|-------------|
| GET | / | Home Page |
| GET | /tasks | Retrieve all tasks |
| POST | /tasks | Create a new task |
| PUT | /tasks/:id | Update a task |
| DELETE | /tasks/:id | Delete a task |

---

# 🧪 Example API Test

Create a Task

```bash
curl -X POST http://localhost:3000/tasks \
-H "Content-Type: application/json" \
-d '{"title":"Learn Docker","completed":false}'
```

Retrieve Tasks

```bash
curl http://localhost:3000/tasks
```

---

# 📦 Docker Hub Image

```text
jaishreechaure/task-manager-api:v1
```

Pull the image:

```bash
docker pull jaishreechaure/task-manager-api:v1
```

---

# 👩‍💻 Author

**Jaishree Chaure**

90 Days of DevOps Challenge
