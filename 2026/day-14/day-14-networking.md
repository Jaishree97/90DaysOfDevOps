# Networking Fundamentals & Hands-on Checks

## OSI and TCP/IP Model

### OSI Model -

The OSI model is a 7-layer framework used to understand how network communication works.

- **L7 Application** – User-facing network services.
- **L6 Presentation** – Data format and encryption.
- **L5 Session** – Connection management.
- **L4 Transport** – TCP/UDP communication.
- **L3 Network** – IP addressing and routing.
- **L2 Data Link** – Device-to-device communication.
- **L1 Physical** – Cables, signals, and hardware.

### TCP/IP Model -

TCP/IP is a 4-layer networking model used for communication across the internet.

- **Application Layer** – User-facing network services.
- **Transport Layer** – TCP/UDP communication.
- **Internet Layer** – IP addressing and routing.
- **Network Access Layer** – Physical network connectivity.

### Protocol Placement -

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

- **Identity:** `hostname -I`

**Observation:** Successfully identified the EC2 instance's private IP address: **172.31.43.96**

![hostname](images/02-hostname.png)

---

- **Reachability:** `ping <target>`

**Observation:** Successfully verified connectivity to Google. All packets were received with **0% packet loss** and an average latency of **9.056 ms**.

![ping](images/03-ping.png)

---

- **Path:** `traceroute <target>`

**Observation:** Traffic reached Google successfully through multiple hops with low latency.

![traceroute](images/04-traceroute.png)

---

- **Ports:** `ss -tulnp`

**Observation:** Active listening ports and services were displayed. SSH is listening on **port 22**.

![ports](images/05-ss-tulnp.png)

---

- **Name resolution:** `dig <domain>` or `nslookup <domain>`

**Observation:** Domain resolved successfully to **142.251.210.110**.

![dig](images/06-dig.png)

---

- **HTTP check:** `curl -I <http/https-url>`

**Observation:** Received **HTTP/1.1 301 Moved Permanently**. The request was redirected to **www.google.com**.

![curl-i](images/07-curl-i.png)

---

- **Connections snapshot:** `ss -an | head`

**Observation:** Active socket and connection information displayed successfully.

![ss-an](images/08-ss-an.png)

---

# Mini Task: Port Probe & Interpret

- SSH service on port 22

### Observation:

SSH daemon (**sshd**) is listening on port **22**.

![ssh-port](images/09-ssh-tulnp.png)

---

- Connection succeeded

![nc](images/10-nc-zvlocalhost.png)

If not reachable:

- Check service status - `systemctl status ssh`
- Check logs - `journalctl -u ssh`
- Check firewall - `sudo ufw status`

---

# Reflection

- Ping command gives the fastest indication of network connectivity issues.
  -> `ping`

- DNS resolution confirms whether a domain name is correctly mapped to an IP address.
  -> `dig`, `nslookup`

- Traceroute helps identify the network path and potential delays between source and destination.
  -> `traceroute`

- HTTP checks verify web server availability and response status codes.
  -> `curl -I <url>`

- Port checks confirm whether a service is listening and reachable.
  -> `ss -tulnp`, `nc -zv`

- Follow up checks in real incident :

  ○ Check firewall (`sudo ufw status`)
  ○ Service health check (`systemctl status <service>`)
  ○ Review service logs (`journalctl -u <service>`)
  ○ Connectivity test (`ping`, `traceroute`, `nc`)
