# 🚀 Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic | Syntax | Example |
|--------|---------|---------|
| Make Executable | `chmod +x file.sh` | `chmod +x script.sh` |
| Run Script | `./file.sh` | `./script.sh` |
| Comment | `# comment` | `echo "Hi" # inline comment` |
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Use Variable | `$VAR` | `echo $NAME` |
| Read Input | `read VAR` | `read USER` |
| Arguments | `$1 $2 $# $@ $?` | `./script.sh arg1` |
| String Compare | `[ "$a" = "$b" ]` | `[ "$name" = "Linux" ]` |
| Integer Compare | `[ $a -gt 10 ]` | `[ $num -eq 5 ]` |
| File Test | `[ -f file ]` | `[ -d /home ]` |
| If Condition | `if [ condition ]; then` | `if [ -f file ]; then echo OK; fi` |
| Case Statement | `case $var in ... esac` | `case $1 in start) echo run ;; esac` |
| Logical AND | `cmd1 && cmd2` | `mkdir test && cd test` |
| Logical OR | `cmd1 \|\| cmd2` | `cd dir \|\| pwd` |
| For Loop | `for i in list; do` | `for i in 1 2 3; do echo $i; done` |
| C-Style Loop | `for ((i=1;i<=3;i++))` | `for ((i=1;i<=3;i++)); do touch f$i; done` |
| While Loop | `while [ condition ]; do` | `while [ $a -lt 5 ]; do echo $a; done` |
| Until Loop | `until [ condition ]; do` | `until ping -c1 google.com; do sleep 2; done` |
| Break | `break` | `if [ $i -eq 5 ]; then break; fi` |
| Continue | `continue` | `if [ $i -eq 2 ]; then continue; fi` |
| Function | `name() { ... }` | `greet(){ echo "Hi"; }` |
| Function Argument | `$1 inside function` | `add(){ echo $(($1+$2)); }` |
| Return Status | `return 0` | `return 1` |
| Capture Output | `result=$(func)` | `today=$(date)` |
| Local Variable | `local var=value` | `local count=10` |
| grep | `grep pattern file` | `grep -i "error" log.txt` |
| awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| sed | `sed 's/a/b/g' file` | `sed -i 's/foo/bar/g' file.txt` |
| cut | `cut -d: -f1 file` | `cut -d: -f1 /etc/passwd` |
| sort | `sort file` | `sort -n numbers.txt` |
| uniq | `sort file \| uniq` | `sort file \| uniq -c` |
| tr | `tr 'a-z' 'A-Z'` | `echo hi \| tr 'a-z' 'A-Z'` |
| wc | `wc -l file` | `wc -w file.txt` |
| head | `head -n 5 file` | `head -n 10 log.txt` |
| tail | `tail -f file` | `tail -f app.log` |

---

## Common Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | General Error |
| `2` | Misuse of Command |
| `126` | Permission Denied |
| `127` | Command Not Found |
| `130` | Script Terminated (Ctrl+C) |

---

## Debugging Options

| Command | Purpose |
|----------|---------|
| `set -e` | Exit on first error |
| `set -u` | Error on undefined variable |
| `set -x` | Print commands before execution |
| `set -o pipefail` | Fail if any command in a pipeline fails |
| `trap cleanup EXIT` | Run cleanup function before exit |

---

---

# Task 1: Basics

## 1. Shebang (#!/bin/bash)

- What it does: Tells the system which shell should execute the script.
- Why it matters: Ensures the script runs with the correct interpreter.

### Syntax

```bash
#!/bin/bash
```

### Example

```bash
#!/bin/bash
echo "Hello World"
```

---

## 2. Running a Script

- Make the script executable using `chmod`.
- Run it directly or through bash.

### Syntax

```bash
chmod +x script.sh
./script.sh
```

### Example

```bash
chmod +x hello.sh
./hello.sh
```

---

## 3. Comments

- Comments help explain code.
- Shell ignores comments during execution.

### Syntax

```bash
# This is a comment
```

### Example

```bash
# Print welcome message
echo "Welcome"
```

---

## 4. Variables

- Variables store data.
- No spaces around `=`.

### Syntax

```bash
NAME="DevOps"
```

### Example

