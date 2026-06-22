# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?

- A branch is a separate workspace used to make changes without affecting the main project.

### 2. Why do we use branches instead of committing everything to main?

- Branches help us test and develop features safely before merging them into the main branch.

### 3. What is HEAD in Git?

- HEAD points to the current branch and latest commit.

### 4. What happens to your files when you switch branches?

- Git updates your files according to the selected branch.

---

## Task 2: Branching Commands — Hands-On

### 1. List all branches in your repo

```bash
git branch
```

Output:

```text
* master
```

### 2. Create a new branch called feature-1

```bash
git branch feature-1
```

### 3. Switch to feature-1

```bash
git switch feature-1
```

Output:

```text
Switched to branch 'feature-1'
```

### 4. Create a new branch and switch to it in a single command — call it feature-2

```bash
git checkout -b feature-2
```

Output:

```text
Switched to a new branch 'feature-2'
```

### 5. Try using git switch to move between branches — how is it different from git checkout?

```bash
git checkout feature-1
git switch master
git switch feature-1
```

- `git switch` → Used only for switching branches.
- `git checkout` → Used for switching branches and restoring files.

### 6. Make a commit on feature-1 that does not exist on main

```bash
echo "Login Feature Added" > login.txt

git add .
git commit -m "Added login feature"
```

Output:

```text
[feature-1] Added login feature
```

### 7. Switch back to main — verify that the commit from feature-1 is not there

```bash
git switch main
ls
```

- The `login.txt` file is not available on the main branch.

### 8. Delete a branch you no longer need

```bash
git branch -d feature-2
```

### 9. Add all branching commands to your notes

```bash
git branch
git branch feature-1
git switch feature-1
git checkout -b feature-2
git checkout feature-1
git switch main
git branch -d feature-2
```

---

## Task 3: Push to GitHub

### 1. Create a new repository on GitHub (do NOT initialize it with a README)

Repository:

```text
devops-git-practice
```

### 2. Connect your local repo to the GitHub remote

```bash
git remote add origin https://github.com/Jaishree97/devops-git-practice.git
```

Verify:

```bash
git remote -v
```

### 3. Push your main branch to GitHub

```bash
git branch -m main

git push -u origin main
```

Output:

```text
[new branch] main -> main
```

### 4. Push feature-1 branch to GitHub

```bash
git switch feature-1

git push -u origin feature-1
```

Output:

```text
[new branch] feature-1 -> feature-1
```

### 5. Verify both branches are visible on GitHub

Branches:

```text
main
feature-1
```

### 6. Answer in your notes: What is the difference between origin and upstream?

- `Origin` - Points to your remote repository.
- `Upstream` - Points to the original repository you forked from.

- If not forked, there is no need for upstream.

---

## Task 4: Pull from GitHub

### 1. Make a change to a file directly on GitHub (use the GitHub editor)

- Edit a file.
- Commit the changes.

### 2. Pull that change to your local repo

```bash
git pull origin main
```

### 3. Answer in your notes: What is the difference between git fetch and git pull?

- `fetch` - Downloads changes but does not merge them.
- `pull` - Downloads changes and merges them into your local branch.

---

## Task 5: Clone vs Fork

### 1. Clone any public repository from GitHub to your local machine

```bash
git clone https://github.com/user/repository.git
```

### 2. Fork the same repository on GitHub, then clone your fork

### 3. Answer in your notes:

#### What is the difference between clone and fork?

- `Clone` - Creates a copy on your local machine.
- `Fork` - Creates a copy in your GitHub account.

#### When would you clone vs fork?

- I use **Fork** when contributing to someone else's repository.
- I use **Clone** when I need a local copy to work on.

#### After forking, how do you keep your fork in sync with the original repo?

```bash
git remote add upstream https://github.com/original/repository.git

git fetch upstream

git merge upstream/main
```

- Upstream helps keep the fork updated with the original repository.
