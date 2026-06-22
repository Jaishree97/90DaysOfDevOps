# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

### 1. Create a new branch `feature-login` from `main` and add a couple of commits

![Task 1.1](images/01-task-1.1.png)

---

### Verify available branches and commit history

![Task 1.2](images/02-task-1.2.png)

---

### 2. Switch back to `main` and merge `feature-login` into `main`

![Task 1.3](images/03-task-1.3.png)

---

### 3. Observe the merge — did Git do a fast-forward merge or a merge commit?

- Git performed a **Fast-Forward Merge**.
- The `main` branch had no new commits after the feature branch was created.
- Git simply moved the `main` branch pointer to the latest commit of `feature-login`.
- No separate merge commit was created.

![Task 1.4](images/04-task-1.4.png)

---

### 4. Create another branch `feature-signup`, add commits to it, and also add a commit to `main`

![Task 1.5](images/04-task-1.5.png)

---

### 5. What happened during the merge?

- Both branches contained different commits.
- Git could not perform a fast-forward merge.
- A **Merge Commit** was created to combine both histories.

---

### 6. Answer in your notes

#### What is a Fast-Forward Merge?

A fast-forward merge happens when the target branch has not moved ahead since the feature branch was created. Git simply moves the branch pointer forward without creating a new merge commit.

#### When does Git create a Merge Commit?

Git creates a merge commit when both branches have unique commits and their histories have diverged. The merge commit combines the histories into a single timeline.

#### What is a Merge Conflict?

A merge conflict occurs when the same file or the same section of a file is modified differently in multiple branches. Git cannot decide which change to keep and requires manual resolution.
