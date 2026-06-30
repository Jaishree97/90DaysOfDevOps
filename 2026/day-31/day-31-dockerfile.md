# Day 31 – Dockerfile: Build Your Own Images

## Objective

Learn how to write Dockerfiles, build custom Docker images, understand Dockerfile instructions, compare **CMD** and **ENTRYPOINT**, deploy a static website using **Nginx**, use **.dockerignore**, and optimize builds using **Docker layer caching**.

---

# Task 1: Your First Dockerfile

## Steps Performed

### Step 1: Created the Project Directory
Created the **my-first-image** directory for the Docker project.

### Step 2: Created the Dockerfile
Configured a Dockerfile using:
- Ubuntu as the base image
- Installed `curl`
- Added a default command using `CMD`

### Dockerfile

➡️ [my-first-image/Dockerfile](./my-first-image/Dockerfile)

### Step 3: Built the Docker Image

Successfully built the custom Docker image.

### Step 4: Ran the Container

Verified the container executed successfully.

### Result

- Image built successfully (`my-ubuntu:v1`)
- Default message displayed as expected

![Dockerfile](images/01-my-first-image-docker-file.png)

![Output](images/02-1.4-run-my-ubuntu.png)

---

# Task 2: Dockerfile Instructions

## Steps Performed

### Step 1: Created the Dockerfile

Implemented the following Dockerfile instructions.

### Dockerfile

➡️ [dockerfile-demo/Dockerfile](./dockerfile-demo/Dockerfile)

### HTML File

➡️ [dockerfile-demo/index.html](./dockerfile-demo/index.html)

### Step 2: Dockerfile Instructions Used

| Instruction | Purpose |
|-------------|---------|
| `FROM` | Selects the base image |
| `RUN` | Executes commands during image build |
| `COPY` | Copies files into the image |
| `WORKDIR` | Sets the working directory |
| `EXPOSE` | Documents the application port |
| `CMD` | Defines the default container command |

### Step 3: Built the Image

Successfully built the Docker image.

### Step 4: Started the Container

Ran the Nginx container successfully.

### Step 5: Verified in Browser

Accessed the application through the browser.

### Result

- Docker image created successfully
- Container started successfully
- Application served using Nginx

![Dockerfile Demo](images/03-2.1-dockerfile.demo.png)

![Build & Run](images/04-2.2-build-run-docker-demo.png)

![Browser Output](images/05-2.3-browser-output.png)

---

# Task 3: CMD vs ENTRYPOINT

## Steps Performed

### Step 1: Created Dockerfile using CMD

➡️ [cmd-vs-entrypoint/Dockerfile.cmd](./cmd-vs-entrypoint/Dockerfile.cmd)

### Step 2: Created Dockerfile using ENTRYPOINT

➡️ [cmd-vs-entrypoint/Dockerfile.entrypoint](./cmd-vs-entrypoint/Dockerfile.entrypoint)

### Step 3: Compared Both Instructions

| CMD | ENTRYPOINT |
|------|------------|
| Provides a default command | Defines the main executable |
| Can be overridden | Always executes first |
| Suitable for optional commands | Suitable for fixed application startup |

### Result

Successfully verified the runtime behavior of **CMD** and **ENTRYPOINT**.

![CMD Demo](images/06-3.1-cmd-demo.png)

![ENTRYPOINT Demo](images/07-3.2-entry-demo.png)

---

# Task 4: Build a Simple Web Application

## Steps Performed

### Step 1: Created Static HTML Page

Created an `index.html` file.

### Step 2: Created Dockerfile

➡️ [nginx-demo/Dockerfile](./nginx-demo/Dockerfile)

### HTML File

➡️ [nginx-demo/index.html](./nginx-demo/index.html)

### Step 3: Built the Docker Image

Successfully built the custom Nginx image.

### Step 4: Started the Container

Mapped the required port and started the container.

### Step 5: Verified in Browser

Successfully accessed the webpage.

### Result

- Custom Nginx image created
- Container running successfully
- Website accessible from the browser

![Website Build](images/08-4.1-my-website-v1.png)

![Browser Output](images/09-4.2-browser-output.png)

---

# Task 5: Using .dockerignore

## Steps Performed

### Step 1: Created the .dockerignore File

Configured a `.dockerignore` file.

➡️ [nginx-demo/.dockerignore](./nginx-demo/.dockerignore)

### Step 2: Added Ignore Rules

Ignored the following files and directories:

- `node_modules`
- `.git`
- `*.md`
- `.env`

### Step 3: Rebuilt the Docker Image

Verified that ignored files were excluded from the build context.

### Result

Successfully reduced the Docker build context.

![Docker Ignore](images/10-5.1-my-website-v2.png)

---

# Task 6: Docker Layer Caching

## Steps Performed

### Step 1: Built the Initial Image

Created the initial Docker image.

### Step 2: Modified the Application

Updated the application source.

### Step 3: Rebuilt the Image

Observed Docker layer caching during rebuild.

### Key Observations

- Docker builds images layer by layer.
- Every Dockerfile instruction creates a new layer.
- Unchanged layers are reused from cache.
- Modified layers are rebuilt.
- Proper instruction ordering improves build performance.

### Result

Successfully demonstrated Docker layer caching and build optimization.

![Initial Build](images/11-6.1-creating-cache.png)

![Rebuild](images/12-6.2-rebuilding-it.png)

![Optimized Website](images/13-6.3-browser-output.png)

---

# Key Takeaways

- Built custom Docker images using Dockerfiles.
- Learned the purpose of common Dockerfile instructions.
- Compared **CMD** and **ENTRYPOINT**.
- Deployed a static website using **Nginx**.
- Optimized Docker build context using **.dockerignore**.
- Improved build performance with **Docker layer caching**.
- Successfully built, tested, and deployed Docker applications on an AWS EC2 instance.
