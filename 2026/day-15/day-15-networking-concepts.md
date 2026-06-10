# Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs

### 1. What happens when you type `google.com` in a browser?

**Answer**

1- First the browser checks its local cache for the corresponding IP address.
If not present, the browser sends a DNS request asking for the IP address.

2- DNS resolves the domain name and returns the IP address.

3- The browser establishes a connection using TCP/IP.

4- The web server processes the request and sends back the webpage.

### 2. What are these record types? Write one line each:

- **A** - Maps a domain name to an IPv4 address.
- **AAAA** - Maps a domain name to an IPv6 address.
- **CNAME** - Creates an alias from one domain to another.
- **MX** - Specifies mail servers responsible for handling email.
- **NS** - Defines the authoritative name servers for a domain.

### 3. Run: `dig google.com`

![dig output](01-dig.png)

- **A** record gives IPv4 address - `142.250.189.142`
- **TTL** - Time To Live - `268 seconds`

---

## Task 2: IP Addressing

### 1. What is an IPv4 address? How is it structured?

**Answer** - An IP Address is a unique numerical label assigned to each device connected to a computer network that uses the Internet Protocol for communication.

- IP address is divided into:
  - Network Portion : Identifies the network
  - Host Portion : Identifies the individual device

- Example : IP `172.31.41.95`
  - Network Portion : `172.31.32.0`
  - Host Portion : `41.95`

### 2. Difference between public and private IPs

| Public IP | Private IP |
|------------|------------|
| Assigned by ISP or Cloud Provider | Assigned within private networks |
| Reachable from the internet | Not directly reachable from the internet |
| Unique globally | Reusable in different networks |
| Example: `18.224.212.253` | Example: `172.31.41.95` |

### 3. What are the private IP ranges?

- `10.x.x.x` - Large enterprise networks
- `172.16.x.x - 172.31.x.x` - Medium-sized organizations
- `192.168.x.x` - Home & small office networks

### 4. Run: `ip addr show` — identify which of your IPs are private

![ip address output](02-id-address-show.png)

- `127.0.0.1/8` - Reserved for localhost communication
- `172.31.41.95/20` - This is a private IP address

---

## Task 3: CIDR & Subnetting

### 1. What does `/24` mean in `192.168.1.0/24`?

**Answer** - `/24` is CIDR notation. It tells us how many bits of the IP address are used for the network portion.

Here first **24 bits** (out of 32) are reserved for the network and the remaining **8 bits** are available for hosts.

IP Range:

`192.168.1.0 - 192.168.1.255`

Total:

`256 IPs`

### 2. How many usable hosts in:

- `/24` : 254
- `/16` : 65,534
- `/28` : 14

### 3. Why do we subnet?

**Answer** - Subnetting divides one large network into smaller, manageable and efficient sub-networks.

- Improves performance - Reduces broadcast traffic.
- Enhanced Security - Limits access between networks.
- Easier Troubleshooting - Smaller networks are easier to manage.

### 4. Quick exercise — fill in:

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|--------|--------|--------|--------|
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65,536 | 65,534 |
| /28 | 255.255.255.240 | 16 | 14 |

---

## Task 4: Ports – The Doors to Services

### 1. What is a port? Why do we need them?

**Answer**

- Port is a logical endpoint in networking.
- IP address identifies the device and port number identifies the service.
- Ports allow multiple services to run on the same machine.

### 2. Document these common ports:

| Port | Service |
|--------|--------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 53 | DNS |
| 3306 | MySQL |
| 6379 | Redis |
| 27017 | MongoDB |

### 3. Run `ss -tulpn` — match at least 2 listening ports to their services

- Port 22 : Service SSH

```bash
sudo ss -tulpn | grep 22
```

Output:

```text
tcp LISTEN 0 4096 0.0.0.0:22
tcp LISTEN 0 4096 [::]:22
```

```bash
nc -zv localhost 22
```

Output:

```text
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```

---

## Task 5: Putting It Together

### When you run `curl http://myapp.com:8080`

- DNS resolves the domain name into an IP address.
- The client connects to the server IP.
- Port 8080 identifies the service.
- TCP establishes the connection.
- HTTP request is sent and a response is received.

### Your app can't reach a database at `10.0.1.50:3306` — what would you check first?

- Check whether the database service is running.
- Verify port 3306 is listening.
- Verify Security Groups and firewall rules.
- Test connectivity using:

```bash
nc -zv 10.0.1.50 3306
```

- Check database logs.

---

## What I Learned

- DNS translates domain names into IP addresses.
- CIDR and subnetting help organize and manage networks efficiently.
- Ports allow different services to communicate over the network.
