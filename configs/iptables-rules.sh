#!/usr/bin/env bash
# Stateful Packet Inspection (SPI) Baseline Configuration
set -euo pipefail

# Flush existing rules
iptables -F
iptables -X

# Set default dropping policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow established and related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT

# Mitigate TCP SYN floods with rate-limiting bursts
iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT
iptables -A INPUT -p tcp --syn -j DROP