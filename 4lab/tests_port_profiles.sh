#!/bin/sh
# ============================================================================
# Port-profile tests: scan a host the way the README does (nmap sweeps) and
# assert the EXACT set of open TCP ports. Catches both missing-allow and
# accidental-allow in one shot.
#   [OK]   = open set matches expected
#   [FAIL] = open set differs (printed got vs expected)
#
# Prereqs: experiment running, `sudo ./prepare.sh` done, FW.sh loaded on FW.
# Slower than the other scripts: filtered ports make nmap wait for a timeout.
# ============================================================================
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
G="\033[32m"; R="\033[31m"; N="\033[0m"
PASS=0; FAILN=0
trap 'stty sane 2>/dev/null' EXIT
say() { printf "%b\r\n" "$1"; }

# print sorted, comma-joined list of OPEN tcp ports (empty if none)
open_set() { # node host portspec
  $SUDO himage "$1" nmap -n -Pn -T4 --max-retries 1 --host-timeout 25s \
        -p"$3" "$2" </dev/null 2>/dev/null \
    | awk '$2=="open" && $1 ~ /\/tcp$/ {split($1,a,"/"); print a[1]}' \
    | sort -n | paste -sd, -
}

profile() { # label node host portspec expected
  got=$(open_set "$2" "$3" "$4")
  if [ "$got" = "$5" ]; then
    say "  [${G}OK${N}]   $1   open={${got:-none}}"; PASS=$((PASS+1))
  else
    say "  [${R}FAIL${N}] $1   open={${got:-none}} expected={${5:-none}}"; FAILN=$((FAILN+1))
  fi; }

SWEEP="20-25,53,80,443"
say "=== Port profiles (scan ${SWEEP} unless noted) ==="

say "- DMZ servers as seen from the Internet (client):"
profile "client -> web-server" client 203.0.113.20 "$SWEEP" "80,443"
profile "client -> dns-server" client 203.0.113.10 "$SWEEP" "53"

say "- DMZ servers as seen from a Private host (pc):"
profile "pc -> web-server"     pc 203.0.113.20 "$SWEEP" "80,443"
profile "pc -> dns-server"     pc 203.0.113.10 "$SWEEP" "53"

say "- DMZ servers as seen from admin (adds SSH):"
profile "admin -> web-server"  admin 203.0.113.20 "$SWEEP" "22,80,443"
profile "admin -> dns-server"  admin 203.0.113.10 "$SWEEP" "22,53"

say "- FW itself (scan 22,23,80,443): only admin sees tcp/22:"
profile "admin  -> FW (.65)"   admin  203.0.113.65 "22,23,80,443" "22"
profile "pc     -> FW (.65)"   pc     203.0.113.65 "22,23,80,443" ""
profile "client -> FW (10.0.0.2)" client 10.0.0.2  "22,23,80,443" ""

say "- db (scan 22,10000): only web-server sees tcp/10000, no SSH from outside:"
profile "web-server -> db"     web-server 203.0.113.100 "22,10000" "10000"
profile "client     -> db"     client     203.0.113.100 "22,10000" ""
profile "dns-server -> db"     dns-server 203.0.113.100 "22,10000" ""

say "============================================"
say "Result: ${G}${PASS} OK${N}, ${R}${FAILN} FAIL${N}"
[ "$FAILN" -eq 0 ]
