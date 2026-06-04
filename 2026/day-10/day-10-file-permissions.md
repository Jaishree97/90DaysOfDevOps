# File Permissions & File Operations Challenge

## Files Created

- Create empty file devops.txt using touch
- Create notes.txt with content using echo
- Create script.sh
- Verify files using ls -l

```bash
touch devops.txt notes.txt
echo "Notes for 90daysofdevops" > notes.txt
echo "Hello DevOps" > script.sh
ls -l
```

![create_files](images/02-file-created.png)

---

## Read Files

- Read notes.txt using cat

```bash
cat notes.txt
```

![notes_file](images/03-cat-note-file.png)

- View script.sh in vim read-only mode

```bash
vim -R script.sh
```

![vim](images/001.png)

- Display first 5 lines of /etc/passwd using head

```bash
head -n 5 /etc/passwd
```

![head](images/04-head.png)

- Display last 5 lines of /etc/passwd using tail

```bash
tail -n 5 /etc/passwd
```

![tail](images/05-tail.png)

---

# Permission Changes

## Understand Permissions

```bash
ls -l
```

![permissions](images/06-permissions.png)

### Current permissions

**devops.txt : -rw-rw-r--**

- `-` → Regular file
- `rw-` → Owner can read and write
- `rw-` → Group can read and write
- `r--` → Others can only read

**notes.txt : -rw-rw-r--**

- Same permissions as devops.txt

**script.sh : -rw-rw-r--**

- Read and write permissions available
- Execute permission not available

---

## Make script.sh executable → run it with ./script.sh

```bash
chmod +x script.sh
ls -l script.sh
./script.sh
```

![script](images/07-modify-permmission.png)

### Explanation

- `chmod +x` adds execute permission.
- Initially script contained only text, so Linux tried to execute `Hello` as a command.
- After adding:

```bash
#!/bin/bash
echo "Hello DevOps"
```

the script executed successfully.

Output:

```text
Hello DevOps
```

---

## Set devops.txt to read-only

```bash
chmod -w devops.txt
ls -l
```

![readonly](images/08-readonly.png)

### Explanation

- `-w` removes write permission.
- File becomes read-only.

---

## Set notes.txt to 640

```bash
chmod 640 notes.txt
ls -l
```

![notes_permission](images/09-notes-file.png)

### Explanation

Permission 640 means:

- Owner → read + write
- Group → read only
- Others → no permission

---

## Create directory project/ with permissions 755

```bash
mkdir -m 755 project
ls -ld project
```

![project](images/10-project-dir.png)

### Explanation

Permission 755 means:

- Owner → rwx
- Group → r-x
- Others → r-x

---

# Test Permissions

## Try writing to a read-only file

### Answer

Writing to a read-only file gives **Permission denied** because write permission is removed.

```bash
echo "Hello" > readonly.txt
chmod 444 readonly.txt
echo "New Text" > readonly.txt
```

Output:

```text
bash: readonly.txt: Permission denied
```

![readonly_test](images/11-testing-file.png)

---

## Try executing a file without execute permission

### Answer

Executing a file without execute permission gives **Permission denied** because Linux requires execute (`x`) permission.

```bash
echo 'echo "Hello DevOps"' > test.sh
chmod 644 test.sh
./test.sh
```

Output:

```text
bash: ./test.sh: Permission denied
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

![execute_test](images/12-tesing.png)

---

# Commands Used

- `touch` → Create empty file
- `echo` → Write content to file
- `cat` → Display file content
- `vim -R` → Open file in read-only mode
- `head -n 5` → Show first 5 lines
- `tail -n 5` → Show last 5 lines
- `chmod +x` → Add execute permission
- `chmod -w` → Remove write permission
- `chmod 640` → Set custom permission
- `mkdir -m 755` → Create directory with permission 755
- `ls -l` → View permissions

# What I Learned

- Linux permissions control access to files and directories.
- Execute permission is required to run scripts directly.
- Read-only files cannot be modified.
- Numeric permissions like 640 and 755 provide fine-grained access control.
- `chmod` can modify permissions using symbolic and numeric methods.
