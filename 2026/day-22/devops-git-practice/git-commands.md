# Git Local Setup

### Check Git Version

```bash
git --version
```

### Configure Git Username

```bash
git config --global user.name "Jaishree Chaure"
```

### Configure Git Email

```bash
git config --global user.email "your-email@example.com"
```

### Verify Configuration

```bash
git config --list
```

---

# Git Commands

| Command | Usage | Example |
|----------|----------|----------|
| `git init` | Initialize a new Git repository | `git init` |
| `git clone <url>` | Clone an existing repository | `git clone https://github.com/Jaishree97/90DaysOfDevOps.git` |
| `git status` | Check repository status | `git status` |
| `git add <file>` | Stage a specific file | `git add README.md` |
| `git add .` | Stage all changes | `git add .` |
| `git commit -m "message"` | Commit staged changes | `git commit -m "Initial Commit"` |
| `git log` | View commit history | `git log` |
| `git log --oneline` | View compact commit history | `git log --oneline` |
| `git diff` | Show unstaged changes | `git diff` |
| `git restore <file>` | Discard local changes | `git restore file.txt` |
| `git reset <file>` | Unstage a file | `git reset README.md` |
| `git branch` | List all branches | `git branch` |
| `git branch <branch-name>` | Create a new branch | `git branch feature` |
| `git checkout <branch-name>` | Switch branch | `git checkout feature` |
| `git checkout -b <branch-name>` | Create and switch branch | `git checkout -b feature` |
| `git merge <branch-name>` | Merge branch into current branch | `git merge feature` |
| `git remote -v` | View remote repositories | `git remote -v` |
| `git push origin master` | Push changes to GitHub | `git push origin master` |
| `git pull origin master` | Pull latest changes | `git pull origin master` |
| `git fetch` | Download remote changes | `git fetch` |
| `git stash` | Temporarily save changes | `git stash` |
| `git stash pop` | Restore stashed changes | `git stash pop` |
| `git revert <commit-id>` | Undo a commit safely | `git revert abc123` |
| `git tag` | List tags | `git tag` |

---

# Common Git Workflow

### 1. Check Status

```bash
git status
```

### 2. Add Changes

```bash
git add .
```

### 3. Commit Changes

```bash
git commit -m "Added Day 22 Git Notes"
```

### 4. Push to GitHub

```bash
git push origin master
```

---

# Git Areas

## Working Directory

Files you are currently editing.

## Staging Area

Files prepared for commit using `git add`.

## Repository

Committed files stored in Git history.

---

# Day 22 Learning Summary

✅ Installed and configured Git

✅ Initialized a Git repository

✅ Explored `.git` directory

✅ Created Git commands reference

✅ Practiced staging and committing

✅ Viewed commit history

✅ Learned Working Directory, Staging Area and Repository concepts

✅ Connected local repository with GitHub