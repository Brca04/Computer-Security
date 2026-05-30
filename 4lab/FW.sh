# Bruno Cavor, 4. laboratorijska vjezba
# FW.sh

# Postavljanje aliasa
LOCAL="203.0.113.0/24"
DMZ_NET="203.0.113.0/26"
PRIV_NET="203.0.113.64/26"
WEB="203.0.113.20"
DNS="203.0.113.10"
DB="203.0.113.100"
ADMIN="203.0.113.120"
PC="203.0.113.121"

IPT="iptables"

# Resetiranje i postavljanje pocetnog okruzenja
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t mangle -F
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT DROP

# Ukljucivanje prosljedjivanja paketa
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1

# INPUT pravila
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -m conntrack --ctstate INVALID -j DROP
$IPT -A INPUT -s "$ADMIN" -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

# OUTPUT pravila
$IPT -A OUTPUT -o lo -j ACCEPT
$IPT -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# FORWARD pravila
$IPT -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m conntrack --ctstate INVALID -j DROP

# db ne smije nista inicirati (mora biti PRIJE javnih DMZ pravila!)
# Odgovori na vezu web-server->db:10000 prolaze gore kroz ESTABLISHED.
$IPT -A FORWARD -s "$DB" -j DROP

# DMZ javne usluge (s bilo koje adrese)
$IPT -A FORWARD -d "$WEB" -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -d "$DNS" -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -d "$DNS" -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT

# SSH usluge (samo admin -> dns-server, web-server)
$IPT -A FORWARD -s "$ADMIN" -d "$DNS" -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -s "$ADMIN" -d "$WEB" -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

# Pristup db (samo web-server na tcp/10000; SSH na db samo iz Private)
$IPT -A FORWARD -s "$WEB" -d "$DB" -p tcp --dport 10000 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -s "$PRIV_NET" -d "$DB" -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

# dns-server -> DNS bilo gdje na Internetu
$IPT -A FORWARD -s "$DNS" ! -d "$LOCAL" -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
$IPT -A FORWARD -s "$DNS" ! -d "$LOCAL" -p tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT

# Privatna mreza -> Internet HTTP/HTTPS (db je vec odbijen gore)
$IPT -A FORWARD -s "$PRIV_NET" ! -d "$LOCAL" -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW -j ACCEPT

echo "FW pokrenut"
