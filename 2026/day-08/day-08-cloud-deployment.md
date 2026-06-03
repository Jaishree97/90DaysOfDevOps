# Day 08 - Cloud Deployment & Log Management

## Commands Used

### Connect to EC2

```bash
ssh -i "miya.pem" ubuntu@ec2-34-221-88-167.us-west-2.compute.amazonaws.com
```

Connected securely to my Ubuntu EC2 instance using SSH.

### Update Packages

```bash
sudo apt update -y
```

Updated package information from Ubuntu repositories.

### Install Nginx

```bash
sudo apt install nginx -y
```

Installed the Nginx web server.

### Verify Nginx Status

```bash
systemctl status nginx
```

Checked that the Nginx service was running successfully.

### Verify Installed Package

```bash
dpkg -l | grep nginx
dpkg -s nginx
```

Confirmed that Nginx was installed and viewed package details.

### Create Custom Web Page

```bash
cd /var/www/html
echo "Jaishree Chaure, Nagpur" | sudo tee index.nginx-debian.html
```

Modified the default Nginx page with my own content.

### View Running Services

```bash
systemctl list-units --type=service --state=running
```

Displayed currently running services on the server.

### View Nginx Logs

```bash
sudo journalctl -u nginx -n 20
```

Viewed the latest 20 Nginx log entries.

### Save Logs

```bash
sudo journalctl -u nginx -n 20 > ~/nginx-logs.txt
```

Saved the logs to a file.

### Verify Log File

```bash
ls -l
cat nginx-logs.txt
```

Verified the file and checked its contents.

### Download Log File

```bash
scp -i "miya.pem" ubuntu@ec2-34-221-88-167.us-west-2.compute.amazonaws.com:~/nginx-logs.txt .
```

Downloaded the log file from EC2 to my local machine.

---

## Challenges Faced

- SCP initially failed because the PEM file was not in my current directory.
- I mistakenly tried to create the web page in the wrong location.

### Solution

- Navigated to the Downloads folder where the PEM file was stored.
- Used the correct Nginx web root directory: `/var/www/html`.

---

## What I Learned

- How to connect to an EC2 instance using SSH.
- How to install and verify Nginx.
- How to check installed packages using `dpkg`.
- How to view service logs using `journalctl`.
- How to transfer files securely using SCP.
- Basic web server deployment and log management.
