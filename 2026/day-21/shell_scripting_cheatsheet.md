#  Shell Scripting Cheat Sheet

A quick reference guide for Shell Scripting concepts, loops, functions, text processing tools, debugging techniques, and common DevOps scripting patterns.

---

##  Table of Contents

- Quick Reference Table
- Common Exit Codes
- Debugging Options
- Task 1: Basics
- Task 2: Operators and Conditionals
- Task 3: Loops
- Task 4: Functions
- Task 5: Text Processing Commands
- Task 6: Useful Patterns and One-Liners
- Task 7: Error Handling and Debugging

---

##  Quick Reference Table

| Topic | Syntax | Example |
|---------|---------|---------|
| Shebang | `#!/bin/bash` | First line of script |
| Make Executable | `chmod +x file.sh` | `chmod +x script.sh` |
| Run Script | `./file.sh` | `./script.sh` |
| Run With Bash | `bash file.sh` | `bash script.sh` |
| Comment | `# comment` | `# This is a comment` |
| Multi-line Comment | `: <<'EOF'` | Comment multiple lines |
| Variable | `VAR=value` | `NAME=DevOps` |
| Use Variable | `$VAR` | `echo $NAME` |
| Command Substitution | `$(command)` | `DATE=$(date)` |
| Read Input | `read VAR` | `read USERNAME` |
| Script Name | `$0` | `echo $0` |
| First Argument | `$1` | `./script.sh start` |
| Second Argument | `$2` | `./script.sh nginx apache` |
| Argument Count | `$#` | `echo $#` |
| All Arguments | `$@` | `echo "$@"` |
| Last Exit Code | `$?` | `echo $?` |
| Process ID | `$$` | `echo $$` |
| Current Directory | `.` | `source ./.env` |
| Parent Directory | `..` | `cd ..` |
| Home Directory | `~` | `cd ~` |
| Root Directory | `/` | `cd /` |
| Current Path | `pwd` | `pwd` |
| String Compare | `[ "$a" = "$b" ]` | `[ "$os" = "Linux" ]` |
| Integer Compare | `[ $a -gt $b ]` | `[ $num -eq 10 ]` |
| File Exists | `[ -f file ]` | `[ -f app.log ]` |
| Directory Exists | `[ -d dir ]` | `[ -d backup ]` |
| If Statement | `if [ ]; then` | File validation |
| Case Statement | `case VAR in` | Menu driven scripts |
| Logical AND | `cmd1 && cmd2` | `mkdir test && cd test` |
| Logical OR | `cmd1 \|\| cmd2` | `cd folder \|\| pwd` |
| Pipe | `cmd1 \| cmd2` | `ps aux \| grep nginx` |
| Redirect Output | `>` | `echo hi > file.txt` |
| Append Output | `>>` | `echo hi >> file.txt` |
| Redirect Error | `2>` | `command 2> error.log` |
| Redirect All Output | `&>` | `command &> output.log` |
| For Loop | `for i in list` | Iterate through values |
| C-Style Loop | `for (( ))` | Counter-based loops |
| While Loop | `while [ ]` | Repeat until condition |
| Until Loop | `until [ ]` | Execute until true |
| Break | `break` | Exit loop |
| Continue | `continue` | Skip iteration |
| Function | `name() { }` | Define function |
| Function Argument | `$1` | Access function input |
| Return Status | `return 0` | Success |
| Capture Output | `result=$(func)` | Store output |
| Local Variable | `local var=value` | Function scope |
| grep | `grep pattern file` | Search text |
| awk | `awk '{print $1}'` | Column processing |
| sed | `sed 's/a/b/g'` | Replace text |
| cut | `cut -d: -f1` | Extract fields |
| sort | `sort file` | Sort data |
| uniq | `uniq -c` | Count duplicates |
| tr | `tr a-z A-Z` | Translate text |
| wc | `wc -l file` | Count lines |
| head | `head -n 5` | First lines |
| tail | `tail -f file` | Live log monitoring |
| find | `find path -name file` | Search files |
| xargs | `command \| xargs` | Build commands |
| cron | `* * * * * command` | Schedule jobs |

---

##  Common Exit Codes

| Code | Meaning |
|--------|---------|
| 0 | Success |
| 1 | General Error |
| 2 | Misuse of Command |
| 126 | Permission Denied |
| 127 | Command Not Found |
| 130 | Script Interrupted (Ctrl + C) |

---

##  Debugging Options

| Command | Purpose |
|----------|---------|
| `set -e` | Exit immediately on error |
| `set -u` | Error on undefined variables |
| `set -x` | Print commands before execution |
| `set -o pipefail` | Fail if any pipeline command fails |
| `set -euo pipefail` | Recommended safe Bash settings |
| `trap cleanup EXIT` | Run cleanup before script exits |