```bash
NAME="DevOps"

echo $NAME
```

---

## 5. Reading User Input

- The `read` command stores user input into a variable.

### Syntax

```bash
read VARIABLE
```

### Example

```bash
echo "Enter your name:"
read NAME

echo "Hello, $NAME"
```

---

## 6. Command-Line Arguments

- `$0` → Script name
- `$1` → First argument
- `$2` → Second argument
- `$#` → Number of arguments
- `$@` → All arguments
- `$?` → Exit status of last command

### Example

```bash
#!/bin/bash

echo "Script Name: $0"
echo "First Argument: $1"
echo "Total Arguments: $#"
echo "All Arguments: $@"
```

---

# Task 2: Operators and Conditionals

## 1. String Comparisons

- `=` → Equal
- `!=` → Not Equal
- `-z` → Empty string
- `-n` → Non-empty string

### Example

```bash
name="Linux"

[ "$name" = "Linux" ]
[ "$name" != "Ubuntu" ]
[ -n "$name" ]
[ -z "$empty" ]
```

---

## 2. Integer Comparisons

- `-eq` → Equal
- `-ne` → Not Equal
- `-lt` → Less Than
- `-gt` → Greater Than
- `-le` → Less Than or Equal
- `-ge` → Greater Than or Equal

### Example

```bash
a=10
b=20

[ $a -lt $b ]
[ $a -ne $b ]
```

---

## 3. File Test Operators

- `-f` → Regular file exists
- `-d` → Directory exists
- `-e` → File exists
- `-r` → Read permission
- `-w` → Write permission
- `-x` → Execute permission

### Example

```bash
FILE="test.txt"

[ -f "$FILE" ]
[ -r "$FILE" ]
```

---

## 4. if, elif, else

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

if [ -d "$FILE" ]; then
    echo "Directory"

elif [ -f "$FILE" ]; then
    echo "File"

else
    echo "Not Found"
fi
```

---

## 5. Logical Operators

- `&&` → AND
- `||` → OR
- `!` → NOT

### Example

```bash
mkdir test && cd test

cd myfolder || pwd

! ls missing.txt
```

---

## 6. Case Statements

### Syntax

```bash
case $VAR in

pattern1)
    commands
    ;;

pattern2)
    commands
    ;;

*)
    default
    ;;

esac
```

### Example

```bash
action="start"

case $action in

start)
    systemctl start nginx
    ;;

stop)
    systemctl stop nginx
    ;;

*)
    echo "Invalid option"
    ;;

esac
```

---

# Task 3: Loops

## 1. For Loop

### Syntax

```bash
for ITEM in list; do
    commands
done
```

### Example

```bash
for USER in root ubuntu devops; do
    echo $USER
done
```

---

## 2. C-Style For Loop

### Syntax

```bash
for (( i=1; i<=5; i++ )); do
    commands
done
```

### Example

```bash
for (( i=1; i<=3; i++ )); do
    touch file$i.txt
done
```

---

## 3. While Loop

### Syntax

```bash
while [ condition ]; do
    commands
done
```

### Example

```bash
COUNT=1

while [ $COUNT -le 5 ]; do
    echo $COUNT
    ((COUNT++))
done
```

---

## 4. Until Loop

### Syntax

```bash
until [ condition ]; do
    commands
done
```

### Example

```bash
COUNT=1

until [ $COUNT -gt 5 ]; do
    echo $COUNT
    ((COUNT++))
done
```

---

## 5. Loop Control

### Break

```bash
for i in {1..10}; do
    [ $i -eq 5 ] && break
    echo $i
done
```

### Continue

```bash
for i in {1..5}; do
    [ $i -eq 3 ] && continue
    echo $i
done
```

---

# Task 4: Functions

## 1. Defining a Function

### Syntax

```bash
function_name() {
    commands
}
```

### Example

```bash
greet() {
    echo "Hello DevOps"
}

greet
```

---

## 2. Function Arguments

### Example

```bash
add() {
    echo $(($1 + $2))
}

add 10 20
```

---

## 3. Return Status

### Example

```bash
check_file() {

    if [ -f "$1" ]; then
        return 0
    fi

    return 1
}

check_file test.txt

