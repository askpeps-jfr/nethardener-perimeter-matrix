
# NetHardener: Network Perimeter Security & Incident Mitigation

An enterprise-grade network security and perimeter defense suite modeling **OSI Layers 2–7**, firewall policy segmentation, Stateful Packet Inspection (SPI), and kernel-level **Denial of Service (DoS)** mitigation.

---

## 1. Architectural Scope & Threat Vectors

* **Focus Areas:** Perimeter Firewalls, Network Segmentation, Port Security, Transport-Layer Hardening, and DoS Mitigation.
* **Threat Scenarios Addressed:** SYN Flood attacks, ICMP Ping Floods, unauthorized lateral subnet movement, and cleartext payload inspection.
* **Target Environment:** Dual-homed perimeter gateway mediating untrusted public subnets (`WAN`) and isolated corporate enclaves (`LAN` / `DMZ`).

---

## 2. OSI Defensive Layer Mapping

| OSI Layer | Protocol / Surface | Vulnerability / Threat | Defense & Hardening Control |
| :--- | :--- | :--- | :--- |
| **Layer 7 (Application)** | HTTP / DNS / SSH | Unauthorized service queries, brute force | Application gateways, reverse proxies, and strict port binding. |
| **Layer 4 (Transport)** | TCP / UDP | TCP SYN flooding, port scanning | SYN Cookies (`tcp_syncookies`), TCP reset rate limiting, connection quotas. |
| **Layer 3 (Network)** | IPv4 / ICMP | ICMP Echo floods, IP spoofing, routing loops | Reverse Path Filtering (`rp_filter`), ingress packet filtering via `iptables`/`ufw`. |
| **Layer 2 (Data Link)** | Ethernet / ARP | ARP spoofing, MAC table poisoning | Dynamic ARP Inspection (DAI), Port Security (MAC limits per switchport). |

---

## 3. Perimeter Firewall & Kernel Hardening Configurations

### A. Kernel DoS Mitigation (`configs/sysctl-dos-mitigation.conf`)
```ini
# Enable SYN cookie protection against SYN floods
net.ipv4.tcp_syncookies = 1

# Disable ICMP broadcast echo requests (Smurf attack mitigation)
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Enable IP source routing verification (Anti-spoofing)
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore bogus ICMP error responses
net.ipv4.icmp_ignore_bogus_error_responses = 1

```

## 4. Interactive Defense Matrix

This repository includes **NetHardener**, a visual sandbox for modeling protocol interactions, subnet isolation, and real-time defensive rule triggers.

* **Live Interactive App:** [Launch NetHardener Sandbox](https://askpeps-jfr.github.io/nethardener-perimeter-matrix/app/)
* **Sandbox Source:** `app/index.html`