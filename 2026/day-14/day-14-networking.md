# Networking Fundamentals & Hands-on Checks

## OSI and TCP/IP Model

### OSI Model

OSI is a conceptual model used to understand how network communication works. It consists of 7 layers.

- **Application (L7)** – User interaction (Browser, HTTP, DNS)
- **Presentation (L6)** – Encryption, compression, format conversion
- **Session (L5)** – Session establishment and management
- **Transport (L4)** – Reliable communication using TCP/UDP
- **Network (L3)** – IP addressing and routing
- **Data Link (L2)** – Frame delivery between devices
- **Physical (L1)** – Cables, signals, hardware

### TCP/IP Model

TCP/IP is the practical networking model used on the internet.

- **Application Layer** – HTTP, HTTPS, DNS, SSH
- **Transport Layer** – TCP, UDP
- **Internet Layer** – IP, ICMP
- **Network Access Layer** – Ethernet, Wi-Fi

## Protocol Placement

- HTTP, HTTPS, DNS, SSH → Application Layer
- TCP, UDP → Transport Layer
- IP, ICMP → Internet Layer
- Ethernet, Wi-Fi → Network Access Layer

## Real Example

```bash
curl -L google.com
```

This fetches a web page using:

**HTTP (Application) → TCP (Transport) → IP (Internet)**

![curl output](images/01-curl-l.png)

---

# Hands-on Checklist

## Identity: `hostname -I`

### Observation

The EC2 instance private IP address is:

```text
172.31.43.96
```

![hostname](images/02-hostname.png)

---

## Reachability: `ping google.com`

### Observation

- Google was reachable successfully.
- 4 packets transmitted and 4 received.
- 0% packet loss.
- Average latency ≈ 9.056 ms.

```bash
ping -c 4 google.com
```

![ping](images/03-ping.png)

---

## Path: `traceroute google.com`

### Observation

- Traffic passed through multiple routers before reaching Google.
- Destination reached successfully in 6 hops.
- Average latency remained under 12 ms.

```bash
traceroute google.com
```

![traceroute](images/04-traceroute.png)

---

## Ports: `ss -tulnp`

### Observation

Listening services discovered:

- SSH → Port 22
- DNS Resolver → Port 53
- DHCP Client → Port 68

```bash
ss -tulnp
```

![ports](images/05-ss-tulnp.png)

---

## Name Resolution: `dig google.com`

### Observation

DNS successfully resolved:

```text
google.com → 142.251.210.110
```

Query completed in:

```text
4 ms
```

```bash
dig google.com
```

![dig](images/06-dig.png)

---

## HTTP Check: `curl -I google.com`

### Observation

Received:

```text
HTTP/1.1 301 Moved Permanently
```

This means Google redirected the request to:

```text
http://www.google.com/
```

The web server responded successfully.

```bash
curl -I google.com
```

![curl -I](images/07-curl-i.png)

---

## Connection Snapshot: `ss -an | head`

### Observation

Active network socket information was displayed successfully.

The command showed local and peer addresses currently maintained by the system.

```bash
ss -an | head
```

![ss-an](images/08-ss-an.png)

---

# Mini Task: Port Probe & Interpret

## SSH Service on Port 22

```bash
sudo ss -tulnp | grep :22
```

### Observation

SSH daemon (`sshd`) is listening on:

```text
0.0.0.0:22
[::]:22
```

![ssh-port](images/09-ssh-tulnp.png)

---

## Port Reachability Test

```bash
nc -zv localhost 22
```

### Output

```text
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

### Interpretation

Port 22 is reachable and the SSH service is functioning correctly.

![nc-test](images/10-nc-zvlocalhost.png)

---

# Reflection

## Which command gives the fastest signal when something is broken?

`ping`

It quickly verifies whether a target host is reachable over the network.

---

## What layer would you inspect next if DNS fails?

**Application Layer**

Because DNS operates at the Application Layer.

Useful commands:

```bash
dig google.com
nslookup google.com
```

---

## What layer would you inspect if HTTP 500 shows up?

**Application Layer**

HTTP 500 indicates a server-side application issue.

Useful checks:

```bash
systemctl status <service>
journalctl -u <service>
```

---

## Two follow-up checks in a real incident

### Check service health

```bash
systemctl status ssh
```

### Check connectivity

```bash
curl -I google.com
nc -zv localhost 22
```

### Check firewall

```bash
sudo ufw status
```
