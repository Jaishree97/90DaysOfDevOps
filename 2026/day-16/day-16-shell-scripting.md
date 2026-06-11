# Shell Scripting Basics

## Task 1: First Script

1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it

- Why do we use the shebang line?

  - `#!/bin/bash` tells Linux to execute the script using the Bash shell.
  - It ensures the script runs with the intended interpreter.

- What happens if you remove the shebang line?

  - `./hello.sh` → May still work depending on the current shell.
  - `bash hello.sh` → Executes the script using Bash.
  - `sh hello.sh` → Executes the script using sh, which may behave differently from Bash.

[Here is the script hello.sh](scripts/hello.sh)

![hello](images/01-hello.png)

---

## Task 2: Variables

1. Create `variables.sh` with:
   - A variable for your NAME
   - A variable for your ROLE (e.g. "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`

2. Try using single quotes vs double quotes — what's the difference?

- Double quotes `" "` allow variable expansion.
- Single quotes `' '` treat the content as literal text.

[Here is the script variables.sh](scripts/variables.sh)

![variables](images/02-variable.png)

---

## Task 3: User Input with read

1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

[Here is the script greet.sh](scripts/greet.sh)

![greet](images/03-greet.png)

---

## Task 4: If-Else Conditions

1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is positive, negative, or zero

[Here is the script check_number.sh](scripts/check_number.sh)

![check-number](images/04-check-number.png)

2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file exists using `-f`
   - Prints appropriate message

[Here is the script file_check.sh](scripts/file_check.sh)

![file-check](images/05-file-check.png)

---

## Task 5: Combine It All

Create `server_check.sh` that:

1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's active or not
4. If `n` — prints "Skipped."

[Here is the script server_check.sh](scripts/server_check.sh)

![server-check](images/06-service-check.png)

---

# What I learned -

- How to write and execute Bash scripts using `#!/bin/bash`.
- Working with variables and variable expansion.
- Taking user input using the `read` command.
- Understanding the difference between single and double quotes.
- Using conditional statements (`if`, `elif`, `else`) in Bash.
- Checking file existence using the `-f` operator.
- Verifying service status using `systemctl is-active`.
- Making scripts executable using `chmod +x`.
