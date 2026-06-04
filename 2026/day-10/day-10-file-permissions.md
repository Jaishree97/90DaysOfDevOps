# Day 10 - Linux File Permissions & File Operations

## Files Created

Created the following files:

- `devops.txt`
- `notes.txt`
- `script.sh`

### Commands Used

```bash
touch devops.txt notes.txt
echo "Notes for 90daysofdevops" > notes.txt
echo "Hello DevOps" > script.sh
ls -l
```

### Screenshot

![Files Created](images/02-file-created.png)

---

## Read File Content

Displayed the contents of `notes.txt`.

```bash
cat notes.txt
```

### Output

```text
Notes for 90daysofdevops
```

### Screenshot

![Notes File](images/03-cat-note-file.png)

---

## View Script in Read-Only Mode

Opened the script file in Vim read-only mode.

```bash
vim -R script.sh
```

### Screenshot

![Vim Read Only](images/001.png)

---

## Display First 5 Lines of /etc/passwd

```bash
head -n 5 /etc/passwd
```

### Screenshot

![Head Command](images/04-head.png)

---

## Display Last 5 Lines of /etc/passwd

```bash
tail -n 5 /etc/passwd
```

### Screenshot

![Tail Command](images/05-tail.png)

---

# Understanding File Permissions

Checked file permissions using:

```bash
ls -l
```

### Screenshot

![Permissions](images/06-permissions.png)

### Observations

| File | Permissions |
|--------|------------|
| devops.txt | rw-r--r-- |
| notes.txt | rw-r--r-- |
| script.sh | rw-r--r-- |

---

# Modify Permissions

## Make script.sh Executable

Initially, running the script produced an error because it contained plain text instead of a command.

After updating the file with:

```bash
#!/bin/bash
echo "Hello DevOps"
```

and granting execute permission:

```bash
chmod +x script.sh
./script.sh
```

Output:

```text
Hello DevOps
```

### Screenshot

![Script Permission](images/07-modify-permmission.png)

---

## Make devops.txt Read-Only

Removed write permission.

```bash
chmod -w devops.txt
ls -l
```

### Screenshot

![Read Only File](images/08-readonly.png)

---

## Change notes.txt Permission to 640

```bash
chmod 640 notes.txt
ls -l
```

### Screenshot

![Notes Permission](images/09-notes-file.png)

---

## Create Project Directory with Permission 755

```bash
mkdir -m 755 project
ls -ld project
```

### Screenshot

![Project Directory](images/10-project-dir.png)

---

# Permission Testing

## Test 1: Write to a Read-Only File

```bash
echo "New Text" > readonly.txt
chmod 444 readonly.txt
echo "New Text" > readonly.txt
```

### Result

```text
Permission denied
```

### Screenshot

![Read Only Test](images/11-testing-file.png)

---

## Test 2: Execute File Without Execute Permission

```bash
echo 'echo "Hello DevOps"' > test.sh
chmod 644 test.sh
./test.sh
```

### Result

```text
Permission denied
```

After adding execute permission:

```bash
chmod +x test.sh
./test.sh
```

Output:

```text
Hello DevOps
```

### Screenshot

![Execute Permission Test](images/12-tesing.png)

---

# What I Learned

- Linux permissions are controlled using `chmod`.
- Execute permission (`x`) is required to run shell scripts directly.
- Read-only files prevent modifications by normal users.
- `head` and `tail` help inspect large files quickly.
- Directory permissions can be assigned during creation using `mkdir -m`.
- `vim -R` opens files safely in read-only mode.
