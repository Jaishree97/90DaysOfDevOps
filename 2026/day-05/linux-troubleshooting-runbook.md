# RUNBOOK for SSH & Nginx Services

This runbook provides quick troubleshooting steps to verify SSH and Nginx service health on an AWS EC2 Ubuntu server.

## Environment Basics

- **Command:** `uname -a`

  **Output:**
  ```text
  Linux ip-172-31-4-106 7.0.0-1004-aws #4-Ubuntu SMP PREEMPT Mon Apr 13 13:14:24 UTC 2026 x86_64 GNU/Linux
  ```

  **Observation:** AWS Ubuntu kernel and architecture confirmed.

- **Command:** `cat /etc/os-release`

  **Output:**
  ```text
  PRETTY_NAME="Ubuntu 26.04 LTS"
  VERSION="26.04 (Resolute Raccoon)"
  ```

  **Observation:** Ubuntu 26.04 LTS verified.

---

## Filesystem Sanity

- **Command:** `mkdir /tmp/runbook-demo`

  **Observation:** Temporary troubleshooting directory created successfully.

- **Command:** `cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo`

  **Output:**
  ```text
  -rw-r--r-- 1 ubuntu ubuntu ... hosts-copy
  ```

  **Observation:** Filesystem is writable and file copy operation succeeded.

---

## CPU & Memory

- **Command:** `top`

  **Observation:** CPU idle ~99%, system load is very low.

- **Command:** `ps aux --sort=-%cpu | head`

  **Observation:** No abnormal CPU-consuming processes detected.

- **Command:** `ps aux --sort=-%mem | head`

  **Observation:** Memory usage within normal range.

- **Command:** `free -h`

  **Output:**
  ```text
  Mem: 908Mi total
  Used: 318Mi
  Free: 184Mi
  Available: 590Mi
  ```

  **Observation:** Sufficient memory available. No memory pressure detected.

---

## Disk / I/O

- **Command:** `df -h`

  **Output:**
  ```text
  /dev/root 6.7G 2.3G 4.4G 34% /
  ```

  **Observation:** Root filesystem utilization is 34%.

- **Command:** `iostat`

  **Observation:** Disk I/O activity is low. No storage bottlenecks observed.

---

## Network

- **Command:** `ss -tulpn`

  **Output:**
  ```text
  0.0.0.0:22
  0.0.0.0:80
  ```

  **Observation:** SSH and Nginx are listening on expected ports.

- **Command:** `sudo ss -tulpn | grep sshd`

  **Observation:** SSH daemon is actively listening on port 22.

- **Command:** `nc -zv localhost 22`

  **Output:**
  ```text
  Connection to localhost 22 port [tcp/ssh] succeeded
  ```

  **Observation:** SSH port is reachable.

- **Command:** `curl -I localhost`

  **Output:**
  ```text
  HTTP/1.1 200 OK
  Server: nginx/1.28.3
  ```

  **Observation:** Nginx is serving requests successfully.

---

## Logs Reviewed

- **Command:** `sudo journalctl -u ssh -n 10`

  **Observation:** SSH service started successfully and accepted public-key authentication.

- **Command:** `sudo journalctl -u nginx -n 10`

  **Observation:** Nginx started successfully with no recent errors.

- **Command:** `sudo tail -5 /var/log/nginx/access.log`

  **Observation:** Recent HTTP requests returned status code 200.

---

## Configuration Validation

- **Command:** `sudo nginx -t`

  **Output:**
  ```text
  nginx: configuration file syntax is ok
  nginx: configuration file test is successful
  ```

  **Observation:** Nginx configuration is valid.

---

## Quick Findings

- SSH service is active and accepting connections.
- Nginx service is running and responding with HTTP 200 OK.
- CPU and memory utilization are healthy.
- Root filesystem usage is only 34%.
- SSH port 22 is reachable.
- No critical errors found in logs.
- Nginx configuration validation passed.

---

## If This Worsens

1. Review SSH authentication failures:
   ```bash
   sudo grep "Failed password" /var/log/auth.log
   ```

2. Validate Nginx configuration:
   ```bash
   sudo nginx -t
   ```

3. Review Nginx error logs:
   ```bash
   sudo tail -50 /var/log/nginx/error.log
   ```

4. Check active connections:
   ```bash
   ss -ant
   ```

5. Restart affected service if required:
   ```bash
   sudo systemctl restart nginx
   sudo systemctl restart ssh
   ```
