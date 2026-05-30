#!/bin/sh
# ============================================================================
# FW tests that SHOULD BE BLOCKED  (traffic that must be DENIED)
#   [OK]   = correctly blocked
#   [FAIL] = REACHABLE but must be denied  ->  a hole in the rules
#
# Prereqs: experiment running, `sudo ./prepare.sh` done, FW.sh loaded on node FW.
# Intra-segment pairs (pc<->db, admin<->db/pc, dns<->web) are NOT tested:
# they share a switch, never traverse FW -> matrix "-" (cannot be influenced).
# ============================================================================
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
G="\033[32m"; R="\033[31m"; N="\033[0m"
PASS=0; FAILN=0
trap 'stty sane 2>/dev/null' EXIT
say() { printf "%b\r\n" "$1"; }

http_works() { $SUDO himage "$1" curl -s -o /dev/null --max-time 6 "$2"; }
dns_works()  { $SUDO himage "$1" host -W 5 -R 1 "$2" "$3" >/dev/null 2>&1; }
tcp_open()   { $SUDO himage "$1" nmap -n -Pn -T4 --max-retries 1 --host-timeout 15s \
                 -p"$3" "$2" </dev/null 2>/dev/null | grep -qE "^$3/tcp[[:space:]]+open"; }

blocked() { label=$1; shift
  if "$@"; then say "  [${R}FAIL${N}] $label  <-- REACHABLE, should be blocked"; FAILN=$((FAILN+1))
  else        say "  [${G}OK${N}]   $label"; PASS=$((PASS+1)); fi; }

say "=== Tests that SHOULD BE BLOCKED ==="

say "- SSH to DMZ servers from anyone except admin:"
blocked "client -> web-server  tcp/22"     tcp_open client 203.0.113.20 22
blocked "client -> dns-server  tcp/22"     tcp_open client 203.0.113.10 22
blocked "server -> web-server  tcp/22"     tcp_open server 203.0.113.20 22
blocked "pc     -> web-server  tcp/22"     tcp_open pc     203.0.113.20 22
blocked "pc     -> dns-server  tcp/22"     tcp_open pc     203.0.113.10 22

say "- FW accepts only admin SSH; everything else on FW is closed:"
blocked "client -> FW (10.0.0.2)    tcp/22"   tcp_open client     10.0.0.2     22
blocked "pc     -> FW (.65)         tcp/22"   tcp_open pc         203.0.113.65 22
blocked "dns-server -> FW (.1)      tcp/22"   tcp_open dns-server 203.0.113.1  22
blocked "web-server -> FW (.1)      tcp/22"   tcp_open web-server 203.0.113.1  22
blocked "admin  -> FW (.65)         tcp/80"   tcp_open admin      203.0.113.65 80

say "- Internet / DMZ -> Private (db reachable only as web-server:10000):"
blocked "client     -> db  tcp/10000"      tcp_open client     203.0.113.100 10000
blocked "client     -> db  tcp/22"         tcp_open client     203.0.113.100 22
blocked "dns-server -> db  tcp/10000"      tcp_open dns-server 203.0.113.100 10000
blocked "web-server -> db  tcp/22"         tcp_open web-server 203.0.113.100 22
# (pc -> db is intra-sw2, never reaches FW -> not testable here)

say "- db must INITIATE nothing through FW (Internet + DMZ):"
blocked "db -> web-server  HTTP"           http_works db http://203.0.113.20/index.html
blocked "db -> dns-server  DNS"            dns_works  db www.example.edu 203.0.113.10
blocked "db -> Internet    HTTP (server)"  http_works db http://198.51.100.80/index.html
blocked "db -> FW (.65)    tcp/22"         tcp_open   db 203.0.113.65 22

say "- DMZ servers are restricted outbound (web: nothing; dns: only 53):"
blocked "web-server -> Internet HTTP"      http_works web-server http://198.51.100.80/index.html
blocked "dns-server -> Internet HTTP"      http_works dns-server http://198.51.100.80/index.html

say "- Private hosts reach Internet only via HTTP/HTTPS (no direct DNS, no SSH):"
blocked "pc    -> Internet DNS (server)"   dns_works pc    www.example.com 198.51.100.80
blocked "pc    -> Internet tcp/22"         tcp_open  pc    198.51.100.80 22
blocked "admin -> Internet DNS (server)"   dns_works admin www.example.com 198.51.100.80
blocked "admin -> Internet tcp/22"         tcp_open  admin 198.51.100.80 22

say "- Internet -> Private hosts (admin, pc) is fully blocked:"
blocked "client -> admin  tcp/22"          tcp_open client 203.0.113.120 22
blocked "client -> pc     tcp/80"          tcp_open client 203.0.113.121 80

say "============================================"
say "Result: ${G}${PASS} OK${N}, ${R}${FAILN} FAIL${N}"
[ "$FAILN" -eq 0 ]
