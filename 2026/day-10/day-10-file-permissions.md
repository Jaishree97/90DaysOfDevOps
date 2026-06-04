# File Permissions & File Operations Challenge

## Files Created

- Create empty file devops.txt using touch
- Create notes.txt with content using echo
- Create script.sh
- Verify: ls -l to see permissions

![create_files](images/02-file-created.png)

---

## Read Files

- Read notes.txt using cat

![notes](images/03-cat-note-file.png)

- View script.sh in vim read-only mode - `vim -R script.sh`

![vim](images/001.png)

- Display first 5 lines of /etc/passwd using head

![passwd_head](images/04-head.png)

- Display last 5 lines of /etc/passwd using tail

![passwd_tail](images/05-tail.png)

---

# Permission Changes

## Understand Permissions

![permissions](images/06-permissions.png)

### Current permissions :

Devops.txt : `-rw-rw-r--`

- `-` → indicates it's a regular file (not a directory or special file).
- `rw-` → (user/owner) → read + write, no execute.
- `rw-` → (group) → read + write, no execute.
- `r--` → (others) → read only, no write or execute.

Same permissions applied to notes.txt and script.sh.

---

## Modify Permissions

- Make script.sh executable → run it with `./script.sh`

![script](images/07-modify-permmission.png)

- Set devops.txt to read-only (remove write for all)

![readonly](images/08-readonly.png)

- Set notes.txt to 640 (owner: rw, group: r, others: none)

![notes_perm](images/09-notes-file.png)

- Create directory project/ with permissions 755

![project](images/10-project-dir.png)

---

# Test Permissions

- Try writing to a read-only file - what happens?

Answer :

Writing to a read-only file gives **Permission denied** because write permission has been removed.

![readonly_test](images/11-testing-file.png)

---

- Try executing a file without execute permission.

Answer :

Executing a file without execute permission gives **Permission denied** because Linux requires execute permission before running a script directly.

After adding execute permission using `chmod +x`, the script runs successfully.

![execute_test](images/12-tesing.png)

---

# Commands Used

- `touch fname` - Creates empty file.
- `echo "Hello" > fname` - Create file with content.
- `cat fname` - Prints file content.
- `vim fname` - Create/open file in Vim.
- `vim -R fname` - Open file in read only mode.
- `head -n 5 /etc/passwd` - Prints first 5 lines of /etc/passwd.
- `tail -n 5 /etc/passwd` - Prints last 5 lines of /etc/passwd.
- `chmod +x fname` - Adding executable permission.
- `chmod -w fname` - Removing write permission.
- `chmod 640 fname` - Set permission to 640.
- `mkdir -m 755 dname` - Create directory with permissions 755.
- `ls -l` - View permissions.

# What I Learned

- Linux permissions control access to files and directories.
- Execute permission is required to run shell scripts.
- Read-only files cannot be modified.
- chmod can be used with symbolic and numeric modes.
- Directory permissions differ from file permissions.
