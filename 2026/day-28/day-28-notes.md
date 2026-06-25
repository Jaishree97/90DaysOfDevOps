# Day 28 – Revision Day: Everything from Day 1 to Day 27

## What You've Covered So Far

| Days | Topic | Key Concepts |
|------|-------|--------------|
| 1 | DevOps Fundamentals | DevOps, SDLC, CI/CD, Cloud Basics |
| 2–7 | Linux Fundamentals | Linux commands, file system, processes, services, troubleshooting |
| 8 | AWS EC2 & Nginx | EC2, SSH, web server deployment |
| 9–11 | Users, Groups & Permissions | User management, permissions, ownership |
| 12 | Revision | Linux recap |
| 13 | LVM | PV, VG, LV, storage management |
| 14–15 | Networking | IP, DNS, CIDR, Ports, Subnets |
| 16–21 | Shell Scripting | Variables, loops, functions, automation, cron |
| 22–25 | Git & GitHub | Branching, merge, rebase, stash, reset, revert |
| 26 | GitHub CLI | Repository management, Issues, PRs, Workflows |
| 27 | GitHub Profile | Profile README, documentation, developer branding |

---

# Challenge Tasks

## Task 1: Self-Assessment Checklist

Go through the checklist below and mark yourself honestly.

- ✅ Can do confidently
- 🟡 Need more practice
- ❌ Haven't done yet

### Linux

- ☑ Navigate Linux file system
- ☑ Manage files and directories
- ☑ Work with processes and services
- ☑ Edit files using Vim/Nano
- ☑ Troubleshoot CPU, memory and disk usage
- ☑ Explain Linux directory structure
- ☑ Create users and groups
- ☑ Manage file permissions and ownership
- ☑ Configure LVM
- ☑ Perform basic network troubleshooting

### Shell Scripting

- ☑ Variables and user input
- ☑ Conditional statements
- ☑ Loops
- ☑ Functions
- ☑ Text processing using grep, awk and sed
- ☑ Error handling
- ☑ Schedule scripts using cron

### Git & GitHub

- ☑ Initialize repositories
- ☑ Commit and push changes
- ☑ Branching strategies
- ☑ Merge and Rebase
- ☑ Git Stash
- ☑ Cherry-pick commits
- ☑ Git Reset and Git Revert
- ☑ GitHub Flow
- ☑ GitHub CLI

---

## Task 2: Revisit Your Weak Spots

### Topics Revisited

- DNS Resolution
- CIDR & Subnetting
- Git Rebase
- Shell Script Error Handling

---

## Task 3: Quick-Fire Questions

Answer these from memory before verifying.

### 1. What does `chmod 755 script.sh` do?

- Gives the owner **read, write and execute** permissions.
- Gives the group and others **read and execute** permissions.

---

### 2. What is the difference between a process and a service?

- A **process** is a running instance of a program.
- A **service** is a background process managed by **systemd** that usually starts automatically.

---

### 3. Which command shows the process using port 8080?

```bash
sudo ss -tulpn | grep 8080
```

---

### 4. What does `set -euo pipefail` do?

- Exit immediately if a command fails.
- Treat unset variables as errors.
- Detect failures inside pipelines.

---

### 5. Difference between Git Merge and Git Rebase?

- **Merge** preserves branch history.
- **Rebase** creates a cleaner, linear commit history.

---

### 6. Difference between Git Reset and Git Revert?

- **Reset** rewrites commit history.
- **Revert** creates a new commit that safely undoes previous changes.

---

### 7. How do you schedule a script to run every day at 3 AM?

```cron
0 3 * * *
```

---

### 8. Difference between `git fetch` and `git pull`?

- **git fetch** downloads changes without merging.
- **git pull** downloads and merges remote changes.

---

### 9. What is LVM?

Logical Volume Manager (LVM) provides flexible disk management by creating Logical Volumes from Volume Groups, allowing storage to be resized without repartitioning disks.

---

### 10. What is CIDR?

CIDR (Classless Inter-Domain Routing) is a method of allocating IP addresses and defining subnet masks.

Example:

```
192.168.1.0/24
```

---

## Task 4: Organize Your Work

- ☑ Verified all Day 1–27 tasks are committed and pushed
- ☑ Reviewed markdown documentation
- ☑ Updated GitHub repositories
- ☑ Verified GitHub Profile README
- ☑ Organized screenshots and project files

---

## Task 5: Teach It Back

### DNS Resolution

When you enter a domain name, your system queries a DNS server to translate it into an IP address. The browser then connects to the server using that IP.

---

### Git Rebase

Git Rebase moves commits onto another branch to create a cleaner and linear project history while keeping the latest changes.

---

### LVM

LVM provides flexible storage management by combining physical disks into Volume Groups and creating Logical Volumes that can be resized as storage requirements change.

---

## Key Takeaways

- Strengthened Linux fundamentals through revision.
- Improved understanding of networking concepts.
- Reinforced shell scripting and automation basics.
- Gained better confidence with Git and GitHub workflows.
- Identified weak areas for continued practice.

---

## Outcome

By the end of Day 28, I was able to:

- Revise concepts from Day 1–27.
- Validate my understanding with self-assessment.
- Answer fundamental DevOps interview questions.
- Organize my GitHub documentation.
- Build a stronger foundation before moving to advanced DevOps topics.

---