---

# Task 1: Basics

## 1. Shebang (`#!/bin/bash`)

- **What it does:** Tells Linux which interpreter should execute the script.
- **Why it matters:** Ensures the script always runs with Bash, even if another shell is the system default.

### Example

```bash
#!/bin/bash

echo "Hello World"
```

---

## 2. Running a Script

### Make executable

```bash
chmod +x script.sh
```

Gives execute permission to the script.

### Run using execute permission

```bash
./script.sh
```

Runs the script using the interpreter defined in the shebang.

### Run explicitly with Bash

```bash
bash script.sh
```

Runs the script with Bash even if execute permission is not set.

---

## 3. Comments

Comments improve readability and documentation.

### Single-line Comment

```bash
# This is a single-line comment
```

### Inline Comment

```bash
echo "Hello"   # Print greeting
```

### Multi-line Comment

```bash
: <<'COMMENT'

This is a multi-line comment.

Useful for:
- Documentation
- Testing
- Temporarily disabling code

COMMENT
```

---

## 4. Variables

Variables store data that can be reused throughout a script.

### Declaring Variables

```bash
NAME="Jaishree"
AGE=25
```

> No spaces around `=`.

### Using Variables

```bash
echo $NAME
echo $AGE
```

### Recommended Syntax

```bash
echo "${NAME}"
```

Using braces avoids ambiguity.

### Double Quotes

Variables are expanded.

```bash
echo "Hello $NAME"
```

Output:

```text
Hello Jaishree
```

### Single Quotes

Variables are treated literally.

```bash
echo 'Hello $NAME'
```

Output:

```text
Hello $NAME
```

### Command Substitution

Store command output in a variable.

```bash
TODAY=$(date)

echo "$TODAY"
```

---

## 5. Reading User Input

The `read` command accepts input from the keyboard.

### Example

```bash
echo "Enter your name:"
read NAME

echo "Hello, $NAME"
```

### Read with Prompt

```bash
read -p "Enter your name: " NAME
```

### Read Secret Input

```bash
read -s PASSWORD
```

Input is hidden while typing.

---

## 6. Command-Line Arguments

Arguments allow users to pass values while running a script.

### Special Variables

| Variable | Meaning |
|-----------|----------|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `$@` | All arguments |
| `$?` | Exit status of previous command |
| `$$` | Current process ID |

### Example

```bash
#!/bin/bash

echo "Script Name : $0"
echo "First Arg   : $1"
echo "Second Arg  : $2"
echo "Arg Count   : $#"
echo "All Args    : $@"
```

Run:

```bash
./script.sh nginx docker
```

Output:

```text
Script Name : ./script.sh
First Arg   : nginx
Second Arg  : docker
Arg Count   : 2
All Args    : nginx docker
```

### Exit Status Example

```bash
ls /tmp

echo $?
```

Output:

```text
0
```

Meaning: Command succeeded.

```bash
ls /invalid-directory

echo $?
```

Output:

```text
2
```

Meaning: Command failed.

---

## 7. Important Paths

### Current Directory

```bash
.
```

Example:

```bash
source ./.env
```

### Parent Directory

```bash
..
```

Example:

```bash
cd ..
```

Move one directory up.

### Home Directory

```bash
~
```

Example:

```bash
cd ~
```

Go to the current user's home directory.

### Root Directory

```bash
/
```

Example:

```bash
cd /
```

Go to the filesystem root.

### Print Current Directory

```bash
pwd
```

Example:

```bash
pwd
```

Output:

```text
/home/ubuntu/scripts
```
# Task 2: Operators and Conditionals

## 1. String Comparisons

Used to compare string values.

| Operator | Meaning |
|----------|----------|
| `=` | Equal |
| `!=` | Not Equal |
| `-z` | Empty String |
| `-n` | Not Empty |

### Example

```bash
name="Linux"
empty=""

[ "$name" = "Linux" ]
[ "$name" != "Ubuntu" ]
[ -z "$empty" ]
[ -n "$name" ]
```

---

## 2. Integer Comparisons

Used to compare numeric values.

| Operator | Meaning |
|----------|----------|
| `-eq` | Equal |
| `-ne` | Not Equal |
| `-lt` | Less Than |
| `-gt` | Greater Than |
| `-le` | Less Than or Equal |
| `-ge` | Greater Than or Equal |

### Example

```bash
a=10
b=20

[ $a -eq $b ]
[ $a -ne $b ]
[ $a -lt $b ]
[ $b -gt $a ]
[ $a -le $b ]
[ $b -ge $a ]
```

---

## 3. File Test Operators

Used to check files, directories, and permissions.

