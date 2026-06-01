# Linux Commands Cheat Sheet

## Process Management

- `ps aux` - Display all running processes.
- `top` - Monitor processes in real time.
- `kill -9 PID` - Force terminate a process.
- `pkill process_name` - Kill process by name.
- `pgrep process_name` - Find process IDs by name.
- `systemctl status service` - Check service status.
- `systemctl restart service` - Restart a service.

## File System

- `pwd` - Show current working directory.
- `find` - Search for files and directories.
- `grep pattern file` - Search text in files.
- `awk '{print $1}' file` - Extract specific columns.
- `sed 's/old/new/' file` - Replace text in a file.
- `cut -d':' -f1 file` - Extract fields from text.
- `tail -f logfile.log` - Monitor logs in real time.
- `wc -l file.txt` - Count lines in a file.
- `ln source target` - Create a hard link.
- `ln -s source target` - Create a symbolic link.
- `rm -r directory` - Remove directory recursively.
- `df -h` - Show disk usage.
- `du -sh directory` - Show directory size.

## Networking Troubleshooting

- `ping google.com` - Check network connectivity.
- `ip addr` - Display IP address information.
- `curl https://google.com` - Test website response.
- `dig google.com` - DNS lookup.
- `ss -tulpn` - Show listening ports.
- `hostnamectl` - Display hostname and OS information.

## System Monitoring

- `free -h` - Show memory usage.
- `uptime` - Display system uptime.
- `df -h | awk 'NR==2 {print $5}'` - Show disk usage percentage.
- `free -h | awk 'NR==2 {print $3}'` - Show used memory.
