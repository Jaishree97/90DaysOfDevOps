# File Permissions & File Operations Challenge

## Files Created

- Create empty file devops.txt using touch
- Create notes.txt with content using echo
- Create script.sh
- Verify files using ls -l

![create_files](images/02-file-created.png)

---

## Read Files

- Read notes.txt using cat

![notes_file](images/03-cat-note-file.png)

- View script.sh in vim read-only mode


![vim](images/001.png)

- Display first 5 lines of /etc/passwd using head


![head](images/04-head.png)

- Display last 5 lines of /etc/passwd using tail


![tail](images/05-tail.png)

---

# Permission Changes

## Understand Permissions


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


![script](images/07-modify-permmission.png)

### Explanation

- `chmod +x` adds execute permission.
- Initially script contained only text, so Linux tried to execute `Hello` as a command.
- After adding:


the script executed successfully.


```
Output:

```text
Hello DevOps
```

---

## Set devops.txt to read-only


![readonly](images/08-readonly.png)

### Explanation

- `-w` removes write permission.
- File becomes read-only.

---

## Set notes.txt to 640


![notes_permission](images/09-notes-file.png)

### Explanation

Permission 640 means:

- Owner → read + write
- Group → read only
- Others → no permission

---

## Create directory project/ with permissions 755


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

```

Output:

```text
bash: ./test.sh: Permission denied
```

After adding execute permission:

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