| Operator | Meaning |
|----------|----------|
| `-f` | File exists |
| `-d` | Directory exists |
| `-e` | File or Directory exists |
| `-r` | Read permission |
| `-w` | Write permission |
| `-x` | Execute permission |
| `-s` | File is not empty |

### Example

```bash
file="test.txt"
dir="backup"

[ -f "$file" ]
[ -d "$dir" ]
[ -e "$file" ]
[ -r "$file" ]
[ -w "$file" ]
[ -x "$file" ]
[ -s "$file" ]
```

---

## 4. if, elif, else

- **if**: Checks the first condition. If true, executes the code block.
- **elif**: Checks another condition if the previous condition is false.
- **else**: Executes when none of the conditions are true.

### Syntax

```bash
if [ condition ]; then
    commands
elif [ condition ]; then
    commands
else
    commands
fi
```

### Example

```bash
FILE="config.txt"

if [ -f "$FILE" ]; then
    echo "File Found"
elif [ -d "$FILE" ]; then
    echo "Directory Found"
else
    echo "Not Found"
fi
```

---

## 5. Logical Operators

- **&& (AND)**: Executes the next command only if the first command succeeds.
- **|| (OR)**: Executes the next command only if the first command fails.
- **! (NOT)**: Reverses the result of a condition.

| Operator | Meaning |
|----------|---------|
| `&&` | AND |
| OR (`\|\|`) | Execute if previous command fails |
| `!` | NOT |

### Example

```bash
mkdir test && cd test

cd backup || pwd

! [ -f test.txt ]
```

---

## 6. Case Statement

- Used to handle multiple conditions more cleanly than many `if-elif-else` blocks.

### Syntax

```bash
case $variable in
    pattern1)
        commands
        ;;
    pattern2)
        commands
        ;;
    *)
        commands
        ;;
esac
```

### Example

```bash
action="start"

case $action in
    start)   systemctl start nginx ;;
    stop)    systemctl stop nginx ;;
    restart) systemctl restart nginx ;;
    status)  systemctl status nginx ;;
    *) echo "Usage: start | stop | restart | status" ;;
esac
```
# Task 3: Loops

## 1. for Loop

- Repeats a block of code for each item in a list.

### List-Based For Loop

```bash
for USER in root ubuntu jaishree; do
    echo "$USER"
done
```

### C-Style For Loop

```bash
for ((i=1; i<=5; i++)); do
    echo "$i"
done
```

---

## 2. while Loop

- Repeats commands while the condition is true.

```bash
count=1

while [ $count -le 5 ]; do
    echo "$count"
    ((count++))
done
```

### Read File Line by Line

```bash
while read LINE; do
    echo "$LINE"
done < /etc/hostname
```

---

## 3. until Loop

- Repeats commands until the condition becomes true.

```bash
count=1

until [ $count -gt 5 ]; do
    echo "$count"
    ((count++))
done
```

### Practical Example

```bash
until ping -c 1 google.com >/dev/null 2>&1; do
    echo "Waiting for internet..."
    sleep 3
done
```

---

## 4. Loop Control

### break

- Stops the loop immediately.

```bash
for i in 1 2 3 4 5; do
    [ "$i" -eq 3 ] && break
    echo "$i"
done
```

### continue

- Skips the current iteration and moves to the next one.

```bash
for i in 1 2 3 4 5; do
    [ "$i" -eq 3 ] && continue
    echo "$i"
done
```

---

## 5. Looping Over Files

- Process multiple files matching a pattern.

```bash
for FILE in *.log; do
    echo "Processing $FILE"
done
```

### Count Lines in Log Files

```bash
for FILE in *.log; do
    wc -l "$FILE"
done
```

---

## 6. Looping Over Command Output

- Process command output line by line.

```bash
ls *.txt | while read LINE; do
    echo "File: $LINE"
done
```

### Running Services Example

```bash
systemctl list-units --type=service --state=running | while read LINE; do
    echo "$LINE"
done
```
# Task 4: Functions

## 1. Defining a Function

- A function groups commands together so they can be reused.

```bash
greet() {
    echo "Hello DevOps"
}
```

---

## 2. Calling a Function

- Call the function using its name.

```bash
greet() {
    echo "Hello DevOps"
}

greet
```

---

## 3. Passing Arguments to Functions

- Use `$1`, `$2`, etc. inside the function to access arguments.

```bash
add() {
    echo "First Number: $1"
    echo "Second Number: $2"
}

add 10 20
```

### Practical Example

```bash
create_user() {
    useradd "$1"
    echo "User $1 created"
}

create_user devops
```

---

## 4. Return Values

### return

- Returns a status code (0-255).

```bash
check_service() {
    systemctl is-active --quiet "$1"
    return $?
}

check_service ssh

echo $?
```

### echo

- Returns output that can be stored in a variable.

```bash
get_date() {
    echo "$(date)"
}

today=$(get_date)

echo "$today"
```

