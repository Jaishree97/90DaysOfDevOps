# Day 09 - Linux User & Group Management Challenge

## Overview

Today I practiced Linux user and group management by creating users, assigning groups, managing permissions, creating shared directories, and configuring SSH login for a custom user.

---

## Users Created

Created the following users with home directories and passwords:

- tokyo
- berlin
- professor
- nairobi

### Commands Used

```bash
sudo useradd -m tokyo
sudo passwd tokyo

sudo useradd -m berlin
sudo passwd berlin

sudo useradd -m professor
sudo passwd professor

sudo useradd -m nairobi
sudo passwd nairobi
```

### Verification

```bash
grep -E "tokyo|berlin|professor|nairobi" /etc/passwd
```

```bash
ls /home
```

---

## Groups Created

Created the following groups:

- developers
- admins
- project-team

### Commands Used

```bash
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team
```

### Verification

```bash
grep -E "developers|admins|project-team" /etc/group
```

---

## Group Assignments

### developers

- tokyo
- berlin

### admins

- berlin
- professor

### project-team

- tokyo
- nairobi

### Commands Used

```bash
sudo gpasswd -a tokyo developers
sudo gpasswd -a berlin developers

sudo usermod -aG admins berlin
sudo gpasswd -a professor admins

sudo gpasswd -a tokyo project-team
sudo gpasswd -a nairobi project-team
```

### Verification

```bash
id tokyo
id berlin
id professor
id nairobi
```

```bash
getent group developers
getent group admins
getent group project-team
```

---

## Changed Default Shell

Changed the default login shell from `/bin/sh` to `/bin/bash`.

### Commands Used

```bash
sudo usermod -s /bin/bash tokyo
sudo usermod -s /bin/bash berlin
sudo usermod -s /bin/bash professor
```

### Verification

```bash
grep -E "tokyo|berlin|professor" /etc/passwd
```

Expected output:

```text
/home/tokyo:/bin/bash
/home/berlin:/bin/bash
/home/professor:/bin/bash
```

---

## Shared Directory - Developers

Created a shared project directory for developers.

### Directory

```text
/opt/dev-project
```

### Commands Used

```bash
sudo mkdir -p /opt/dev-project

sudo chgrp developers /opt/dev-project

sudo chmod 775 /opt/dev-project
```

### Verification

```bash
ls -ld /opt/dev-project
```

Expected:

```text
drwxrwxr-x
```

---

## Testing Access as Tokyo

Logged in as tokyo and created files.

### Commands Used

```bash
su - tokyo

cd /opt/dev-project

touch test.txt

echo "Hi, this is tokyo" > text.txt

cat text.txt
```

### Output

```text
Hi, this is tokyo
```

---

## Testing Access as Berlin

Logged in as berlin and verified access.

### Commands Used

```bash
su - berlin

cd /opt/dev-project

cat text.txt

touch berlin.txt

echo "Hello, I am berlin" > berlin.txt

cat berlin.txt
```

### Output

```text
Hello, I am berlin
```

---

## Team Workspace

Created a team workspace for project-team members.

### Directory

```text
/opt/team-workspace
```

### Commands Used

```bash
sudo mkdir -p /opt/team-workspace

sudo chgrp project-team /opt/team-workspace

sudo chmod 775 /opt/team-workspace
```

### Verification

```bash
ls -ld /opt/team-workspace
```

Expected:

```text
drwxrwxr-x
```

---

## Testing Access as Nairobi

Created a file as nairobi.

### Commands Used

```bash
sudo -u nairobi touch nairobi_test.txt

echo "hi, this file is created by nairobi" | sudo -u nairobi tee nairobi_test.txt
```

### Verification

```bash
ls -l
```

Expected:

```text
-rw-r--r-- 1 nairobi nairobi
```

---

## SSH Login as Berlin

Configured SSH access for berlin using the same EC2 key pair.

### Commands Used

```bash
sudo mkdir -p /home/berlin/.ssh

sudo cp /home/ubuntu/.ssh/authorized_keys /home/berlin/.ssh/

sudo chown -R berlin:berlin /home/berlin/.ssh

sudo chmod 700 /home/berlin/.ssh

sudo chmod 600 /home/berlin/.ssh/authorized_keys
```

### Verification

```bash
sudo ls -ld /home/berlin/.ssh

sudo ls -l /home/berlin/.ssh
```

SSH login:

```bash
ssh -i "miya.pem" berlin@ec2-44-244-230-112.us-west-2.compute.amazonaws.com
```

Verify:

```bash
whoami
pwd
```

Output:

```text
berlin
/home/berlin
```

---

## Key Learnings

1. Created and managed Linux users and groups.
2. Assigned users to multiple groups using `gpasswd` and `usermod -aG`.
3. Configured shared directories using group ownership and permissions.
4. Changed default login shells using `usermod -s`.
5. Used `sudo -u` to execute commands as another user.
6. Configured SSH access for a custom Linux user.
7. Learned the difference between file ownership, group ownership, and permissions.

---

## Screenshots

Screenshots of all command outputs are available in the `images/` directory.

- User creation
- Group creation
- Group assignment
- Shell modification
- Shared directory permissions
- Nairobi file creation
- SSH login as berlin

---
#90DaysOfDevOps #Linux #DevOps #AWS #UserManagement
