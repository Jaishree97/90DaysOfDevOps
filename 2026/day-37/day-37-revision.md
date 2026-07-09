# Day 37 – Docker Revision & Cheat Sheet

---

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [can do ] Run a container from Docker Hub (interactive + detached)
- [can do ] List, stop, remove containers and images
- [can do ] Explain image layers and how caching works
- [can do ] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [can do ] Explain CMD vs ENTRYPOINT
- [can do ] Build and tag a custom image
- [can do ] Create and use named volumes
- [can do ] Use bind mounts
- [can do ] Create custom networks and connect containers
- [can do ] Write a docker-compose.yml for a multi-container app
- [can do ] Use environment variables and .env files in Compose
- [can do ] Write a multi-stage Dockerfile
- [can do ] Push an image to Docker Hub
- [can do ] Use healthchecks and depends_on

---

## Docker Quick-Fire Questions

### 1. What is the difference between an image and a container?
- **Image** = Blueprint or template of an application.
- **Container** = A running instance of that image.

> **Image = Recipe**  
> **Container = Cooked Food**

---

### 2. What happens to data inside a container when you remove it?
- The data is **deleted** with the container.
- To keep data, use **Docker Volumes**.

---

### 3. How do two containers on the same custom network communicate?
- They communicate using their **container names (or service names in Docker Compose)**.
- Docker provides built-in DNS for name resolution.

**Example:**
```bash
mongodb:27017
```

---

### 4. What does `docker compose down -v` do differently from `docker compose down`?

| Command | What it does |
|---------|--------------|
| `docker compose down` | Stops and removes containers and networks |
| `docker compose down -v` | Stops and removes containers, networks, and **volumes** (deletes stored data) |

---

### 5. Why are multi-stage builds useful?
- Create **smaller and more secure** Docker images.
- Remove unnecessary build dependencies.
- Improve build performance and deployment speed.

---

### 6. What is the difference between `COPY` and `ADD`?

| `COPY` | `ADD` |
|--------|-------|
| Copies local files only | Copies files and can extract `.tar` archives or download from URLs |
| Simple and recommended | Has extra features |

> **Best Practice:** Use `COPY` unless you specifically need `ADD`.

---

### 7. What does `-p 8080:80` mean?

It maps:

- **8080** → Port on your computer (Host)
- **80** → Port inside the container

```
Browser → localhost:8080 → Container:80
```

---

### 8. How do you check how much disk space Docker is using?

```bash
docker system df
```

For detailed usage:

```bash
docker system df -v
```

---

## Build Your Docker Cheat Sheet
Create `docker-cheatsheet.md` organized by category:
- **Container commands** — run, ps, stop, rm, exec, logs
- **Image commands** — build, pull, push, tag, ls, rm
- **Volume commands** — create, ls, inspect, rm
- **Network commands** — create, ls, inspect, connect
- **Compose commands** — up, down, ps, logs, build
- **Cleanup commands** — prune, system df
- **Dockerfile instructions** — FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, ENTRYPOINT

Keep it short — one line per command, something you'd actually reference on the job.

> **[Open Docker Command Cheat Sheet](../../docker/cheatsheet.md)**

---

## Revisit Weak Spots
Pick **2 topics** you marked as shaky and redo the hands-on tasks from that day.

#1 What is the difference between `CMD` and `ENTRYPOINT`?

| CMD | ENTRYPOINT |
|------|------------|
| Provides default arguments. | Defines the main executable. |
| Can be overridden easily. | Runs every time unless explicitly overridden. |

##2 What does `docker system prune` do?

It removes unused containers, networks, dangling images, and build cache. Adding `-a --volumes` also removes unused images and volumes.

---

## Suggested Flow (45–60 minutes)
- 10 min: go through the checklist honestly
- 10 min: answer quick-fire questions
- 20 min: build your cheat sheet
- 10 min: redo one weak area

---