---

## 5. Local Variables

- Variables declared with `local` exist only inside the function.

```bash
count_files() {
    local total

    total=$(ls "$1" | wc -l)

    echo "Files: $total"
}

count_files /var/log
```

### Example

```bash
name="Global"

show_name() {
    local name="Local"
    echo "$name"
}

show_name

echo "$name"
```

Output:

```text
Local
Global
```
# Task 5: Text Processing Commands

## 1. grep
- Searches for text patterns in files.
- Common flags:
  - `-i` Ignore case
  - `-r` Search recursively
  - `-c` Count matches
  - `-n` Show line numbers
  - `-v` Show non-matching lines
  - `-E` Extended regex

```bash
grep -i "error" /var/log/syslog
grep -r "TODO" .
grep -n "sshd" /etc/ssh/sshd_config
```

## 2. awk
- Processes text by columns and patterns.
- Common uses:
  - Print columns
  - Custom delimiters
  - Pattern matching
  - BEGIN/END blocks

```bash
awk '{print $1}' file.txt
awk -F: '{print $1,$3}' /etc/passwd
awk '/root/ {print $1}' /etc/passwd
awk 'BEGIN {print "Start"} END {print "Done"}'
```

## 3. sed
- Edits and transforms text streams.
- Common uses:
  - Replace text
  - Delete lines
  - Edit files directly

```bash
sed 's/error/ERROR/' file.txt
sed '2d' file.txt
sed -i 's/error/ERROR/g' file.txt
```

## 4. cut
- Extracts specific fields from text.

```bash
cut -d ":" -f1 /etc/passwd
cut -d "," -f2 users.csv
```

## 5. sort
- Sorts data alphabetically or numerically.

```bash
sort file.txt
sort -n numbers.txt
sort -r file.txt
sort -u file.txt
```

## 6. uniq
- Removes duplicate lines from sorted input.

```bash
sort file.txt | uniq
sort file.txt | uniq -c
uniq -u file.txt
```

## 7. tr
- Translates or deletes characters.

```bash
echo "hello" | tr 'a-z' 'A-Z'
echo "abc123" | tr -d '0-9'
```

## 8. wc
- Counts lines, words, and characters.

```bash
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

## 9. head / tail
- Displays first or last lines of a file.

```bash
head -n 5 file.txt
tail -n 5 file.txt
tail -f /var/log/syslog
```
# Task 6: Useful Patterns and One-Liners

## 1. Delete old log files
```bash
find /var/log -name "*.log" -mtime +15 -delete
```

## 2. Count lines in all log files
```bash
wc -l /var/log/*.log
```

## 3. Replace text across multiple files
```bash
sed -i 's/oldserver/newserver/g' *.conf
```

## 4. Check if a service is running
```bash
systemctl is-active --quiet nginx && echo "Running" || echo "Stopped"
```

## 5. Show top 5 memory-consuming processes
```bash
ps aux --sort=-%mem | head -6
```

## 6. Find large files (>100 MB)
```bash
find /var/log -type f -size +100M
```

## 7. Tail logs and filter errors
```bash
tail -f /var/log/syslog | grep -E "ERROR|CRITICAL"
```

## 8. Monitor disk usage
```bash
df -h | awk '$5+0 > 80 {print $0}'
```

# Task 7: Error Handling and Debugging

## Best Practice

Use the following in production scripts:

```bash
set -euo pipefail
```

- `-e` → Exit on command failure
- `-u` → Error on unset variables
- `-o pipefail` → Fail if any command in a pipeline fails

---

## Exit Codes

Exit codes indicate whether a command succeeded or failed.

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | General Error |
| `$?` | Exit status of last command |

### Example

```bash
ls file.txt
echo $?

if [ -f file.txt ]; then
    echo "File exists"
    exit 0
else
    echo "File not found"
    exit 1
fi
```

---

## Debugging Options

| Command | Purpose |
|----------|---------|
| `set -e` | Exit on command failure |
| `set -u` | Error on unset variables |
| `set -x` | Show commands before execution |
| `set -o pipefail` | Fail if any pipeline command fails |
| `trap cleanup EXIT` | Run cleanup before script exits |

### Example

```bash
#!/bin/bash

set -euo pipefail

echo "Starting script"

FILE="/tmp/demo.txt"

trap 'rm -f "$FILE"; echo "Cleanup completed"' EXIT

echo "Hello" > "$FILE"

cat "$FILE"
```

### Debug Mode

```bash
#!/bin/bash

set -x

name="Jaishree"
echo "Hello $name"
```

### Pipefail Example

```bash
false | true
echo $?
```

Without:

```bash
set -o pipefail
```

Output:

```text
0
```

With:

```bash
set -o pipefail
```

Output:

```text
1
```
