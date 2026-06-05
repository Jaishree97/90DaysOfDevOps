# File Ownership Challenge (chown & chgrp)

## Users Created

![Users Created](images/user-created.png)

## Groups Created

![Groups Created](images/groups-created.png)

## Files & Directories Created

- devops-file.txt
- app-logs/
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt
- heist-project/plans/strategy.conf
- heist-project/vault/gold.txt
- team-notes.txt
- project-config.yaml
  
---

## Understanding Ownership

- Run `ls -l` in your home directory
- Identify owner and group columns
- Check who owns your files

![Ownership](images/devops-file-created.png)

- **Owner**: The user who created the file or directory. The owner can modify permissions and ownership.
- **Group**: A collection of users who share access to the file.

---

## Basic chown Operations

- Create file `devops-file.txt`
- Check current ownership using `ls -l`
- Change owner to `tokyo`
- Verify the ownership change

![chown Operation](images/chown-devops-file.png)

---

## Basic chgrp Operations

- Create file `team-notes.txt`
- Create group `heist-team`
- Change file group to `heist-team`
- Verify group ownership

![chgrp Operation](images/team-notes-created.png)

---

## Combined Owner & Group Change

Using `chown`, owner and group can be modified together.

- Create file `project-config.yaml`
- Change owner to `professor`
- Change group to `heist-team`
- Create directory `app-logs/`
- Change directory ownership

![Combined Ownership](images/project-config-yaml.png)

---

## Recursive Ownership

### Create directory structure

- mkdir -p heist-project/vault
- mkdir -p heist-project/plans
- touch heist-project/vault/gold.txt
- touch heist-project/plans/strategy.conf

### Create group

- planners

### Change ownership recursively

- Owner: professor
- Group: planners

### Verify all files and directories

![Recursive Ownership](images/heist-project-dir.png)

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

- bank-heist/

### Create Files

- access-codes.txt
- blueprints.pdf
- escape-plan.txt

### Set Ownership

- access-codes.txt → Owner: tokyo, Group: vault-team
- blueprints.pdf → Owner: berlin, Group: tech-team
- escape-plan.txt → Owner: nairobi, Group: vault-team

### Verify

![Bank Heist Challenge](images/bank-heist-dir.png)

---

## Commands Used

- `ls -l` → View file owner and group
- `chown user file` → Change owner
- `chgrp group file` → Change group
- `chown user:group file` → Change owner and group together
- `chown -R user:group directory` → Change ownership recursively
- `groupadd groupname` → Create a new group

---

## What I Learned

- Understanding Linux file ownership
- Difference between owner and group
- Using chown to change ownership
- Using chgrp to modify groups
- Recursive ownership management
- Managing permissions through users and groups
