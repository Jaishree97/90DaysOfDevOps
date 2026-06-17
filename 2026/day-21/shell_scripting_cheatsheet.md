# 🚀 Shell Scripting Cheat Sheet

A quick reference guide for Shell Scripting concepts, loops, functions, text processing tools, debugging techniques, and common DevOps scripting patterns.

---

## 📚 Table of Contents

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

## ⚡ Quick Reference Table

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
| Function | `name(){}` | Define function |
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

## 🔢 Common Exit Codes

| Code | Meaning |
|--------|---------|
| 0 | Success |
| 1 | General Error |
| 2 | Misuse of Command |
| 126 | Permission Denied |
| 127 | Command Not Found |
| 130 | Script Interrupted (Ctrl + C) |

---

## 🐞 Debugging Options

| Command | Purpose |
|----------|---------|
| `set -e` | Exit immediately on error |
| `set -u` | Error on undefined variables |
| `set -x` | Print commands before execution |
| `set -o pipefail` | Fail if any pipeline command fails |
| `trap cleanup EXIT` | Run cleanup before script exits |

---