echo $?
```
# Task 4: Functions

## 1. Defining a Function

### Syntax

```bash
function_name() {
    # commands
}
```

### Example

```bash
say_hello() {

    echo "Hello!"

}
```

---

## 2. Calling a Function

### Syntax

```bash
function_name
```

### Example

```bash
say_hello
```

---

## 3. Passing Arguments to Functions

- `$1`, `$2`, `$3` can be used inside functions.

### Syntax

```bash
function_name() {

    echo "$1"    # first argument
    echo "$2"    # second argument

}

function_name arg1 arg2
```

### Example

```bash
add() {

    num1=$1
    num2=$2

    sum=$(( num1 + num2 ))

    echo "The sum of $num1 and $num2 is: $sum"

}

add 2 3
```

---

## 4. Return Values

- Use `return` for status codes (0–255).
- Use `echo` when you need to return actual values.

### a) return

#### Syntax

```bash
function_name() {

    # commands

    return <status_code>   # 0-255
}

function_name

echo $?     # captures the return status
```

#### Example

```bash
check_service() {

    systemctl is-active --quiet "$1"

    if [ $? -eq 0 ]; then

        return 0      # service is running

    else

        return 1      # service is not running

    fi
}

check_service nginx

if [ $? -eq 0 ]; then

    echo "nginx is running"

else

    echo "nginx is not running"

fi

echo $?
```

---

### b) echo

#### Syntax

```bash
function_name() {

    echo <value>
}

result=$(function_name)

echo $result
```

#### Example

```bash
get_disk_usage() {

    du -sh "$1" | awk '{print $1}'
}

usage=$(get_disk_usage /var/log)

echo "Disk usage of /var/log: $usage"
```
## 5. Local Variables

Variables declared with `local` exist only inside the function and don't affect the global environment.

### Syntax

```bash
function_name() {

    local var_name=value

    # use var_name inside function
}
```

### Example

```bash
count_files() {

    local total=$(ls "$1" | wc -l)

    echo "Total files in $1: $total"
}

count_files /var/log

echo $total
# empty because total is local
```

---

# Task 5: Text Processing Commands

## 1. grep

Search for text patterns in files or input.

### Syntax

```bash
grep [options] "pattern" file
```

### Common Options

- `-i` : ignore case
- `-r` : recursive search
- `-c` : count matching lines
- `-n` : show line numbers
- `-v` : show non-matching lines
- `-E` : extended regex

### Examples

```bash
grep -i "error" /var/log/syslog
# Matches error, Error, ERROR

grep -r "TODO" /home/user/project
# Search recursively

grep -c "failed login" /var/log/auth.log
# Count matches

grep -n "sshd" /etc/ssh/sshd_config
# Show line numbers

grep -v "INFO" /var/log/syslog
# Exclude INFO lines

grep -E "error|fail" /var/log/syslog
# Match error OR fail
```

---

## 2. awk

Process and extract text from files or input, especially by columns/fields.

### Syntax

```bash
awk 'pattern { action }' file
```

### Examples

#### Print Columns

```bash
awk '{print $1, $2}' file

awk '{print $1}' /etc/passwd
```

#### Custom Field Separator

```bash
awk -F":" '{print $1, $3}' file

awk -F":" '{print $1, $3}' /etc/passwd
```

#### Pattern Matching

```bash
awk '/root/ {print $1}' file

awk '/root/ {print $1}' /etc/passwd
```

#### BEGIN and END Blocks

```bash
awk 'BEGIN { ... } { ... } END { ... }' file

awk 'BEGIN {print "Users list:"} {print $1} END {print "Done"}' /etc/passwd
```

---

## 3. sed

Edit or transform text streams by replacing, deleting, or modifying lines.

### Syntax

```bash
sed [options] 'command' file
```

### Examples

#### Replace First Match

```bash
sed 's/pattern/replacement/' file

sed 's/error/ERROR/' file.txt
```

#### Delete Line

```bash
sed 'Nd' file

sed '2d' file.txt
```

#### In-place Edit

```bash
sed -i 's/pattern/replacement/g' file

