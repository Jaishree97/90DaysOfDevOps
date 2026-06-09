# Networking Fundamentals & Hands-on Checks

## OSI and TCP/IP Model

### OSI Model

The OSI model is a 7-layer framework used to understand how network communication works.

- **L7 Application** – User-facing network services.
- **L6 Presentation** – Data format and encryption.
- **L5 Session** – Connection management.
- **L4 Transport** – TCP/UDP communication.
- **L3 Network** – IP addressing and routing.
- **L2 Data Link** – Device-to-device communication.
- **L1 Physical** – Cables, signals, and hardware.

### TCP/IP Model

TCP/IP is a 4-layer networking model used for communication across the internet.

- **Application Layer** – User-facing network services.
- **Transport Layer** – TCP/UDP communication.
- **Internet Layer** – IP addressing and routing.
- **Network Access Layer** – Physical network connectivity.

### Protocol Placement

- **Application Layer** – HTTP, HTTPS, DNS, DHCP, SSH
- **Transport Layer** – TCP, UDP
- **Internet Layer** – IP, ICMP, ARP
- **Network Access Layer** – Ethernet, Wi-Fi

## Real Example

```bash
curl -L google.com
```

This command fetches the webpage content.

→ HTTP (Application) over TCP (Transport) over IP (Internet)

![curl](images/01-curl-l.png)

---

# Hands-on Checklist

- ## Identity: `hostname -I`

### Observation:

Local private IP address is **172.31.43.96**

![hostname](images/02-hostname.png)

---

- ## Reachability: `ping <target>`

### Observation:

0% packet loss with average latency of **9.056 ms** confirms good network connectivity.

```bash
ping -c 4 google.com
```

![ping](images/03-ping.png)

---

- ## Path: `traceroute <target>`

### Observation:

Traffic reached Google successfully through multiple hops. Average latency remained below 12 ms.

```bash
traceroute google.com
```

![traceroute](images/04-traceroute.png)

---

- ## Ports: `ss -tulnp`

### Observation:

SSH service is listening on port 22.

```bash
ss -tulnp
```

![ports](images/05-ss-tulnp.png)

---

- ## Name resolution: `dig <domain>` or `nslookup <domain>`

### Observation:

Domain resolves to **142.251.210.110**

```bash
dig google.com
```

![dig](images/06-dig.png)

---

- ## HTTP check: `curl -I <http/https-url>`

### Observation:

Received response **HTTP/1.1 301 Moved Permanently**.

Server successfully responded and redirected the request to www.google.com.

```bash
curl -I google.com
```

![curl-i](images/07-curl-i.png)

---

- ## Connections snapshot: `ss -an | head`

### Observation:

Active socket information displayed successfully.

```bash
ss -an | head
```

![ss-an](images/08-ss-an.png)

---

# Mini Task: Port Probe & Interpret

- SSH service on port 22

```bash
sudo ss -tulnp | grep :22
```

### Observation:

SSH daemon (sshd) is listening on port 22.

![ssh-port](images/09-ssh-tulnp.png)

---

- Connection succeeded

```bash
nc -zv localhost 22
```

Output:

```text
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

![nc](images/10-nc-zvlocalhost.png)

### Interpretation

Port 22 is reachable and SSH service is functioning properly.

---

## If not reachable :

- Check service status

```bash
systemctl status ssh
```

- Check logs

```bash
journalctl -u ssh
```

- Check firewall

```bash
sudo ufw status
```

---

# Reflection

- Ping command gives fastest signal if something is broken.

- DNS fails :
It runs on Application Layer. If DNS queries don't resolve, the next logical layer to inspect is the Transport Layer (L4) and Internet Layer (L3).

-> dig, nslookup, ping, ss -tulnp

- HTTP 500 :
It is an Application Layer issue. Since you receive HTTP response codes, Internet and Transport layers are working.

-> systemctl status service

-> journalctl -u service

-> tail -f /var/log/service/error.log

- Follow up checks in real incident :

  - Check firewall

  ```bash
  sudo ufw status
  ```

  - Service health check

  ```bash
  systemctl status <service>
  ```

  - Connectivity test

  ```bash
  curl -I google.com
  nc -zv localhost 22
  ```
