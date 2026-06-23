## Task 1: Git Merge — Hands-On

### 1. Create a new branch `feature-login` from `main` and add a couple of commits

![Task 1.1](images/01-task-1.1.png)

### 2. Switch back to `main` and merge `feature-login` into `main`

![Task 1.2](images/02-task-1.2.png)

### 3. Observe the merge

- Git performed a **fast-forward merge**.
- No merge commit was created because `main` had no new commits.

![Task 1.3](images/03-task-1.3.png)

### 4. Create another branch `feature-signup`, add commits, and add a commit to `main`

![Task 1.4](images/04-task-1.4.png)

### 5. Merge `feature-signup` into `main`

- Git created a **merge commit** because both branches had different commits.

![Task 1.5](images/04-task-1.5.png)

### 6. Answer in your notes

#### What is a fast-forward merge?

A fast-forward merge happens when the target branch has no new commits. Git simply moves the branch pointer forward without creating a merge commit.

#### When does Git create a merge commit?

Git creates a merge commit when both branches contain different commits and their histories have diverged.

#### What is a merge conflict?

A merge conflict occurs when the same file is modified differently in multiple branches and Git cannot automatically decide which version to keep.
