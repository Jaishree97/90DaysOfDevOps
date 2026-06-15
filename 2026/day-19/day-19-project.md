# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

---

# Task 1: Log Rotation Script

Create `log_rotate.sh` that:

1. Takes a log directory as an argument (e.g., `/var/log/demo`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist

### Here is the script log_rotate.sh

[log_rotate.sh](./scripts/log_rotate.sh)

### Output

![Log Rotation Output](./images/01-log-rotate.png)

---

# Task 2: Server Backup Script

Create `backup.sh` that:

1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days
6. Handles errors if source or destination doesn't exist

### Here is the script backup.sh

[backup.sh](./scripts/backup.sh)

### Output

![Backup Output](./images/02-backup.png)

---

# Task 3: Crontab

## Check Existing Cron Jobs

```bash
crontab -l
```

## Cron Syntax

```text
* * * * * command
| | | | |
| | | | +----- Day of Week (0-7)
| | | +------- Month (1-12)
| | +--------- Day of Month (1-31)
| +----------- Hour (0-23)
+------------- Minute (0-59)
```

## Cron Entries

### Run log rotation every day at 2 AM

```cron
0 2 * * *
```

### Run backup every Sunday at 3 AM

```cron
0 3 * * 0
```

### Run health check every 5 minutes

```cron
*/5 * * * *
```

---

# Task 4: Combine — Scheduled Maintenance Script

Create `maintenance.sh` that:

1. Calls the log rotation script
2. Calls the backup script
3. Logs all output to `/var/log/maintenance.log`
4. Can be scheduled using cron

### Cron Entry

Run daily at 1 AM

```cron
0 1 * * *
```

### Here is the script maintenance.sh

[maintenance.sh](./scripts/maintenance.sh)

### Output

![Maintenance Output](./images/03-maintenance.png)

---

# What I Learned

- Learned how to automate log rotation using Shell Scripting.
- Used `find` with `-mtime` to identify old files.
- Compressed log files using `gzip`.
- Created timestamped backups using `tar`.
- Removed old backup archives automatically.
- Implemented error handling using shell scripting.
- Learned cron syntax and scheduling jobs.
- Combined multiple scripts into a single maintenance workflow.
- Logged maintenance activities into a log file.
- Improved Linux automation and scripting skills.