sed -i 's/error/ERROR/g' file.txt
```

---

## 4. cut

Extract specific columns or fields using a delimiter.

### Syntax

```bash
cut -d "delimiter" -f N file
```

- `-d` : field delimiter
- `-f` : field number(s)

### Example

```bash
cut -d ":" -f1 /etc/passwd

# Extract usernames
```

---

## 5. sort

Arrange lines alphabetically, numerically, or uniquely.

### Syntax

```bash
sort [options] file
```

### Common Options

```bash
-n   # numeric sort
-r   # reverse order
-u   # unique values
```

### Examples

```bash
sort file.txt

sort -n numbers.txt

sort -r file.txt

sort -u file.txt
```

---

## 6. uniq

Remove consecutive duplicate lines and count occurrences.

### Syntax

```bash
uniq [options] [input_file]
```

### Examples

```bash
sort file.txt | uniq
# Remove duplicates

sort file.txt | uniq -c
# Count duplicates

uniq -u file.txt
# Only unique lines
```

> Note: `uniq` works correctly only when duplicate lines are adjacent. Use `sort` first if needed.

---

## 7. tr

Translate or delete characters from input.

### Syntax

```bash
tr [options] SET1 [SET2]
```

### Examples

```bash
echo "hello" | tr 'a-z' 'A-Z'
# HELLO

echo "hello123" | tr -d '0-9'
# hello
```

---

## 8. wc

Count lines, words, and characters.

### Syntax

```bash
wc [options] [file]
```

### Examples

```bash
wc -l file.txt
# line count

wc -w file.txt
# word count

wc -c file.txt
# character count
```

---

## 9. head / tail

Display the first or last N lines of a file.

### Syntax

```bash
head [options] filename

tail [options] filename
```

### Examples

```bash
head -n 5 file.txt
# first 5 lines

tail -n 5 file.txt
# last 5 lines

tail -f /var/log/nginx/access.log
# follow live updates
```

---

# Task 6: Useful Patterns and One-Liners

### Find and Delete Files Older Than N Days

```bash
find /var/log -type f -name "*.log" -mtime +15 -exec rm -f {} \;
```

### Count Lines in All Log Files

```bash
wc -l /var/log/*.log
```

### Replace a String Across Multiple Files

```bash
sed -i 's/db.oldserver.com/db.newserver.com/g' /etc/myapp/conf.d/*.conf
```

### Check Whether a Service Is Running

```bash
systemctl is-active --quiet nginx && echo "Running" || echo "Stopped"
```

### Monitor Disk Usage and Send Alert

```bash
df -h | awk '$5+0 > 80 {print $0}' | mail -s "Disk Usage Alert on $(hostname)" your.email@example.com
```

### Tail a Log and Filter Errors in Real Time

```bash
tail -f /var/log/syslog | grep -E 'ERROR|CRITICAL'
```

---

# Task 7: Error Handling and Debugging

## Exit Codes

- `$?` stores the exit status of the last command.
- `0` means success.
- Non-zero values indicate failure or a specific error condition.

### Example

```bash
#!/bin/bash

ls myfile.txt

echo "Exit status of ls command: $?"

if [ -f myfile.txt ]; then
    echo "File exists"
    exit 0
else
    echo "File does not exist"
    exit 1
fi
```

### Exit Status Summary

| Command | Meaning |
|----------|----------|
| `ls myfile.txt` | Attempts to list the file |
| `$?` | Exit status of previous command |
| `0` | Success |
| Non-zero | Failure |
| `exit 0` | Script exits successfully |
| `exit 1` | Script exits with failure |

---

## Debugging and Safe Scripting Options

| Command | Meaning | Example |
|----------|----------|----------|
| `set -e` | Exit immediately if a command fails | `false` → script exits |
| `set -u` | Error on undefined variables | `echo $name` when unset |
| `set -o pipefail` | Fail pipeline if any command fails | `false \| true` returns failure |
| `set -x` | Print commands before execution | Useful for debugging |
| `trap 'cleanup' EXIT` | Run cleanup function when script exits | Cleanup temporary files |

### Example

```bash
#!/bin/bash

set -e
set -u
set -o pipefail
set -x

cleanup() {
    echo "Cleaning up..."
}

trap cleanup EXIT

echo "Starting script"

false

echo "This line will never execute"
```
