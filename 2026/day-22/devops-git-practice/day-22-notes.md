# Day 22 – Introduction to Git: Your First Repository

---

# Task 1: Install and Configure Git

1. Verify Git is installed on your machine

2. Set up your Git identity — name and email

3. Verify your configuration

![Git Configuration](images/01-git-config.png)

---

# Task 2: Create Your Git Project

1. Create a new folder called `devops-git-practice`

2. Initialize it as a Git repository

3. Check the status — read and understand what Git is telling you

4. Explore the hidden `.git/` directory — look at what's inside

---

# Task 3: Create Your Git Commands Reference

1. Create a file called `git-commands.md` inside the repository

2. Add the Git commands you've used so far, organized by category:

   - Setup & Config
   - Basic Workflow
   - Viewing Changes

3. For each command, write:

   - What it does (1 line)
   - An example of how to use it

---

# Task 4: Stage and Commit

1. Stage your file

2. Check what's staged

3. Commit with a meaningful message

4. View your commit history

![Git Log](images/02-git-log.png)

---

# Task 5: Make More Changes and Build History

1. Edit `git-commands.md` — add more commands as you discover them

2. Check what changed since your last commit

3. Stage and commit again with a different, descriptive message

4. Repeat this process at least 3 times so you have multiple commits in your history

5. View the full history in a compact format

```bash
git log --oneline
```

Output:

```text
77b91bd Added merge command
8dcfc2e Added checkout command
2d5dd7f Added branch commands
45f52c9 Added git commands reference
```

---

# Task 6: Understand the Git Workflow

### 1. What is the difference between `git add` and `git commit`?

- `git add` keeps files in the staging area so they can be included in the next commit.

- `git commit` saves staged changes into the repository history with a commit message.

### 2. What does the staging area do? Why doesn't Git just commit directly?

- The staging area stores files and changes that will be included in the next commit.

- It helps review and organize changes before committing.

- It prevents accidental commits.

### 3. What information does `git log` show you?

- `git log` shows commit history.

- It displays commit ID, author, date and commit message.

### 4. What is the `.git/` folder and what happens if you delete it?

- `.git/` stores repository history, branches, tags and configuration files.

- If deleted, Git tracking and commit history are lost.

### 5. What is the difference between a working directory, staging area, and repository?

- **Working Directory** – Place where files are created and modified.

- **Staging Area** – Area where changes are prepared before committing.

- **Repository** – Stores commits, branches and complete project history.
