# Day 31 – Dockerfile: Build Your Own Images

## Objective

Learn how to write Dockerfiles, build custom Docker images, understand Dockerfile instructions, compare **CMD** and **ENTRYPOINT**, deploy a static website using **Nginx**, use **.dockerignore**, and optimize builds using **Docker layer caching**.

---

# Task 1: Your First Dockerfile

Created my first Docker image using **Ubuntu** as the base image, installed **curl**, and configured a default command using **CMD**.

### Dockerfile

➡️ [my-first-image/Dockerfile](./my-first-image/Dockerfile)

### Result

- Successfully built the image `my-ubuntu:v1`
- Verified the container prints the default message

![Task 1](images/01-my-first-image-docker-file.png)

![Output](images/02-1.4-run-my-ubuntu.png)

---

# Task 2: Dockerfile Instructions

Created a Dockerfile using the most common Dockerfile instructions and built an Nginx image.

### Dockerfile

➡️ [dockerfile-demo/Dockerfile](./dockerfile-demo/Dockerfile)

### HTML File

➡️ [dockerfile-demo/index.html](./dockerfile-demo/index.html)

### Instructions Used

| Instruction | Description |
|-------------|-------------|
| `FROM` | Selects the base image |
| `RUN` | Executes commands while building the image |
| `COPY` | Copies files into the image |
| `EXPOSE` | Documents the application port |
| `CMD` | Defines the default container command |

### Result

- Successfully built the image
- Started an Nginx container
- Accessed the application through the browser

![Dockerfile Demo](images/03-2.1-dockerfile.demo.png)

![Build & Run](images/04-2.2-build-run-docker-demo.png)

![Browser Output](images/05-2.3-browser-output.png)

---

# Task 3: CMD vs ENTRYPOINT

Created separate Dockerfiles to understand the behavior of **CMD** and **ENTRYPOINT**.

### CMD Dockerfile

➡️ [cmd-vs-entrypoint/Dockerfile.cmd](./cmd-vs-entrypoint/Dockerfile.cmd)

### ENTRYPOINT Dockerfile

➡️ [cmd-vs-entrypoint/Dockerfile.entrypoint](./cmd-vs-entrypoint/Dockerfile.entrypoint)

### Comparison

| CMD | ENTRYPOINT |
|------|------------|
| Provides a default command | Defines the main executable |
| Can be overridden | Always executes first |
| Suitable for optional commands | Suitable for fixed application startup |

### Result

Successfully verified the runtime behavior of both instructions.

![CMD Demo](images/06-3.1-cmd-demo.png)

![ENTRYPOINT Demo](images/07-3.2-entry-demo.png)

---

# Task 4: Build a Simple Web Application

Built a custom Nginx image to serve a static HTML webpage.

### Dockerfile

➡️ [nginx-demo/Dockerfile](./nginx-demo/Dockerfile)

### HTML File

➡️ [nginx-demo/index.html](./nginx-demo/index.html)

### Result

- Built the custom Nginx image
- Started the container
- Accessed the webpage from the browser

![Website Build](images/08-4.1-my-website-v1.png)

![Browser Output](images/09-4.2-browser-output.png)

---

# Task 5: Using .dockerignore

Created a `.dockerignore` file to reduce the Docker build context by excluding unnecessary files.

### Docker Ignore File

➡️ [nginx-demo/.dockerignore](./nginx-demo/.dockerignore)

### Ignored Files

- `node_modules`
- `.git`
- `*.md`
- `.env`

### Result

Verified ignored files were excluded from the Docker build context.

![Docker Ignore](images/10-5.1-my-website-v2.png)

---

# Task 6: Docker Layer Caching

Modified the application and rebuilt the image to understand Docker's layer caching mechanism.

### Observation

- Docker builds images layer by layer.
- Each Dockerfile instruction creates a new layer.
- Unchanged layers are reused from cache.
- Only modified layers are rebuilt.
- Proper instruction ordering improves build performance.

### Result

Successfully observed Docker cache reuse during image rebuild.

![Initial Build](images/11-6.1-creating-cache.png)

![Rebuild](images/12-6.2-rebuilding-it.png)

![Optimized Website](images/13-6.3-browser-output.png)

---

# Key Takeaways

- Built custom Docker images using Dockerfiles.
- Learned the purpose of common Dockerfile instructions.
- Understood the difference between **CMD** and **ENTRYPOINT**.
- Deployed a static website using **Nginx**.
- Optimized image builds with **.dockerignore**.
- Improved build performance using **Docker layer caching**.
- Successfully hosted and tested Docker applications on an AWS EC2 instance.
