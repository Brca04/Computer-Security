#!/bin/sh
# ============================================================================
# FW tests that SHOULD SUCCEED  (traffic that must be ALLOWED)
#   [OK]   = reachable, as required
#   [FAIL] = blocked, but the spec requires it to be allowed (too strict)
#
# Prereqs: experiment running, `sudo ./prepare.sh` done, FW.sh loaded on node FW.
# Internet target is "server" (198.51.100.80): runs HTTP + DNS + SSH.
# ============================================================================
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
G="\033[32m"; R="\033[31m"; N="\033[0m"
PASS=0; FAILN=0
trap 'stty sane 2>/dev/null' EXIT
say() { printf "%b\r\n" "$1"; }

# probes: return 0 when the connection WORKS
http_works() { $SUDO himage "$1" curl -s -o /dev/null --max-time 6 "$2"; }
dns_works()  { $SUDO himage "$1" host -W 5 -R 1 "$2" "$3" >/dev/null 2>&1; }
tcp_open()   { $SUDO himage "$1" nmap -n -Pn -T4 --max-retries 1 --host-timeout 15s \
                 -p"$3" "$2" </dev/null 2>/dev/null | grep -qE "^$3/tcp[[:space:]]+open"; }

ok() { label=$1; shift
  if "$@"; then say "  [${G}OK${N}]   $label"; PASS=$((PASS+1))
  else        say "  [${R}FAIL${N}] $label"; FAILN=$((FAILN+1)); fi; }

say "=== Tests that SHOULD SUCCEED ==="

say "- DMZ web/DNS are public (reachable from ANY address):"
ok "client -> web-server  tcp/80"          tcp_open   client 203.0.113.20 80
ok "client -> web-server  tcp/443"         tcp_open   client 203.0.113.20 443
ok "client -> web-server  HTTP page"       http_works client http://203.0.113.20/index.html
ok "client -> dns-server  tcp/53"          tcp_open   client 203.0.113.10 53
ok "client -> dns-server  udp/53 (DNS)"    dns_works  client www.example.edu 203.0.113.10
ok "server -> web-server  tcp/80"          tcp_open   server 203.0.113.20 80
ok "server -> dns-server  udp/53 (DNS)"    dns_works  server www.example.edu 203.0.113.10

say "- admin: SSH to FW + DMZ servers, web, DNS, Internet HTTP:"
ok "admin -> FW          tcp/22"           tcp_open   admin 203.0.113.65 22
ok "admin -> web-server  tcp/22"           tcp_open   admin 203.0.113.20 22
ok "admin -> dns-server  tcp/22"           tcp_open   admin 203.0.113.10 22
ok "admin -> web-server  HTTP"             http_works admin http://203.0.113.20/index.html
ok "admin -> dns-server  udp/53 (DNS)"     dns_works  admin www.example.edu 203.0.113.10
ok "admin -> Internet    HTTP (server)"    http_works admin http://198.51.100.80/index.html

say "- pc (generic LAN host): DNS via dns-server, web, Internet HTTP:"
ok "pc -> dns-server  udp/53 (DNS)"        dns_works  pc www.example.edu 203.0.113.10
ok "pc -> web-server  HTTP"                http_works pc http://203.0.113.20/index.html
ok "pc -> Internet    HTTP (server)"       http_works pc http://198.51.100.80/index.html

say "- web-server -> db (the only DMZ->Private path):"
ok "web-server -> db  tcp/10000"           http_works web-server http://203.0.113.100:10000/index.html

say "- dns-server -> DNS out to the Internet (only 53 allowed out):"
ok "dns-server -> Internet  udp/53 (DNS)"  dns_works dns-server www.example.com 198.51.100.80
ok "dns-server -> Internet  tcp/53"        tcp_open  dns-server 198.51.100.80 53

say "============================================"
say "Result: ${G}${PASS} OK${N}, ${R}${FAILN} FAIL${N}"
say "(note: admin/pc -> db, admin -> pc etc. are intra-sw2 and not FW-controlled)"
[ "$FAILN" -eq 0 ]
