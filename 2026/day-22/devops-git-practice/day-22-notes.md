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
   - Branching & Merging

3. For each command, write:

   - What it does (1 line)
   - An example of how to use it

---

# Task 4: Stage and Commit

1. Stage your file

```bash
git add git-commands.md
```

2. Check what's staged

```bash
git status
```

3. Commit with a meaningful message

```bash
git commit -m "Added git commands reference"
```

4. View your commit history

```bash
git log
```

![Git Log](images/02-git-log.png)

---

# Task 5: Make More Changes and Build History

1. Edit `git-commands.md` — add more commands as you discover them

2. Check what changed since your last commit

3. Stage and commit again with a different, descriptive message

```bash
git commit -m "Added branch commands"
```

```bash
git commit -m "Added checkout command"
```

```bash
git commit -m "Added merge command"
```

4. Repeat this process so you have multiple commits in your history

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

## 1. What is the difference between `git add` and `git commit`?

- `git add` moves changes to the staging area.

- `git commit` saves staged changes permanently into Git history.

---

## 2. What does the staging area do? Why doesn't Git just commit directly?

- The staging area stores selected changes before they are committed.

- It allows us to review and organize changes before creating a commit.

- This helps avoid accidental commits and gives better control over version history.

---

## 3. What information does `git log` show you?

- `git log` displays commit history.

- It shows commit IDs, author information, dates, and commit messages.

---

## 4. What is the `.git/` folder and what happens if you delete it?

- The `.git/` folder stores the complete history of your repository.

- It contains commits, branches, tags, configuration files, and references.

- If the `.git/` folder is deleted, Git tracking and history are permanently lost.

---

## 5. What is the difference between a working directory, staging area, and repository?

### Working Directory

The area where files are created and modified.

### Staging Area

The area where selected changes are prepared before committing.

### Repository

The Git database that stores commits, branches, tags, and project history.
