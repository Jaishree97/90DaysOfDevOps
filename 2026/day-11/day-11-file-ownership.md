# File Ownership Challenge (chown & chgrp)

## Users Created

- tokyo
- berlin
- professor
- nairobi

### Verification

```bash
cat /etc/passwd | grep -E "berlin|professor|tokyo|nairobi"
```

![Users Created](images/01-user-created.png)

---

## Groups Created

- heist-team
- planners
- vault-team
- tech-team

### Verification

```bash
cat /etc/group | grep -E "heist-team|planners|vault-team|tech-team"
```

![Groups Created](images/02-groups-created.png)

---

## Files & Directories Created

- devops-file.txt
- app-logs/
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt
- heist-project/plans/strategy.conf
- heist-project/vault/gold.txt
- project-config.yml
- team-notes.txt

---

## Understanding Ownership

- Run `ls -l` in your working directory.
- The first username is the **Owner**.
- The second name is the **Group**.
- Ownership controls who can manage files and directories.

### Example

```bash
touch devops-file.txt
ls -l devops-file.txt
```

![Ownership](images/03-devops-file-created.png)

### Notes

- **Owner:** Usually the user who created the file.
- **Group:** Collection of users who share access to the file.

---

## Basic chown Operations

### Create File

```bash
touch devops-file.txt
```

### Check Current Owner

```bash
ls -l devops-file.txt
```

### Change Owner to tokyo

```bash
sudo chown tokyo devops-file.txt
```

### Verify

```bash
ls -l
```

![chown Operation](images/04-chown-devops-file.png)

---

## Basic chgrp Operations

### Create File

```bash
touch team-notes.txt
```

### Check Current Group

```bash
ls -l team-notes.txt
```

### Create Group

```bash
sudo groupadd heist-team
```

### Change Group

```bash
sudo chgrp heist-team team-notes.txt
```

### Verify

```bash
ls -l
```

![chgrp Operation](images/05-team-notes-created.png)

---

## Combined Owner & Group Change

Using `chown`, we can change both owner and group in a single command.

### Create File

```bash
touch project-config.yaml
```

### Change Owner & Group

```bash
sudo chown professor:heist-team project-config.yaml
```

### Create Directory

```bash
mkdir app-logs
```

### Change Directory Ownership

```bash
sudo chown berlin:heist-team app-logs/
```

### Verify

```bash
ls -l project-config.yaml
ls -ld app-logs
```

![Combined Ownership](images/06-project-config-yaml.png)

---

## Recursive Ownership

### 1. Create Directory Structure

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```

### 2. Create Group

```bash
sudo groupadd planners
```

### 3. Change Ownership Recursively

Owner: professor

Group: planners

```bash
sudo chown -R professor:planners heist-project/
```

### 4. Verify

```bash
ls -lR heist-project/
```

![Recursive Ownership](images/07-heist-project-dir.png)

---

## Task 6: Practice Challenge

### Create Users

- tokyo
- berlin
- nairobi

### Create Groups

- vault-team
- tech-team

### Create Directory

```bash
mkdir bank-heist/
```

### Create Files

```bash
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

### Set Different Ownership

#### access-codes.txt

Owner: tokyo

Group: vault-team

```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
```

#### blueprints.pdf

Owner: berlin

Group: tech-team

```bash
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```

#### escape-plan.txt

Owner: nairobi

Group: vault-team

```bash
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

### Verification

```bash
ls -l bank-heist/
```

![Practice Challenge](images/08-bank-heist-dir.png)

---

## Commands Used

### View Ownership

```bash
ls -l filename
```

### Change Owner Only

```bash
sudo chown username filename
```

### Change Group Only

```bash
sudo chgrp groupname filename
```

### Change Owner & Group

```bash
sudo chown owner:group filename
```

### Recursive Ownership Change

```bash
sudo chown -R owner:group directory/
```

### Change Only Group Using chown

```bash
sudo chown :groupname filename
```

---

## What I Learned

- Managing Linux users and groups
- Understanding file ownership concepts
- Using `chown` to change owners
- Using `chgrp` to change groups
- Assigning owner and group together
- Recursive ownership management using `-R`
- Verifying ownership using `ls -l`
- Managing directory ownership in Linux
