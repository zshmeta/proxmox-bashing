###############################################################################################

adguard() {
banlet adguard 

msg_info "Installing Dependencies"
 apt-get install -y curl
 apt-get install -y sudo
 apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing AdGuard Home"
 tar zxvf <(curl -fsSL https://static.adtidy.org/adguardhome/release/AdGuardHome_linux_amd64.tar.gz) -C /opt
msg_ok "Installed AdGuard Home"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/AdGuardHome.service
[Unit]
Description=AdGuard Home: Network-level blocker
ConditionFileIsExecutable=/opt/AdGuardHome/AdGuardHome
After=syslog.target network-online.target

[Service]
StartLimitInterval=5
StartLimitBurst=10
ExecStart=/opt/AdGuardHome/AdGuardHome "-s" "run"
WorkingDirectory=/opt/AdGuardHome
StandardOutput=file:/var/log/AdGuardHome.out
StandardError=file:/var/log/AdGuardHome.err
Restart=always
RestartSec=10
EnvironmentFile=-/etc/sysconfig/AdGuardHome

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now AdGuardHome.service
msg_ok "Created Service"


msg_info "Cleaning up"
 apt-get autoremove
 apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

alpine() {
banlet alpine 

msg_info "Installing Dependencies"
apk add newt
apk add curl
apk add openssh
apk add nano
apk add mc
msg_ok "Installed Dependencies"

}

############################################################################################


###############################################################################################

alpine-docker() {
banlet alpine-docker 

msg_info "Installing Dependencies"
apk add newt
apk add curl
apk add openssh
apk add nano
apk add mc
msg_ok "Installed Dependencies"

msg_info "Installing Docker"
apk add docker
rc-service docker start
rc-update add docker default
msg_ok "Installed Docker"

get_latest_release() {
  curl -sL https://api.github.com/repos/$1/releases/latest | grep '"tag_name":' | cut -d'"' -f4
}
PORTAINER_LATEST_VERSION=$(get_latest_release "portainer/portainer")
DOCKER_COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")

read -r -p "Would you like to add Portainer? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
  msg_info "Installing Portainer $PORTAINER_LATEST_VERSION"
  docker volume create portainer_data >/dev/null
 docker run -d \
    -p 8000:8000 \
    -p 9000:9000 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
  msg_ok "Installed Portainer $PORTAINER_LATEST_VERSION"
fi

read -r -p "Would you like to add Docker Compose? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
  msg_info "Installing Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p $DOCKER_CONFIG/cli-plugins
  curl -sSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_LATEST_VERSION/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
  msg_ok "Installed Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
fi

}

############################################################################################


###############################################################################################

alpine-grafana() {
banlet alpine-grafana 

msg_info "Installing Dependencies"
apk add newt
apk add curl
apk add openssh
apk add nano
apk add mc
msg_ok "Installed Dependencies"

msg_info "Installing Grafana"
apk add grafana
sed -i '/http_addr/s/127.0.0.1/0.0.0.0/g' /etc/conf.d/grafana
rc-service grafana start
rc-update add grafana default
msg_ok "Installed Grafana"

}

############################################################################################


###############################################################################################

alpine-vaultwarden() {
banlet alpine-vaultwarden 

msg_info "Installing Dependencies"
apk add newt
apk add curl
apk add openssl
apk add openssh
apk add nano
apk add mc
apk add argon2
msg_ok "Installed Dependencies"

msg_info "Installing Alpine-Vaultwarden"
apk add vaultwarden
sed -i -e 's/# export ADMIN_TOKEN=.*/export ADMIN_TOKEN='\'''\''/' -e '/^# export ROCKET_ADDRESS=0\.0\.0\.0/s/^# //' -e 's|export WEB_VAULT_ENABLED=.*|export WEB_VAULT_ENABLED=true|' /etc/conf.d/vaultwarden
msg_ok "Installed Alpine-Vaultwarden"

msg_info "Installing Web-Vault"
apk add vaultwarden-web-vault
msg_ok "Installed Web-Vault" 

msg_info "Starting Alpine-Vaultwarden"
rc-service vaultwarden start
rc-update add vaultwarden default
msg_ok "Started Alpine-Vaultwarden"

}

############################################################################################


###############################################################################################

alpine-zigbee2mqtt() {
banlet alpine-zigbee2mqtt 

msg_info "Installing Dependencies"
apk add newt
apk add curl
apk add openssh
apk add nano
apk add mc
msg_ok "Installed Dependencies"

msg_info "Installing Alpine-Zigbee2MQTT"
apk add zigbee2mqtt
msg_ok "Installed Alpine-Zigbee2MQTT"

}

############################################################################################


###############################################################################################

audiobookshelf() {
banlet audiobookshelf 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y gnupg
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing audiobookshelf"
curl -fsSL https://advplyr.github.io/audiobookshelf-ppa/KEY.gpg >/etc/apt/trusted.gpg.d/audiobookshelf-ppa.asc
echo "deb [signed-by=/etc/apt/trusted.gpg.d/audiobookshelf-ppa.asc] https://advplyr.github.io/audiobookshelf-ppa ./" >/etc/apt/sources.list.d/audiobookshelf.list
apt-get update
apt install audiobookshelf
msg_ok "Installed audiobookshelf"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

autobrr() {
banlet autobrr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Autobrr"
wget -q $(curl -s https://api.github.com/repos/autobrr/autobrr/releases/latest | grep download | grep linux_x86_64 | cut -d\" -f4)
tar -C /usr/local/bin -xzf autobrr*.tar.gz
rm -rf autobrr*.tar.gz
mkdir -p /root/.config/autobrr
cat <<EOF >>/root/.config/autobrr/config.toml
# https://autobrr.com/configuration/autobrr

host = "0.0.0.0"
port = 7474
logLevel = "DEBUG"
sessionSecret = "$(openssl rand -base64 24)"
EOF
msg_ok "Installed Autobrr"

msg_info "Creating Service"
service_path="/etc/systemd/system/autobrr.service"
echo "[Unit]
Description=autobrr service
After=syslog.target network-online.target
[Service]
Type=simple
User=root
Group=root
ExecStart=/usr/local/bin/autobrr --config=/root/.config/autobrr/
[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now -q autobrr.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

bazarr() {
banlet bazarr 

msg_info "Installing Dependencies"
  apt-get install -y curl
  apt-get install -y sudo
  apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
  apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Bazarr"
mkdir -p /var/lib/bazarr/
wget -q https://github.com/morpheus65535/bazarr/releases/latest/download/bazarr.zip
unzip -qq bazarr -d /opt/bazarr
chmod 775 /opt/bazarr /var/lib/bazarr/
python3 -m pip install -q -r /opt/bazarr/requirements.txt
msg_ok "Installed Bazarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/bazarr.service
[Unit]
Description=Bazarr Daemon
After=syslog.target network.target

[Service]
WorkingDirectory=/opt/bazarr/
UMask=0002
Restart=on-failure
RestartSec=5
Type=simple
ExecStart=/usr/bin/python3 /opt/bazarr/bazarr.py
KillSignal=SIGINT
TimeoutStopSec=20
SyslogIdentifier=bazarr

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now bazarr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf bazarr.zip
  apt-get autoremove
  apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

blocky() {
banlet blocky 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Blocky"
systemctl stop systemd-resolved
systemctl disable systemd-resolved.service
RELEASE=0.20 #$(curl -s https://api.github.com/repos/0xERR0R/blocky/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
wget -q https://github.com/0xERR0R/blocky/releases/download/v$RELEASE/blocky_${RELEASE}_Linux_x86_64.tar.gz
mkdir -p /opt/blocky
tar -xf blocky_${RELEASE}_Linux_x86_64.tar.gz -C /opt/blocky
rm -rf blocky_${RELEASE}_Linux_x86_64.tar.gz
cat <<EOF >/opt/blocky/config.yml
upstream:
  # these external DNS resolvers will be used. Blocky picks 2 random resolvers from the list for each query
  # format for resolver: [net:]host:[port][/path]. net could be empty (default, shortcut for tcp+udp), tcp+udp, tcp, udp, tcp-tls or https (DoH). If port is empty, default port will be used (53 for udp and tcp, 853 for tcp-tls, 443 for https (Doh))
  # this configuration is mandatory, please define at least one external DNS resolver
  default:
    # example for tcp+udp IPv4 server (https://digitalcourage.de/)
    #- 5.9.164.112
    # Cloudflare
    - 1.1.1.1
    # example for DNS-over-TLS server (DoT)
    #- tcp-tls:fdns1.dismail.de:853
    # example for DNS-over-HTTPS (DoH)
    #- https://dns.digitale-gesellschaft.ch/dns-query
  # optional: use client name (with wildcard support: * - sequence of any characters, [0-9] - range)
  # or single ip address / client subnet as CIDR notation
  #laptop*:
    #- 123.123.123.123

# optional: timeout to query the upstream resolver. Default: 2s

#upstreamTimeout: 2s


# optional: If true, blocky will fail to start unless at least one upstream server per group is reachable. Default: false

#startVerifyUpstream: true


# optional: Determines how blocky will create outgoing connections. This impacts both upstreams, and lists.

# accepted: dual, v4, v6

# default: dual

#connectIPVersion: dual


# optional: custom IP address(es) for domain name (with all sub-domains). Multiple addresses must be separated by a comma

# example: query "printer.lan" or "my.printer.lan" will return 192.168.178.3

#customDNS:

  #customTTL: 1h
  # optional: if true (default), return empty result for unmapped query types (for example TXT, MX or AAAA if only IPv4 address is defined).
  # if false, queries with unmapped types will be forwarded to the upstream resolver
  #filterUnmappedTypes: true
  # optional: replace domain in the query with other domain before resolver lookup in the mapping
  #rewrite:
    #example.com: printer.lan
  #mapping:
    #printer.lan: 192.168.178.3,2001:0db8:85a3:08d3:1319:8a2e:0370:7344

# optional: definition, which DNS resolver(s) should be used for queries to the domain (with all sub-domains). Multiple resolvers must be separated by a comma

# Example: Query client.fritz.box will ask DNS server 192.168.178.1. This is necessary for local network, to resolve clients by host name

#conditional:

  # optional: if false (default), return empty result if after rewrite, the mapped resolver returned an empty answer. If true, the original query will be sent to the upstream resolver
  # Example: The query "blog.example.com" will be rewritten to "blog.fritz.box" and also redirected to the resolver at 192.168.178.1. If not found and if  was set to , the original query "blog.example.com" will be sent upstream.
  # Usage: One usecase when having split DNS for internal and external (internet facing) users, but not all subdomains are listed in the internal domain.
  #fallbackUpstream: false
  # optional: replace domain in the query with other domain before resolver lookup in the mapping
  #rewrite:
    #example.com: fritz.box
  #mapping:
    #fritz.box: 192.168.178.1
    #lan.net: 192.168.178.1,192.168.178.2

# optional: use black and white lists to block queries (for example ads, trackers, adult pages etc.)

blocking:
  # definition of blacklist groups. Can be external link (http/https) or local file
  blackLists:
    ads:
      - https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
      - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
      - http://sysctl.org/cameleon/hosts
      - https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
      - |
        # inline definition with YAML literal block scalar style
        # hosts format
        someadsdomain.com
    special:
      - https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts
  # definition of whitelist groups. Attention: if the same group has black and whitelists, whitelists will be used to disable particular blacklist entries. If a group has only whitelist entries -> this means only domains from this list are allowed, all other domains will be blocked
  whiteLists:
    ads:
      - whitelist.txt
      - |
        # inline definition with YAML literal block scalar style
        # hosts format
        whitelistdomain.com
        # this is a regex
        /^banners?[_.-]/
  # definition: which groups should be applied for which client
  clientGroupsBlock:
    # default will be used, if no special definition for a client name exists
    default:
      - ads
      - special
    # use client name (with wildcard support: * - sequence of any characters, [0-9] - range)
    # or single ip address / client subnet as CIDR notation
    #laptop*:
      #- ads
    #192.168.178.1/24:
      #- special
  # which response will be sent, if query is blocked:
  # zeroIp: 0.0.0.0 will be returned (default)
  # nxDomain: return NXDOMAIN as return code
  # comma separated list of destination IP addresses (for example: 192.100.100.15, 2001:0db8:85a3:08d3:1319:8a2e:0370:7344). Should contain ipv4 and ipv6 to cover all query types. Useful with running web server on this address to display the "blocked" page.
  blockType: zeroIp
  # optional: TTL for answers to blocked domains
  # default: 6h
  blockTTL: 1m
  # optional: automatically list refresh period (in duration format). Default: 4h.
  # Negative value -> deactivate automatically refresh.
  # 0 value -> use default
  refreshPeriod: 4h
  # optional: timeout for list download (each url). Default: 60s. Use large values for big lists or slow internet connections
  downloadTimeout: 4m
  # optional: Download attempt timeout. Default: 60s
  downloadAttempts: 5
  # optional: Time between the download attempts. Default: 1s
  downloadCooldown: 10s
  # optional: if failOnError, application startup will fail if at least one list can't be downloaded / opened. Default: blocking
  #startStrategy: failOnError

# optional: configuration for caching of DNS responses

caching:
  # duration how long a response must be cached (min value).
  # If <=0, use response's TTL, if >0 use this value, if TTL is smaller
  # Default: 0
  minTime: 5m
  # duration how long a response must be cached (max value).
  # If <0, do not cache responses
  # If 0, use TTL
  # If > 0, use this value, if TTL is greater
  # Default: 0
  maxTime: 30m
  # Max number of cache entries (responses) to be kept in cache (soft limit). Useful on systems with limited amount of RAM.
  # Default (0): unlimited
  maxItemsCount: 0
  # if true, will preload DNS results for often used queries (default: names queried more than 5 times in a 2-hour time window)
  # this improves the response time for often used queries, but significantly increases external traffic
  # default: false
  prefetching: true
  # prefetch track time window (in duration format)
  # default: 120
  prefetchExpires: 2h
  # name queries threshold for prefetch
  # default: 5
  prefetchThreshold: 5
  # Max number of domains to be kept in cache for prefetching (soft limit). Useful on systems with limited amount of RAM.
  # Default (0): unlimited
  #prefetchMaxItemsCount: 0

# optional: configuration of client name resolution

clientLookup:
  # optional: this DNS resolver will be used to perform reverse DNS lookup (typically local router)
  #upstream: 192.168.178.1
  # optional: some routers return multiple names for client (host name and user defined name). Define which single name should be used.
  # Example: take second name if present, if not take first name
  #singleNameOrder:
    #- 2
    #- 1
  # optional: custom mapping of client name to IP addresses. Useful if reverse DNS does not work properly or just to have custom client names.
  #clients:
    #laptop:
      #- 192.168.178.29
# optional: configuration for prometheus metrics endpoint

prometheus:
  # enabled if true
  #enable: true
  # url path, optional (default '/metrics')
  #path: /metrics

# optional: write query information (question, answer, client, duration etc.) to daily csv file

queryLog:
  # optional one of: mysql, postgresql, csv, csv-client. If empty, log to console
  #type: mysql
  # directory (should be mounted as volume in docker) for csv, db connection string for mysql/postgresql
  #target: db_user:db_password@tcp(db_host_or_ip:3306)/db_name?charset=utf8mb4&parseTime=True&loc=Local
  #postgresql target: postgres://user:password@db_host_or_ip:5432/db_name
  # if > 0, deletes log files which are older than ... days
  #logRetentionDays: 7
  # optional: Max attempts to create specific query log writer, default: 3
  #creationAttempts: 1
  # optional: Time between the creation attempts, default: 2s
  #creationCooldown: 2s

# optional: Blocky can synchronize its cache and blocking state between multiple instances through redis.

redis:
  # Server address and port
  #address: redis:6379
  # Password if necessary
  #password: passwd
  # Database, default: 0
  #database: 2
  # Connection is required for blocky to start. Default: false
  #required: true
  # Max connection attempts, default: 3
  #connectionAttempts: 10
  # Time between the connection attempts, default: 1s
  #connectionCooldown: 3s

# optional: DNS listener port(s) and bind ip address(es), default 53 (UDP and TCP). Example: 53, :53, "127.0.0.1:5353,[::1]:5353"

port: 553
# optional: Port(s) and bind ip address(es) for DoT (DNS-over-TLS) listener. Example: 853, 127.0.0.1:853

#tlsPort: 853

# optional: HTTPS listener port(s) and bind ip address(es), default empty = no http listener. If > 0, will be used for prometheus metrics, pprof, REST API, DoH... Example: 443, :443, 127.0.0.1:443

#httpPort: 4000

#httpsPort: 443

# optional: Mininal TLS version that the DoH and DoT server will use

#minTlsServeVersion: 1.3

# if https port > 0: path to cert and key file for SSL encryption. if not set, self-signed certificate will be generated

#certFile: server.crt

#keyFile: server.key

# optional: use this DNS server to resolve blacklist urls and upstream DNS servers. Useful if no DNS resolver is configured and blocky needs to resolve a host name. Format net:IP:port, net must be udp or tcp

#bootstrapDns: tcp+udp:1.1.1.1


filtering:
# optional: drop all queries with following query types. Default: empty

  #queryTypes:
    #- AAAA

# optional: if path defined, use this file for query resolution (A, AAAA and rDNS). Default: empty

hostsFile:
  # optional: Path to hosts file (e.g. /etc/hosts on Linux)
  #filePath: /etc/hosts
  # optional: TTL, default: 1h
  #hostsTTL: 60m
  # optional: Time between hosts file refresh, default: 1h
  #refreshPeriod: 30m
  # optional: Whether loopback hosts addresses (127.0.0.0/8 and ::1) should be filtered or not, default: false
  #filterLoopback: true
# optional: Log level (one from debug, info, warn, error). Default: info

#logLevel: info

# optional: Log format (text or json). Default: text

#logFormat: text

# optional: log timestamps. Default: true

#logTimestamp: true

# optional: obfuscate log output (replace all alphanumeric characters with *) for user sensitive data like request domains or responses to increase privacy. Default: false

#logPrivacy: false


# optional: add EDE error codes to dns response

#ede: 

  # enabled if true, Default: false
  #enable: true
EOF
msg_ok "Installed Blocky"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/blocky.service
[Unit]
Description=Blocky
After=network.target
[Service]
User=root
WorkingDirectory=/opt/blocky
ExecStart=/opt/blocky/./blocky --config config.yml
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now blocky
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

casaos() {
banlet casaos 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing CasaOS (Patience)"
DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
mkdir -p $(dirname $DOCKER_CONFIG_PATH)
if [ "$ST" == "yes" ]; then
VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
cd /usr/local/bin
curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/$VER/fuse-overlayfs-x86_64
chmod 755 /usr/local/bin/fuse-overlayfs
cd ~
echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
else
echo -e '{\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
fi
bash <(curl -fsSL https://get.casaos.io)
msg_ok "Installed CasaOS"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

changedetection() {
banlet changedetection 

msg_info "Installing Dependencies (Patience)"
apt-get install -y \
  curl \
  sudo \
  mc \
  git \
  build-essential \
  dumb-init \
  gconf-service \
  libatk-bridge2.0-0 \
  libasound2 \
  libatk1.0-0 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libgbm-dev \
  libgbm1 \
  libgconf-2-4 \
  libgdk-pixbuf2.0-0 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  qpdf \
  xdg-utils \
  xvfb
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Change Detection"
mkdir /opt/changedetection
pip3 install changedetection.io
python3 -m pip install dnspython==2.2.1
msg_ok "Installed Change Detection"

msg_info "Installing Browserless & Playwright"
mkdir /opt/browserless
python3 -m pip install playwright
git clone https://github.com/browserless/chrome /opt/browserless
npm install --prefix /opt/browserless
npm run build --prefix /opt/browserless
npm prune production --prefix /opt/browserless
msg_ok "Installed Browserless & Playwright"

msg_info "Installing Font Packages"
apt-get install -y \
  fontconfig \
  libfontconfig1 \
  fonts-freefont-ttf \
  fonts-gfs-neohellenic \
  fonts-indic fonts-ipafont-gothic \
  fonts-kacst fonts-liberation \
  fonts-noto-cjk \
  fonts-noto-color-emoji \
  msttcorefonts \
  fonts-roboto \
  fonts-thai-tlwg \
  fonts-wqy-zenhei
msg_ok "Installed Font Packages"

msg_info "Installing X11 Packages"
apt-get install -y \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6
msg_ok "Installed X11 Packages"

msg_info "Creating Services"
cat <<EOF >/etc/systemd/system/changedetection.service
[Unit]
Description=Change Detection
After=network-online.target
After=network.target browserless.service
Wants=browserless.service
[Service]
Type=simple
WorkingDirectory=/opt/changedetection
Environment="WEBDRIVER_URL=http://127.0.0.1:4444/wd/hub"
Environment="PLAYWRIGHT_DRIVER_URL=ws://127.0.0.1:3000/?stealth=1&--disable-web-security=true"
ExecStart=changedetection.io -d /opt/changedetection -p 5000
[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/systemd/system/browserless.service
[Unit]
Description=browserless service
After=network.target
[Service]
Environment=APP_DIR=/opt/browserless
Environment=PLAYWRIGHT_BROWSERS_PATH=/opt/browserless
Environment=CONNECTION_TIMEOUT=60000
Environment=HOST=127.0.0.1
Environment=LANG="C.UTF-8"
Environment=NODE_ENV=production
Environment=PORT=3000
Environment=WORKSPACE_DIR=/opt/browserless/workspace
WorkingDirectory=/opt/browserless
ExecStart=/opt/browserless/start.sh
SyslogIdentifier=browserless
[Install]
WantedBy=default.target
EOF

systemctl enable -q --now browserless
systemctl enable -q --now changedetection
msg_ok "Created Services"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

cloudflared() {
banlet cloudflared 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Cloudflared"
mkdir -p --mode=0755 /usr/share/keyrings
VERSION="$(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)"
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg >/usr/share/keyrings/cloudflare-main.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $VERSION main" >/etc/apt/sources.list.d/cloudflared.list
apt-get update
apt-get install -y cloudflared
msg_ok "Installed Cloudflared"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


############################################################



coolify() {



      
      
     DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____             __
           / __ \____  _____/ /_  __  _____
          / / / / __ \/ ___/ //_/ _ \/ ___/
         / /_/ / /_/ / /__/ ,< /  __/ /
        /_____/\____/\___/_/|_|\___/_/
            
      Wesh Alors Prod - zshmeta' | lolcat
    
      get_latest_release() {
        curl -sL https://api.github.com/repos/"$1"/releases/latest | grep '"tag_name":' | cut -d'"' -f4
      }
      
      DOCKER_LATEST_VERSION=$(get_latest_release "moby/moby")
      DOCKER_COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")
    
      echo "Installing Docker $DOCKER_LATEST_VERSION"
      DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
      mkdir -p "$(dirname $DOCKER_CONFIG_PATH)"
      VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
      cd /usr/local/bin
      curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/"$VER"/fuse-overlayfs-x86_64
      chmod 755 /usr/local/bin/fuse-overlayfs
      cd ~
      echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
    
      sh <(curl -sSL https://get.docker.com)
      echo "Installed Docker $DOCKER_LATEST_VERSION"
    
      read -r -p "Would you like to add Portainer? <y/N> " prompt
      if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
        echo "Installing Portainer $\"$APPS\"portAINER_LATEST_VERSION"
        docker volume create portainer_data >/dev/null
        docker run -d \
            -p 8000:8000 \
            -p 9000:9000 \
            --name=portainer \
            --restart=always \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v portainer_data:/data \
            portainer/portainer-ce:latest
        echo "Installed Portainer $\"$APPS\"portAINER_LATEST_VERSION"
        else
        read -r -p "Would you like to add the Portainer Agent? <y/N> " prompt
        if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
          echo "Installing Portainer agent $\"$APPS\"portAINER_AGENT_LATEST_VERSION"
          docker run -d \
              -p 9001:9001 \
              --name portainer_agent \
              --restart=always \
              -v /var/run/docker.sock:/var/run/docker.sock \
              -v /var/lib/docker/volumes:/var/lib/docker/volumes \
              portainer/agent
          echo "Installed Portainer Agent $\"$APPS\"portAINER_AGENT_LATEST_VERSION"
        fi
      fi
      read -r -p "Would you like to add Docker Compose? <y/N> " prompt
      if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
        echo "Installing Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
        DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
        mkdir -p "$DOCKER_CONFIG"/cli-plugins
        curl -sSL https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_LATEST_VERSION"/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
        chmod +x "$DOCKER_CONFIG"/cli-plugins/docker-compose
        echo "Installed Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
      fi
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____             __
           / __ \____  _____/ /_  __  _____
          / / / / __ \/ ___/ //_/ _ \/ ___/
         / /_/ / /_/ / /__/ ,< /  __/ /
        /_____/\____/\___/_/|_|\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    VERSION="1.0.0"
    DOCKER_VERSION="23.0"
    
    CDN="https://cdn.coollabs.io/coolify"
    OS_TYPE=$(cat /etc/os-release | grep -w "ID" | cut -d "=" -f 2 | tr -d '"')
    OS_VERSION=$(cat /etc/os-release | grep -w "VERSION_ID" | cut -d "=" -f 2 | tr -d '"')
    LATEST_VERSION=$(curl --silent $CDN/versions.json | grep -i version | sed -n '2p' | xargs | awk '{print $2}' | tr -d ',')
    DATE=$(date +"%Y%m%d-%H%M%S")
    
    if [ $EUID != 0 ]; then
        echo "Please run as root"
        exit
    fi
    if [ "$OS_TYPE" != "ubuntu" ] && [ $OS_TYPE != "debian" ]; then
        echo "This script only supports Ubuntu and Debian for now."
        exit
    fi
    
    # Ovewrite LATEST_VERSION if user pass a version number
    if [ "$1" != "" ]; then
        LATEST_VERSION=$1
    fi
    
    echo -e "-------------"
    echo -e "Welcome to Coolify v4 beta installer!"
    echo -e "This script will install everything for you."
    echo -e "(Source code: https://github.com/coollabsio/coolify/blob/main/scripts/install.sh)\n"
    echo -e "-------------"
    
    echo "OS: $OS_TYPE $OS_VERSION"
    echo "Coolify version: $LATEST_VERSION"
    
    echo -e "-------------"
    echo "Installing required packages..."
    
    apt update -y >/dev/null 2>&1
    apt install -y curl wget git jq >/dev/null 2>&1
    
    if ! [ -x "$(command -v docker)" ]; then
        echo "Docker is not installed. Installing Docker..."
        curl https://releases.rancher.com/install-docker/${DOCKER_VERSION}.sh | sh
        echo "Docker installed successfully"
    fi
    echo -e "-------------"
    echo -e "Check Docker Configuration..."
    mkdir -p /etc/docker
    
    test -s /etc/docker/daemon.json && cp /etc/docker/daemon.json /etc/docker/daemon.json.original-$DATE || cat >/etc/docker/daemon.json <<EOL
    {
      "live-restore": true,
      "log-driver": "json-file",
      "log-opts": {
        "max-size": "10m",
        "max-file": "3"
      }
    }
EOL
    cat >/etc/docker/daemon.json.coolify <<EOL
    {
      "live-restore": true,
      "log-driver": "json-file",
      "log-opts": {
        "max-size": "10m",
        "max-file": "3"
      }
    }
EOL
    cat <<<"$(jq . /etc/docker/daemon.json.coolify)" >/etc/docker/daemon.json.coolify
    cat <<<"$(jq -s '.[0] * .[1]' /etc/docker/daemon.json /etc/docker/daemon.json.coolify)" >/etc/docker/daemon.json
    DIFF=$(diff <(jq --sort-keys . /etc/docker/daemon.json) <(jq --sort-keys . /etc/docker/daemon.json.original-$DATE))
    if [ "$DIFF" != "" ]; then
        echo "Docker configuration updated, restart docker daemon..."
        systemctl restart docker
    else
        echo "Docker configuration is up to date."
    fi
    
    echo -e "-------------"
    
    mkdir -p /data/coolify/ssh/keys
    mkdir -p /data/coolify/ssh/mux
    mkdir -p /data/coolify/source
    mkdir -p /data/coolify/proxy/dynamic
    
    chown -R 9999:root /data
    chmod -R 700 /data
    
    echo "Downloading required files from CDN..."
    curl -fsSL $CDN/docker-compose.yml -o /data/coolify/source/docker-compose.yml
    curl -fsSL $CDN/docker-compose.prod.yml -o /data/coolify/source/docker-compose.prod.yml
    curl -fsSL $CDN/.env.production -o /data/coolify/source/.env.production
    curl -fsSL $CDN/upgrade.sh -o /data/coolify/source/upgrade.sh
    
    # Copy .env.example if .env does not exist
    if [ ! -f /data/coolify/source/.env ]; then
        cp /data/coolify/source/.env.production /data/coolify/source/.env
        sed -i "s|APP_ID=.*|APP_ID=$(openssl rand -hex 16)|g" /data/coolify/source/.env
        sed -i "s|APP_KEY=.*|APP_KEY=base64:$(openssl rand -base64 32)|g" /data/coolify/source/.env
        sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=$(openssl rand -base64 32)|g" /data/coolify/source/.env
        sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=$(openssl rand -base64 32)|g" /data/coolify/source/.env
    fi
    
    # Merge .env and .env.production. New values will be added to .env
    sort -u -t '=' -k 1,1 /data/coolify/source/.env /data/coolify/source/.env.production | sed '/^$/d' >/data/coolify/source/.env.temp && mv /data/coolify/source/.env.temp /data/coolify/source/.env
    
    # Generate an ssh key (ed25519) at /data/coolify/ssh/keys/id.root@host.docker.internal
    if [ ! -f /data/coolify/ssh/keys/id.root@host.docker.internal ]; then
        ssh-keygen -t ed25519 -a 100 -f /data/coolify/ssh/keys/id.root@host.docker.internal -q -N "" -C root@coolify
        chown 9999 /data/coolify/ssh/keys/id.root@host.docker.internal
    fi
    
    addSshKey() {
        cat /data/coolify/ssh/keys/id.root@host.docker.internal.pub >>~/.ssh/authorized_keys
        chmod 600 ~/.ssh/authorized_keys
    }
    
    if [ ! -f ~/.ssh/authorized_keys ]; then
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
        touch ~/.ssh/authorized_keys
        addSshKey
    fi
    
    if [ -z "$(grep -w "root@coolify" ~/.ssh/authorized_keys)" ]; then
        addSshKey
    fi
    
    bash /data/coolify/source/upgrade.sh ${LATEST_VERSION:-latest}
    
    echo -e "\nCongratulations! Your Coolify instance is ready to use.\n"
    echo "Please visit http://$(curl -4s https://ifconfig.io):8000 to get started."   

    echo    'Wesh Alors Prod - zshmeta
        ░█████╗░░█████╗░░█████╗░██╗░░░░░██╗███████╗██╗░░░██╗
        ██╔══██╗██╔══██╗██╔══██╗██║░░░░░██║██╔════╝╚██╗░██╔╝
        ██║░░╚═╝██║░░██║██║░░██║██║░░░░░██║█████╗░░░╚████╔╝░
        ██║░░██╗██║░░██║██║░░██║██║░░░░░██║██╔══╝░░░░╚██╔╝░░
        ╚█████╔╝╚█████╔╝╚█████╔╝███████╗██║██║░░░░░░░░██║░░░
        ░╚════╝░░╚════╝░░╚════╝░╚══════╝╚═╝╚═╝░░░░░░░░╚═╝░░░
            
      Wesh Alors Prod - zshmeta' | lolcat

    
}


############################################################





###############################################################################################

cronicle() {
banlet cronicle 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y make
apt-get install -y g++
apt-get install -y gcc
msg_ok "Installed Dependencies"

msg_info "Installing Node.js"
bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
. ~/.bashrc
nvm install 16.20.1
ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
msg_ok "Installed Node.js"

msg_info "Installing Cronicle Primary Server"
LATEST=$(curl -sL https://api.github.com/repos/jhuckaby/Cronicle/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
IP=$(hostname -I | awk '{print $1}')
mkdir -p /opt/cronicle
cd /opt/cronicle
tar zxvf <(curl -fsSL https://github.com/jhuckaby/Cronicle/archive/${LATEST}.tar.gz) --strip-components 1
npm install
node bin/build.js dist
sed -i "s/localhost:3012/${IP}:3012/g" /opt/cronicle/conf/config.json
/opt/cronicle/bin/control.sh setup
/opt/cronicle/bin/control.sh start
cp /opt/cronicle/bin/cronicled.init /etc/init.d/cronicled
chmod 775 /etc/init.d/cronicled
update-rc.d cronicled defaults
msg_ok "Installed Cronicle Primary Server"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

daemonsync() {
banlet daemonsync 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y g++-multilib
msg_ok "Installed Dependencies"

msg_info "Installing Daemon Sync Server"
wget -qL https://github.com/tteck/Proxmox/raw/main/misc/daemonsync_2.2.0.0059_amd64.deb
dpkg -i daemonsync_2.2.0.0059_amd64.deb
msg_ok "Installed Daemon Sync Server"


msg_info "Cleaning up"
rm -rf daemonsync_2.2.0.0059_amd64.deb
apt-get autoremove >/dev/null
apt-get autoclean >/dev/null
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

dashy() {
banlet dashy 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Installing Node.js (Patience)"
apt-get install -y npm
npm cache clean -f
npm install -g n
n 16.20.1
npm install -g pnpm
ln -sf /usr/local/bin/node /usr/bin/node
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
npm install --global yarn
ln -sf /usr/local/bin/yarn /usr/bin/yarn
msg_ok "Installed Yarn"

msg_info "Installing Dashy (Patience)"
git clone https://github.com/Lissy93/dashy.git
cd /dashy
yarn
export NODE_OPTIONS=--max-old-space-size=1000
yarn build
msg_ok "Installed Dashy"

msg_info "Creating Services"
cat <<EOF >/etc/systemd/system/dashy.service
[Unit]
Description=dashy

[Service]
Type=simple
WorkingDirectory=/dashy
ExecStart=/usr/bin/yarn start
[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/systemd/system/dashy-rebuild.service
[Unit]
Description=Rebuild Dashy on Config Changes

[Service]
Type=oneshot
ExecStart=/usr/bin/yarn --cwd=/dashy build
EOF

cat <<EOF >/etc/systemd/system/dashy-rebuild.path
[Unit]
Description=Monitor Dashy Config for Changes

[Path]
PathChanged=/dashy/public/conf.yml

[Install]
WantedBy=multi-user.target
EOF
systemctl -q --now enable dashy
systemctl -q --now enable dashy-rebuild
msg_ok "Created Services"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

debian() {
banlet debian 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

deconz() {
banlet deconz 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Setting Phoscon Repository"
VERSION="$(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)"
curl -fsSL http://phoscon.de/apt/deconz.pub.key >/etc/apt/trusted.gpg.d/deconz.pub.asc
echo "deb [arch=amd64] http://phoscon.de/apt/deconz $VERSION main" >/etc/apt/sources.list.d/deconz.list
msg_ok "Setup Phoscon Repository"

msg_info "Installing deConz"
wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
apt-get update
apt-get install -y deconz
msg_ok "Installed deConz"

msg_info "Creating Service"
cat <<EOF >/lib/systemd/system/deconz.service
[Unit]
Description=deCONZ: ZigBee gateway -- REST API
Wants=deconz-init.service deconz-update.service
StartLimitIntervalSec=0

[Service]
User=root
ExecStart=/usr/bin/deCONZ -platform minimal --http-port=80
Restart=on-failure
RestartSec=30
AmbientCapabilities=CAP_NET_BIND_SERVICE CAP_KILL CAP_SYS_BOOT CAP_SYS_TIME

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now deconz
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

deluge() {
banlet deluge 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Deluge"
pip install deluge[all]
pip install lbry-libtorrent
msg_ok "Installed Deluge"

msg_info "Creating Service"
service_path="/etc/systemd/system/deluged.service"
echo "[Unit]
Description=Deluge Bittorrent Client Daemon
Documentation=man:deluged
After=network-online.target

[Service]
Type=simple
UMask=007
ExecStart=/usr/local/bin/deluged -d
Restart=on-failure
TimeoutStopSec=300

[Install]
WantedBy=multi-user.target" >$service_path

service_path="/etc/systemd/system/deluge-web.service"
echo "[Unit]
Description=Deluge Bittorrent Client Web Interface
Documentation=man:deluge-web
After=deluged.service
Wants=deluged.service

[Service]
Type=simple
UMask=027
ExecStart=/usr/local/bin/deluge-web -d
Restart=on-failure

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now -q deluged.service
systemctl enable --now -q deluge-web.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

devuan() {
banlet devuan 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

docker() {
banlet docker 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

get_latest_release() {
  curl -sL https://api.github.com/repos/$1/releases/latest | grep '"tag_name":' | cut -d'"' -f4
}

DOCKER_LATEST_VERSION=$(get_latest_release "moby/moby")
PORTAINER_LATEST_VERSION=$(get_latest_release "portainer/portainer")
PORTAINER_AGENT_LATEST_VERSION=$(get_latest_release "portainer/agent")
DOCKER_COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")

msg_info "Installing Docker $DOCKER_LATEST_VERSION"
DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
mkdir -p $(dirname $DOCKER_CONFIG_PATH)
if [ "$ST" == "yes" ]; then
  VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
  cd /usr/local/bin
  curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/$VER/fuse-overlayfs-x86_64
  chmod 755 /usr/local/bin/fuse-overlayfs
  cd ~
  echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
else
  echo -e '{\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
fi
sh <(curl -sSL https://get.docker.com)
msg_ok "Installed Docker $DOCKER_LATEST_VERSION"

read -r -p "Would you like to add Portainer? <y/N> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  msg_info "Installing Portainer $PORTAINER_LATEST_VERSION"
  docker volume create portainer_data >/dev/null
  docker run -d \
    -p 8000:8000 \
    -p 9000:9000 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
  msg_ok "Installed Portainer $PORTAINER_LATEST_VERSION"
else
  read -r -p "Would you like to add the Portainer Agent? <y/N> " prompt
  if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
    msg_info "Installing Portainer agent $PORTAINER_AGENT_LATEST_VERSION"
    docker run -d \
      -p 9001:9001 \
      --name portainer_agent \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v /var/lib/docker/volumes:/var/lib/docker/volumes \
      portainer/agent
    msg_ok "Installed Portainer Agent $PORTAINER_AGENT_LATEST_VERSION"
  fi
fi
read -r -p "Would you like to add Docker Compose? <y/N> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  msg_info "Installing Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p $DOCKER_CONFIG/cli-plugins
  curl -sSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_LATEST_VERSION/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
  msg_ok "Installed Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
fi


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

emby() {
banlet emby 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

if [[ "$CTTYPE" == "0" ]]; then
  msg_info "Setting Up Hardware Acceleration"
  apt-get -y install \
    va-driver-all \
    ocl-icd-libopencl1
  if [[ ${PCT_OSVERSION} == "20.04" ]]; then 
  apt-get install -y beignet-opencl-icd
  else
  apt-get install -y intel-opencl-icd
  fi
  /bin/chgrp video /dev/dri
  /bin/chmod 755 /dev/dri
  /bin/chmod 660 /dev/dri/*
  msg_ok "Set Up Hardware Acceleration"
fi

LATEST=$(curl -sL https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest | grep '"tag_name":' | cut -d'"' -f4)

msg_info "Installing Emby"
wget -q https://github.com/MediaBrowser/Emby.Releases/releases/download/${LATEST}/emby-server-deb_${LATEST}_amd64.deb
dpkg -i emby-server-deb_${LATEST}_amd64.deb
msg_ok "Installed Emby"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm emby-server-deb_${LATEST}_amd64.deb
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

emqx() {
banlet emqx 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing EMQX"
bash <(curl -fsSL https://packagecloud.io/install/repositories/emqx/emqx/script.deb.sh)
apt-get install -y emqx
systemctl enable --now emqx
msg_ok "Installed EMQX"


msg_info "Cleaning up"
apt-get autoremove >/dev/null
apt-get autoclean >/dev/null
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

esphome() {
banlet esphome 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv

msg_ok "Updated Python3"

msg_info "Installing ESPHome"
#mkdir /srv/esphome

#cd /srv/esphome

#python3 -m venv .

#source bin/activate

pip install esphome tornado esptool
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed ESPHome"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/esphomeDashboard.service
[Unit]
Description=ESPHome Dashboard
After=network.target

[Service]
#ExecStart=/srv/esphome/bin/esphome dashboard /root/config/

ExecStart=/usr/local/bin/esphome dashboard /root/config/
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now esphomeDashboard.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

fhem() {
banlet fhem 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y avahi-daemon
apt-get install -y gnupg2
msg_ok "Installed Dependencies"

msg_info "Setting up Fhem Repository"
curl -sSf https://debian.fhem.de/archive.key | gpg --dearmor >/etc/apt/trusted.gpg.d/debianfhemde-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/debianfhemde-archive-keyring.gpg] https://debian.fhem.de/nightly/ /' >/etc/apt/sources.list.d/fhem.list
msg_ok "Set up Fhem Repository"

msg_info "Installing Fhem"
apt-get update
apt-get install -y fhem
msg_info "Installed Fhem"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

go2rtc() {
banlet go2rtc 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing go2rtc"
mkdir -p /opt/go2rtc
cd /opt/go2rtc
wget -q https://github.com/AlexxIT/go2rtc/releases/latest/download/go2rtc_linux_amd64
chmod +x go2rtc_linux_amd64
msg_ok "Installed go2rtc"

msg_info "Creating Service"
service_path="/etc/systemd/system/go2rtc.service"
echo "[Unit]
Description=go2rtc service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/opt/go2rtc/go2rtc_linux_amd64

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable -q --now go2rtc
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

grafana() {
banlet grafana 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
apt-get install -y apt-transport-https
apt-get install -y software-properties-common
msg_ok "Installed Dependencies"

msg_info "Setting up Grafana Repository"
wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
sh -c 'echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" > /etc/apt/sources.list.d/grafana.list'
msg_ok "Set up Grafana Repository"

msg_info "Installing Grafana"
apt-get update
apt-get install -y grafana
systemctl start grafana-server
systemctl enable --now -q grafana-server.service
msg_ok "Installed Grafana"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

grocy() {
banlet grocy 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y apt-transport-https
msg_ok "Installed Dependencies"

msg_info "Installing PHP 8.1"
VERSION="$(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)"
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
echo -e "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $VERSION main" >/etc/apt/sources.list.d/php.list
apt-get update
apt-get install -y php8.1
apt-get install -y libapache2-mod-php8.1
apt-get install -y php8.1-sqlite3
apt-get install -y php8.1-gd
apt-get install -y php8.1-intl
apt-get install -y php8.1-mbstring
msg_ok "Installed PHP 8.1"

msg_info "Installing grocy"
latest=$(curl -s https://api.github.com/repos/grocy/grocy/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
wget -q https://github.com/grocy/grocy/releases/download/v${latest}/grocy_${latest}.zip
unzip grocy_${latest}.zip -d /var/www/html
chown -R www-data:www-data /var/www/html
cp /var/www/html/config-dist.php /var/www/html/data/config.php
chmod +x /var/www/html/update.sh

cat <<EOF >/etc/apache2/sites-available/grocy.conf
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html/public
  ErrorLog /var/log/apache2/error.log
<Directory /var/www/html/public>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Order allow,deny
  allow from all
</Directory>
</VirtualHost>
EOF

a2dissite 000-default.conf
a2ensite grocy.conf
a2enmod rewrite
systemctl reload apache2
msg_ok "Installed grocy"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm -rf /root/grocy_${latest}.zip
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

heimdalldashboard() {
banlet heimdalldashboard 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing PHP"
apt-get install -y php
apt-get install -y php-sqlite3
apt-get install -y php-zip
apt-get install -y php-xml
msg_ok "Installed PHP"

RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/Heimdall/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]')
msg_info "Installing Heimdall Dashboard ${RELEASE}"
curl --silent -o ${RELEASE}.tar.gz -L "https://github.com/linuxserver/Heimdall/archive/${RELEASE}.tar.gz"
tar xvzf ${RELEASE}.tar.gz
VER=$(curl -s https://api.github.com/repos/linuxserver/Heimdall/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 3, length($2)-4) }')
rm -rf ${RELEASE}.tar.gz
mv Heimdall-${VER} /opt/Heimdall
msg_ok "Installed Heimdall Dashboard ${RELEASE}"

msg_info "Creating Service"
service_path="/etc/systemd/system/heimdall.service"
echo "[Unit]
Description=Heimdall
After=network.target

[Service]
Restart=always
RestartSec=5
Type=simple
User=root
WorkingDirectory=/opt/Heimdall
ExecStart="/usr/bin/php" artisan serve --port 7990 --host 0.0.0.0
TimeoutStopSec=30

[Install]
WantedBy=multi-user.target" >$service_path
sudo systemctl enable --now heimdall.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homarr() {
banlet homarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
npm install -g yarn
msg_ok "Installed Yarn"

msg_info "Installing Homarr (Patience)"
git clone -q https://github.com/ajnart/homarr.git /opt/homarr
cd /opt/homarr
yarn install
yarn build
msg_ok "Installed Homarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/homarr.service
[Unit]
Description=Homarr Service
After=network.target

[Service]
Type=exec
WorkingDirectory=/opt/homarr
ExecStart=/usr/bin/yarn start

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now homarr.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homeassistant() {
banlet homeassistant 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv
msg_ok "Updated Python3"

msg_info "Installing runlike"
pip install runlike
msg_ok "Installed runlike"

get_latest_release() {
  curl -sL https://api.github.com/repos/$1/releases/latest | grep '"tag_name":' | cut -d'"' -f4
}

DOCKER_LATEST_VERSION=$(get_latest_release "moby/moby")
CORE_LATEST_VERSION=$(get_latest_release "home-assistant/core")
PORTAINER_LATEST_VERSION=$(get_latest_release "portainer/portainer")

msg_info "Installing Docker $DOCKER_LATEST_VERSION"
DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
mkdir -p $(dirname $DOCKER_CONFIG_PATH)
if [ "$ST" == "yes" ]; then
  VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
  cd /usr/local/bin
  curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/$VER/fuse-overlayfs-x86_64
  chmod 755 /usr/local/bin/fuse-overlayfs
  cd ~
  echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
else
  echo -e '{\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
fi
sh <(curl -sSL https://get.docker.com)
msg_ok "Installed Docker $DOCKER_LATEST_VERSION"

msg_info "Pulling Portainer $PORTAINER_LATEST_VERSION Image"
docker pull portainer/portainer-ce:latest
msg_ok "Pulled Portainer $PORTAINER_LATEST_VERSION Image"

msg_info "Installing Portainer $PORTAINER_LATEST_VERSION"
docker volume create portainer_data
docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
msg_ok "Installed Portainer $PORTAINER_LATEST_VERSION"

msg_info "Pulling Home Assistant $CORE_LATEST_VERSION Image"
docker pull ghcr.io/home-assistant/home-assistant:stable
msg_ok "Pulled Home Assistant $CORE_LATEST_VERSION Image"

msg_info "Installing Home Assistant $CORE_LATEST_VERSION"
docker volume create hass_config
docker run -d \
  --name homeassistant \
  --privileged \
  --restart unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /dev:/dev \
  -v hass_config:/config \
  -v /etc/localtime:/etc/localtime:ro \
  --net=host \
  ghcr.io/home-assistant/home-assistant:stable
mkdir /root/hass_config
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed Home Assistant $CORE_LATEST_VERSION"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homeassistant-core() {
banlet homeassistant-core 

msg_info "Installing Dependencies, (Patience)"
apt-get install -y \
  git \
  curl \
  sudo \
  mc \
  bluez \
  libffi-dev \
  libssl-dev \
  libjpeg-dev \
  zlib1g-dev \
  autoconf \
  build-essential \
  libopenjp2-7 \
  libturbojpeg0-dev \
  ffmpeg \
  liblapack3 \
  liblapack-dev \
  dbus-broker \
  libpcap-dev \
  libmariadb-dev-compat \
  libatlas-base-dev
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv

msg_ok "Updated Python3"

if [[ "$PCT_OSVERSION" == "11" ]]; then
  msg_info "Installing pyenv"
  apt-get install -y \
    make \
    libreadline-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    llvm \
    libbz2-dev \
    libxml2-dev \
    libxmlsec1-dev \
    liblzma-dev
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  set +e
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init --path)"\nfi' >>~/.bashrc
  msg_ok "Installed pyenv"
  . ~/.bashrc

  set -e
  msg_info "Installing Python 3.11.3 (Patience)"
  pyenv install 3.11.3
  pyenv global 3.11.3
  msg_ok "Installed Python 3.11.3"
fi

msg_info "Installing Home Assistant-Core"
mkdir /srv/homeassistant
cd /srv/homeassistant
python3 -m venv .
source bin/activate
pip install --upgrade pip
python3 -m pip install wheel
pip install homeassistant
pip install mysqlclient
pip install psycopg2-binary
mkdir -p /root/.homeassistant
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed Home Assistant-Core"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/homeassistant.service
[Unit]
Description=Home Assistant
After=network-online.target
[Service]
Type=simple
WorkingDirectory=/root/.homeassistant
ExecStart=/srv/homeassistant/bin/hass -c "/root/.homeassistant"
Restart=always
RestartForceExitStatus=100
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now homeassistant
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homebridge() {
banlet homebridge 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y avahi-daemon
apt-get install -y gnupg2
msg_ok "Installed Dependencies"

msg_info "Setting up Homebridge Repository"
curl -sSf https://repo.homebridge.io/KEY.gpg | gpg --dearmor >/etc/apt/trusted.gpg.d/homebridge.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/homebridge.gpg] https://repo.homebridge.io stable main' >/etc/apt/sources.list.d/homebridge.list
msg_ok "Set up Homebridge Repository"

msg_info "Installing Homebridge"
apt update
apt-get install -y homebridge
msg_info "Installed Homebridge"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homepage() {
banlet homepage 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs git make g++ gcc
npm install -g pnpm
msg_ok "Installed Node.js"

msg_info "Installing Homepage (Patience)"
cd /opt
git clone https://github.com/benphelps/homepage.git
cd /opt/homepage
mkdir -p config
cp /opt/homepage/src/skeleton/* /opt/homepage/config
pnpm install
pnpm build
msg_ok "Installed Homepage"

msg_info "Creating Service"
service_path="/etc/systemd/system/homepage.service"
echo "[Unit]
Description=Homepage
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
WorkingDirectory=/opt/homepage/
ExecStart=pnpm start
[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now homepage
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

homer() {
banlet homer 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y pip
msg_ok "Installed Dependencies"

msg_info "Installing Homer"
mkdir -p /opt/homer
cd /opt/homer
wget -q https://github.com/bastienwirtz/homer/releases/latest/download/homer.zip
unzip homer.zip
rm -rf homer.zip
cp assets/config.yml.dist assets/config.yml
msg_ok "Installed Homer"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/homer.service
[Unit]
Description=Homer Dashboard
After=network-online.target
[Service]
Type=simple
WorkingDirectory=/opt/homer
ExecStart=python3 -m http.server 8010
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now homer
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

hyperion() {
banlet hyperion 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y lsb-release
apt-get install -y gpg
apt-get install -y apt-transport-https
msg_ok "Installed Dependencies"

msg_info "Installing Hyperion"
wget -qO- https://apt.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.hyperion-project.org/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/hyperion.list'
apt-get update
apt-get install -y hyperion
systemctl enable --now hyperion@root.service
msg_ok "Installed Hyperion"


msg_info "Cleaning up"
apt-get autoremove >/dev/null
apt-get autoclean >/dev/null
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

influxdb() {
banlet influxdb 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y lsb-base
apt-get install -y lsb-release
apt-get install -y gnupg2
msg_ok "Installed Dependencies"

msg_info "Setting up InfluxDB Repository"
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
sh -c 'echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main" > /etc/apt/sources.list.d/influxdata.list'
msg_ok "Set up InfluxDB Repository"

read -r -p "Which version of InfluxDB to install? (1 or 2) " prompt
if [[ $prompt == "2" ]]; then
  INFLUX="2"
else
  INFLUX="1"
fi

msg_info "Installing InfluxDB"
apt-get update
if [[ $INFLUX == "2" ]]; then
  apt-get install -y influxdb2
else
  apt-get install -y influxdb
  wget -q https://dl.influxdata.com/chronograf/releases/chronograf_1.10.1_amd64.deb
  dpkg -i chronograf_1.10.1_amd64.deb
fi
systemctl enable --now influxdb
msg_ok "Installed InfluxDB"

read -r -p "Would you like to add Telegraf? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
  msg_info "Installing Telegraf"
  apt-get install -y telegraf
  msg_ok "Installed Telegraf"
fi


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

iobroker() {
banlet iobroker 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing ioBroker (Patience)"
bash <(curl -fsSL https://iobroker.net/install.sh)
msg_ok "Installed ioBroker"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

jackett() {
banlet jackett 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Jackett"
RELEASE=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4)
wget -q https://github.com/Jackett/Jackett/releases/download/$RELEASE/Jackett.Binaries.LinuxAMDx64.tar.gz
tar -xzf Jackett.Binaries.LinuxAMDx64.tar.gz -C /opt
rm -rf Jackett.Binaries.LinuxAMDx64.tar.gz
msg_ok "Installed Jackett"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/jackett.service
[Unit]
Description=Jackett Daemon
After=network.target
[Service]
SyslogIdentifier=jackett
Restart=always
RestartSec=5
Type=simple
WorkingDirectory=/opt/Jackett
ExecStart=/bin/sh /opt/Jackett/jackett_launcher.sh
TimeoutStopSec=30
[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now jackett.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

jellyfin() {
banlet jellyfin 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y gnupg
apt-get install -y mc
msg_ok "Installed Dependencies"

if [[ "$CTTYPE" == "0" ]]; then
  msg_info "Setting Up Hardware Acceleration"
  apt-get -y install \
    va-driver-all \
    ocl-icd-libopencl1
  if [[ ${PCT_OSVERSION} == "20.04" ]]; then 
  apt-get install -y beignet-opencl-icd
  else
  apt-get install -y intel-opencl-icd
  fi
  /bin/chgrp video /dev/dri
  /bin/chmod 755 /dev/dri
  /bin/chmod 660 /dev/dri/*
  msg_ok "Set Up Hardware Acceleration"
fi

msg_info "Installing Jellyfin"
VERSION="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
# If the keyring directory is absent, create it

if [[ ! -d /etc/apt/keyrings ]]; then
    mkdir -p /etc/apt/keyrings
fi
# Download the repository signing key and install it to the keyring directory

curl -fsSL https://repo.jellyfin.org/jellyfin_team.gpg.key | gpg --dearmor --yes --output /etc/apt/keyrings/jellyfin.gpg
# Install the Deb822 format jellyfin.sources entry

cat <<EOF >/etc/apt/sources.list.d/jellyfin.sources
Types: deb
URIs: https://repo.jellyfin.org/${PCT_OSTYPE}
Suites: ${VERSION}
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/jellyfin.gpg
EOF
# Install Jellyfin using the metapackage (which will fetch jellyfin-server, jellyfin-web, and jellyfin-ffmpeg5)

apt-get update
apt-get install -y jellyfin
msg_ok "Installed Jellyfin"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

jellyseerr() {
banlet jellyseerr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
npm install -g yarn
msg_ok "Installed Yarn"

msg_info "Installing Jellyseerr (Patience)"
git clone -q https://github.com/Fallenbagel/jellyseerr.git /opt/jellyseerr
cd /opt/jellyseerr
yarn install
yarn build
mkdir -p /etc/jellyseerr/
cat <<EOF >/etc/jellyseerr/jellyseerr.conf
PORT=5055
# HOST=0.0.0.0

# JELLYFIN_TYPE=emby

EOF
msg_ok "Installed Jellyseerr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/jellyseerr.service
[Unit]
Description=jellyseerr Service
After=network.target

[Service]
EnvironmentFile=/etc/jellyseerr/jellyseerr.conf
Environment=NODE_ENV=production
Type=exec
WorkingDirectory=/opt/jellyseerr
ExecStart=/usr/bin/yarn start

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now jellyseerr.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

k0s() {
banlet k0s 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Installing k0s Kubernetes"
bash <(curl -sSLf https://get.k0s)
k0s install controller --single
k0s start
mkdir -p /etc/k0s
k0s config create > /etc/k0s/k0s.yaml
msg_ok "Installed k0s Kubernetes"

read -r -p "Would you like to add Helm Package Manager? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
msg_info "Installing Helm"
bash <(curl -sSLf https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
msg_ok "Installed Helm"
fi

msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

kavita() {
banlet kavita 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Kavita"
cd /opt
RELEASE=$(curl -s https://api.github.com/repos/Kareadita/Kavita/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
tar -xvzf <(curl -fsSL https://github.com/Kareadita/Kavita/releases/download/$RELEASE/kavita-linux-x64.tar.gz) --no-same-owner
msg_ok "Installed Kavita"

msg_info "Creating Service"
service_path="/etc/systemd/system/kavita.service"
echo "[Unit]
Description=Kavita Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/Kavita
ExecStart=/opt/Kavita/Kavita
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target" >$service_path
chmod +x /opt/Kavita/* && chown root /opt/Kavita/*
systemctl enable --now -q kavita.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

keycloak() {
banlet keycloak 

msg_info "Installing Dependencies (Patience)"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y ca-certificates-java
apt-get install -y openjdk-17-jre-headless
msg_ok "Installed Dependencies"

RELEASE=$(curl -s https://api.github.com/repos/keycloak/keycloak/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
msg_info "Installing Keycloak v$RELEASE"
cd /opt
wget -q https://github.com/keycloak/keycloak/releases/download/$RELEASE/keycloak-$RELEASE.tar.gz
tar -xvf keycloak-$RELEASE.tar.gz
mv keycloak-$RELEASE keycloak
msg_ok "Installed Keycloak"

msg_info "Creating Service"
service_path="/etc/systemd/system/keycloak.service"
echo "[Unit]
Description=Keycloak
After=network-online.target
[Service]
User=root
WorkingDirectory=/opt/keycloak
ExecStart=/opt/keycloak/bin/kc.sh start-dev
[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now keycloak.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

lidarr() {
banlet lidarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y sqlite3
apt-get install -y libchromaprint-tools
apt-get install -y mediainfo
msg_ok "Installed Dependencies"

msg_info "Installing Lidarr"
mkdir -p /var/lib/lidarr/
chmod 775 /var/lib/lidarr/
wget --content-disposition 'https://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Lidarr.master.*.tar.gz
mv Lidarr /opt
chmod 775 /opt/Lidarr
msg_ok "Installed Lidarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/lidarr.service
[Unit]
Description=Lidarr Daemon
After=syslog.target network.target
[Service]
UMask=0002
Type=simple
ExecStart=/opt/Lidarr/Lidarr -nobrowser -data=/var/lib/lidarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
systemctl -q daemon-reload
systemctl enable --now -q lidarr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Lidarr.master.*.tar.gz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

magicmirror() {
banlet magicmirror 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Installing Node.js"
bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
. ~/.bashrc
nvm install 16.20.1
ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
msg_ok "Installed Node.js"

msg_info "Setting up MagicMirror Repository"
git clone https://github.com/MichMich/MagicMirror /opt/magicmirror
msg_ok "Set up MagicMirror Repository"

msg_info "Installing MagicMirror"
cd /opt/magicmirror
npm install --only=prod --omit=dev

cat <<EOF >/opt/magicmirror/config/config.js
let config = {
        address: "0.0.0.0",     
        port: 8080,
        basePath: "/",  
        ipWhitelist: [],        
        useHttps: false,              
        httpsPrivateKey: "",    
        httpsCertificate: "",   
        language: "en",
        locale: "en-US",
        logLevel: ["INFO", "LOG", "WARN", "ERROR"], 
        timeFormat: 24,
        units: "metric",
        serverOnly:  true,
        modules: [
                {
                        module: "alert",
                },
                {
                        module: "updatenotification",
                        position: "top_bar"
                },
                {
                        module: "clock",
                        position: "top_left"
                },
                {
                        module: "calendar",
                        header: "US Holidays",
                        position: "top_left",
                        config: {
                                calendars: [
                                        {
                                                symbol: "calendar-check",
                                                url: "webcal://www.calendarlabs.com/ical-calendar/ics/76/US_Holidays.ics"
                                        }
                                ]
                        }
                },
                {
                        module: "compliments",
                        position: "lower_third"
                },
                {
                        module: "weather",
                        position: "top_right",
                        config: {
                                weatherProvider: "openweathermap",
                                type: "current",
                                location: "New York",
                                locationID: "5128581", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
                                apiKey: "YOUR_OPENWEATHER_API_KEY"
                        }
                },
                {
                        module: "weather",
                        position: "top_right",
                        header: "Weather Forecast",
                        config: {
                                weatherProvider: "openweathermap",
                                type: "forecast",
                                location: "New York",
                                locationID: "5128581", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
                                apiKey: "YOUR_OPENWEATHER_API_KEY"
                        }
                },
                {
                        module: "newsfeed",
                        position: "bottom_bar",
                        config: {
                                feeds: [
                                        {
                                                title: "New York Times",
                                                url: "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"
                                        }
                                ],
                                showSourceTitle: true,
                                showPublishDate: true,
                                broadcastNewsFeeds: true,
                                broadcastNewsUpdates: true
                        }
                },
        ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
EOF
msg_ok "Installed MagicMirror"

msg_info "Creating Service"
service_path="/etc/systemd/system/magicmirror.service"
echo "[Unit]
Description=Magic Mirror
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
WorkingDirectory=/opt/magicmirror/
ExecStart=/usr/bin/node serveronly

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now magicmirror
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

mariadb() {
banlet mariadb 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing MariaDB"
apt-get install -y mariadb-server
sed -i 's/^# *\(port *=.*\)/\1/' /etc/mysql/my.cnf
sed -i 's/^bind-address/#bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf
msg_ok "Installed MariaDB"

read -r -p "Would you like to add Adminer? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
  msg_info "Installing Adminer"
  apt install -y adminer
  a2enconf adminer
  systemctl reload apache2
  msg_ok "Installed Adminer"
fi


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

meshcentral() {
banlet meshcentral 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Node.js"
bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
. ~/.bashrc
nvm install 16.20.1
ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
msg_ok "Installed Node.js"

msg_info "Installing MeshCentral"
mkdir /opt/meshcentral
cd /opt/meshcentral
npm install meshcentral
node node_modules/meshcentral --install
msg_ok "Installed MeshCentral"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

motioneye() {
banlet motioneye 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y cifs-utils
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Motion"
apt-get install -y motion
systemctl stop motion
systemctl disable motion
msg_ok "Installed Motion"

msg_info "Installing FFmpeg"
apt-get install -y ffmpeg v4l-utils
msg_ok "Installed FFmpeg"

msg_info "Installing MotionEye"
apt-get update
pip install git+https://github.com/motioneye-project/motioneye.git@dev
mkdir -p /etc/motioneye
chown -R root:root /etc/motioneye
chmod -R 777 /etc/motioneye
wget -qO /etc/motioneye/motioneye.conf https://raw.githubusercontent.com/motioneye-project/motioneye/dev/motioneye/extra/motioneye.conf.sample
mkdir -p /var/lib/motioneye
msg_ok "Installed MotionEye"

msg_info "Creating Service"
wget -qO /etc/systemd/system/motioneye.service https://raw.githubusercontent.com/motioneye-project/motioneye/dev/motioneye/extra/motioneye.systemd
systemctl enable -q --now motioneye
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

mqtt() {
banlet mqtt 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Mosquitto MQTT Broker"
apt-get -y install mosquitto
apt-get -y install mosquitto-clients
cat <<EOF >/etc/mosquitto/conf.d/default.conf
allow_anonymous false
persistence true
password_file /etc/mosquitto/passwd
listener 1883
EOF
msg_ok "Installed Mosquitto MQTT Broker"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

n8n() {
banlet n8n 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing n8n (Patience)"
npm install --global n8n
msg_ok "Installed n8n"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/n8n.service
[Unit]
Description=n8n

[Service]
Type=simple
ExecStart=n8n start
[Install]
WantedBy=multi-user.target
EOF
systemctl enable --now n8n
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

navidrome() {
banlet navidrome 

msg_info "Installing Dependencies (patience)"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y ffmpeg
msg_ok "Installed Dependencies"

RELEASE=$(curl -s https://api.github.com/repos/navidrome/navidrome/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 3, length($2)-4) }')

msg_info "Installing Navidrome"
install -d -o root -g root /opt/navidrome
install -d -o root -g root /var/lib/navidrome
wget https://github.com/navidrome/navidrome/releases/download/v${RELEASE}/navidrome_${RELEASE}_Linux_x86_64.tar.gz -O Navidrome.tar.gz
tar -xvzf Navidrome.tar.gz -C /opt/navidrome/
chown -R root:root /opt/navidrome
mkdir -p /music
cat <<EOF >/var/lib/navidrome/navidrome.toml
MusicFolder = '/music'
EOF
msg_ok "Installed Navidrome"

msg_info "Creating Service"
service_path="/etc/systemd/system/navidrome.service"

echo "[Unit]
Description=Navidrome Music Server and Streamer compatible with Subsonic/Airsonic
After=remote-fs.target network.target
AssertPathExists=/var/lib/navidrome

[Service]
User=root
Group=root
Type=simple
ExecStart=/opt/navidrome/navidrome --configfile '/var/lib/navidrome/navidrome.toml'
WorkingDirectory=/var/lib/navidrome
TimeoutStopSec=20
KillMode=process
Restart=on-failure
DevicePolicy=closed
NoNewPrivileges=yes
PrivateTmp=yes
PrivateUsers=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
ProtectKernelTunables=yes
RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
RestrictNamespaces=yes
RestrictRealtime=yes
SystemCallFilter=~@clock @debug @module @mount @obsolete @reboot @setuid @swap
ReadWritePaths=/var/lib/navidrome
ProtectSystem=full

[Install]
WantedBy=multi-user.target" >$service_path
systemctl daemon-reload
systemctl enable --now navidrome.service

msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm -rf /root/Navidrome.tar.gz
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

nextcloudpi() {
banlet nextcloudpi 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing NextCloudPi (Patience)"
bash <(curl -fsSL https://raw.githubusercontent.com/nextcloud/nextcloudpi/master/install.sh)
sed -i "s/3 => 'nextcloudpi.lan',/3 => '0.0.0.0',/g" /var/www/nextcloud/config/config.php
sed -i '{s|root:/usr/sbin/nologin|root:/bin/bash|g}' /etc/passwd
sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/8.1/fpm/php.ini /etc/php/8.1/cli/php.ini
service apache2 restart
msg_ok "Installed NextCloudPi"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

nginxproxymanager() {
banlet nginxproxymanager 

msg_info "Installing Dependencies"
apt-get update
apt-get -y install \
  sudo \
  mc \
  curl \
  gnupg \
  make \
  gcc \
  g++ \
  ca-certificates \
  apache2-utils \
  logrotate \
  build-essential \
  git
msg_ok "Installed Dependencies"

msg_info "Updating Python"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv \
  python3-cffi \
  python3-certbot \
  python3-certbot-dns-cloudflare

python3 -m venv /opt/certbot/
msg_ok "Updated Python"

VERSION="$(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)"

msg_info "Installing Openresty"
wget -qO - https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/openresty-archive-keyring.gpg
echo -e "deb http://openresty.org/package/debian bullseye openresty" >/etc/apt/sources.list.d/openresty.list
apt-get update
apt-get -y install openresty
msg_ok "Installed Openresty"

msg_info "Installing Node.js"
bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
. ~/.bashrc
nvm install 16.20.1
ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
npm install -g yarn
msg_ok "Installed Yarn"

RELEASE=$(curl -s https://api.github.com/repos/NginxProxyManager/nginx-proxy-manager/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 3, length($2)-4) }')

msg_info "Downloading Nginx Proxy Manager v${RELEASE}"
wget -q https://codeload.github.com/NginxProxyManager/nginx-proxy-manager/tar.gz/v${RELEASE} -O - | tar -xz
cd ./nginx-proxy-manager-${RELEASE}
msg_ok "Downloaded Nginx Proxy Manager v${RELEASE}"

msg_info "Setting up Enviroment"
ln -sf /usr/bin/python3 /usr/bin/python
ln -sf /usr/bin/certbot /opt/certbot/bin/certbot
ln -sf /usr/local/openresty/nginx/sbin/nginx /usr/sbin/nginx
ln -sf /usr/local/openresty/nginx/ /etc/nginx

sed -i "s+0.0.0+${RELEASE}+g" backend/package.json
sed -i "s+0.0.0+${RELEASE}+g" frontend/package.json

sed -i 's+^daemon+#daemon+g' docker/rootfs/etc/nginx/nginx.conf
NGINX_CONFS=$(find "$(pwd)" -type f -name "*.conf")
for NGINX_CONF in $NGINX_CONFS; do
  sed -i 's+include conf.d+include /etc/nginx/conf.d+g' "$NGINX_CONF"
done

mkdir -p /var/www/html /etc/nginx/logs
cp -r docker/rootfs/var/www/html/* /var/www/html/
cp -r docker/rootfs/etc/nginx/* /etc/nginx/
cp docker/rootfs/etc/letsencrypt.ini /etc/letsencrypt.ini
cp docker/rootfs/etc/logrotate.d/nginx-proxy-manager /etc/logrotate.d/nginx-proxy-manager
ln -sf /etc/nginx/nginx.conf /etc/nginx/conf/nginx.conf
rm -f /etc/nginx/conf.d/dev.conf

mkdir -p /tmp/nginx/body \
  /run/nginx \
  /data/nginx \
  /data/custom_ssl \
  /data/logs \
  /data/access \
  /data/nginx/default_host \
  /data/nginx/default_www \
  /data/nginx/proxy_host \
  /data/nginx/redirection_host \
  /data/nginx/stream \
  /data/nginx/dead_host \
  /data/nginx/temp \
  /var/lib/nginx/cache/public \
  /var/lib/nginx/cache/private \
  /var/cache/nginx/proxy_temp

chmod -R 777 /var/cache/nginx
chown root /tmp/nginx

echo resolver "$(awk 'BEGIN{ORS=" "} $1=="nameserver" {print ($2 ~ ":")? "["$2"]": $2}' /etc/resolv.conf);" >/etc/nginx/conf.d/include/resolvers.conf

if [ ! -f /data/nginx/dummycert.pem ] || [ ! -f /data/nginx/dummykey.pem ]; then
  openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -subj "/O=Nginx Proxy Manager/OU=Dummy Certificate/CN=localhost" -keyout /data/nginx/dummykey.pem -out /data/nginx/dummycert.pem &>/dev/null
fi

mkdir -p /app/global /app/frontend/images
cp -r backend/* /app
cp -r global/* /app/global
wget -q "https://github.com/just-containers/s6-overlay/releases/download/v3.1.5.0/s6-overlay-noarch.tar.xz"
wget -q "https://github.com/just-containers/s6-overlay/releases/download/v3.1.5.0/s6-overlay-x86_64.tar.xz"
tar -C / -Jxpf s6-overlay-noarch.tar.xz
tar -C / -Jxpf s6-overlay-x86_64.tar.xz
msg_ok "Set up Enviroment"

msg_info "Building Frontend"
cd ./frontend
export NODE_ENV=development
yarn install --network-timeout=30000
yarn build
cp -r dist/* /app/frontend
cp -r app-images/* /app/frontend/images
msg_ok "Built Frontend"

msg_info "Initializing Backend"
rm -rf /app/config/default.json
if [ ! -f /app/config/production.json ]; then
  cat <<'EOF' >/app/config/production.json
{
  "database": {
    "engine": "knex-native",
    "knex": {
      "client": "sqlite3",
      "connection": {
        "filename": "/data/database.sqlite"
      }
    }
  }
}
EOF
fi
cd /app
export NODE_ENV=development
yarn install --network-timeout=30000
msg_ok "Initialized Backend"

msg_info "Creating Service"
cat <<'EOF' >/lib/systemd/system/npm.service
[Unit]
Description=Nginx Proxy Manager
After=network.target
Wants=openresty.service

[Service]
Type=simple
Environment=NODE_ENV=production
ExecStartPre=-mkdir -p /tmp/nginx/body /data/letsencrypt-acme-challenge
ExecStart=/usr/bin/node index.js --abort_on_uncaught_exception --max_old_space_size=250
WorkingDirectory=/app
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
msg_ok "Created Service"


msg_info "Starting Services"
sed -i 's/user npm/user root/g; s/^pid/#pid/g' /usr/local/openresty/nginx/conf/nginx.conf
sed -i 's/include-system-site-packages = false/include-system-site-packages = true/g' /opt/certbot/pyvenv.cfg
systemctl enable --now openresty
systemctl enable --now npm
msg_ok "Started Services"

msg_info "Cleaning up"
rm -rf ../nginx-proxy-manager-* s6-overlay-noarch.tar.xz s6-overlay-x86_64.tar.xz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

nocodb() {
banlet nocodb 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y make
apt-get install -y g++
apt-get install -y gcc
msg_ok "Installed Dependencies"

msg_info "Installing Node.js"
bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
. ~/.bashrc
nvm install 16.20.1
ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
ln -sf /root/.nvm/versions/node/v16.20.1/bin/npm /usr/bin/npm
msg_ok "Installed Node.js"

msg_info "Installing NocoDB"
git clone https://github.com/nocodb/nocodb-seed
mv nocodb-seed /opt/nocodb
cd /opt/nocodb
npm install
msg_ok "Installed NocoDB"

msg_info "Creating Service"
service_path="/etc/systemd/system/nocodb.service"
echo "[Unit]
Description=nocodb

[Service]
Type=simple
Restart=always
User=root
WorkingDirectory=/opt/nocodb
ExecStart=/usr/bin/npm start

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now nocodb.service &>/dev/null
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

node-red() {
banlet node-red 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Node-Red"
npm install -g --unsafe-perm node-red
echo "journalctl -f -n 100 -u nodered -o cat" >/usr/bin/node-red-log
chmod +x /usr/bin/node-red-log
echo "systemctl stop nodered" >/usr/bin/node-red-stop
chmod +x /usr/bin/node-red-stop
echo "systemctl start nodered" >/usr/bin/node-red-start
chmod +x /usr/bin/node-red-start
echo "systemctl restart nodered" >/usr/bin/node-red-restart
chmod +x /usr/bin/node-red-restart
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed Node-Red"

msg_info "Creating Service"
service_path="/etc/systemd/system/nodered.service"
echo "[Unit]
Description=Node-RED
After=syslog.target network.target

[Service]
ExecStart=/usr/bin/node-red --max-old-space-size=128 -v
Restart=on-failure
KillSignal=SIGINT

SyslogIdentifier=node-red
StandardOutput=syslog

WorkingDirectory=/root/
User=root
Group=root

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now nodered.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

octoprint() {
banlet octoprint 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y libyaml-dev
apt-get install -y build-essential
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip \
  python3-venv

apt-get install -y python3-setuptools
msg_ok "Updated Python3"

msg_info "Creating user octoprint"
useradd -m -s /bin/bash -p $(openssl passwd -1 octoprint) octoprint
usermod -aG sudo,tty,dialout octoprint
chown -R octoprint:octoprint /opt
msg_ok "Created user octoprint"

msg_info "Installing OctoPrint"
sudo -u octoprint bash << EOF
mkdir /opt/octoprint
cd /opt/octoprint
python3 -m venv .
source bin/activate
pip install --upgrade pip
pip install wheel
pip install octoprint
EOF
msg_ok "Installed OctoPrint"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/octoprint.service
[Unit]
Description=The snappy web interface for your 3D printer
After=network-online.target
Wants=network-online.target

[Service]
Environment="LC_ALL=C.UTF-8"
Environment="LANG=C.UTF-8"
Type=exec
User=octoprint
ExecStart=/opt/octoprint/bin/octoprint serve

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now octoprint.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

omada() {
banlet omada 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
apt-get install -y jsvc
msg_ok "Installed Dependencies"

msg_info "Installing Azul Zulu"
wget -qO /etc/apt/trusted.gpg.d/zulu-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xB1998361219BD9C9"
wget -q https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
dpkg -i zulu-repo_1.0.0-3_all.deb
apt-get update
apt-get -y install zulu8-jdk
msg_ok "Installed Azul Zulu"

msg_info "Installing MongoDB"
wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
wget -qL https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.23_amd64.deb
dpkg -i mongodb-org-server_3.6.23_amd64.deb
msg_ok "Installed MongoDB"

latest_url=$(curl -fsSL "https://www.tp-link.com/us/support/download/omada-software-controller/" | grep -o 'https://.*x64.deb' | head -n1)
latest_version=$(basename "$latest_url" | sed -e 's/.*ller_//;s/_Li.*//')

msg_info "Installing Omada Controller ${latest_version}"
wget -qL ${latest_url}
dpkg -i Omada_SDN_Controller_${latest_version}_Linux_x64.deb
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed Omada Controller ${latest_version}"


msg_info "Cleaning up"
rm -rf Omada_SDN_Controller_${latest_version}_Linux_x64.deb mongodb-org-server_3.6.23_amd64.deb zulu-repo_1.0.0-3_all.deb libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

ombi() {
banlet ombi 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Ombi"
LATEST=$(curl -sL https://api.github.com/repos/Ombi-app/Ombi/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
# wget -q https://github.com/Ombi-app/Ombi/releases/download/${LATEST}/linux-x64.tar.gz

wget -q https://github.com/Ombi-app/Ombi/releases/download/v4.43.2/linux-x64.tar.gz
mkdir -p /opt/ombi
tar -xzf linux-x64.tar.gz -C /opt/ombi
msg_ok "Installed Ombi"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/ombi.service
[Unit]
Description=Ombi
After=syslog.target network-online.target

[Service]
ExecStart=/opt/ombi/./Ombi
WorkingDirectory=/opt/ombi
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now ombi.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

omv() {
banlet omv 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
msg_ok "Installed Dependencies"

msg_info "Installing OpenMediaVault (Patience)"
wget -qO- https://packages.openmediavault.org/public/archive.key | gpg --dearmor >"/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.gpg"

cat <<EOF >/etc/apt/sources.list.d/openmediavault.list
deb https://packages.openmediavault.org/public shaitan main
# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan main

## Uncomment the following line to add software from the proposed repository.

# deb https://packages.openmediavault.org/public shaitan-proposed main

# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan-proposed main

## This software is not part of OpenMediaVault, but is offered by third-party

## developers as a service to OpenMediaVault users.

# deb https://packages.openmediavault.org/public shaitan partner

# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan partner

EOF

export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none
apt-get update
apt-get -y --auto-remove --show-upgraded --allow-downgrades --allow-change-held-packages --no-install-recommends --option DPkg::Options::="--force-confdef" --option DPkg::Options::="--force-confold" install openmediavault-keyring openmediavault &>/dev/null
omv-confdbadm populate
msg_ok "Installed OpenMediaVault"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

openhab() {
banlet openhab 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
apt-get install -y apt-transport-https
msg_ok "Installed Dependencies"

msg_info "Installing Azul Zulu"
wget -qO /etc/apt/trusted.gpg.d/zulu-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xB1998361219BD9C9"
wget -q https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
dpkg -i zulu-repo_1.0.0-3_all.deb
apt-get update
apt-get -y install zulu11-jdk
msg_ok "Installed Azul Zulu"

msg_info "Installing openHAB"
curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor >openhab.gpg
mv openhab.gpg /usr/share/keyrings
chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg
echo "deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main" > /etc/apt/sources.list.d/openhab.list
apt update
apt-get -y install openhab
systemctl daemon-reload
systemctl enable -q --now openhab.service
msg_ok "Installed openHAB"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

openobserve() {
banlet openobserve 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing OpenObserve"
mkdir -p /opt/openobserve/data
LATEST=$(curl -sL https://api.github.com/repos/openobserve/openobserve/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
tar zxvf <(curl -fsSL https://github.com/openobserve/openobserve/releases/download/$LATEST/openobserve-${LATEST}-linux-amd64.tar.gz) -C /opt/openobserve

cat <<EOF >/opt/openobserve/data/.env
ZO_ROOT_USER_EMAIL = "admin@example.com"
ZO_ROOT_USER_PASSWORD = "$(openssl rand -base64 18 | cut -c1-13)"
ZO_DATA_DIR = "/opt/openobserve/data"
ZO_HTTP_PORT = "5080"
EOF
msg_ok "Installed OpenObserve"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/openobserve.service
[Unit]
Description=OpenObserve
After=network.target

[Service]
Type=simple
EnvironmentFile=/opt/openobserve/data/.env
ExecStart=/opt/openobserve/openobserve
ExecStop=killall -QUIT openobserve
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now openobserve
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

overseerr() {
banlet overseerr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
npm install -g yarn
msg_ok "Installed Yarn"

msg_info "Installing Overseerr (Patience)"
git clone -q https://github.com/sct/overseerr.git /opt/overseerr
cd /opt/overseerr
yarn install
yarn build
msg_ok "Installed Overseerr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/overseerr.service
[Unit]
Description=Overseerr Service
After=network.target

[Service]
Type=exec
WorkingDirectory=/opt/overseerr
ExecStart=/usr/bin/yarn start

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now overseerr.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

paperless-ngx() {
banlet paperless-ngx 

msg_info "Installing Python3"
apt-get install -y --no-install-recommends \
  python3 \
  python3-pip \
  python3-dev \
  python3-setuptools \
  python3-wheel
msg_ok "Installed Python3"

msg_info "Installing Dependencies (Patience)"
apt-get install -y --no-install-recommends \
  redis \
  postgresql \
  build-essential \
  imagemagick \
  fonts-liberation \
  optipng \
  gnupg \
  libpq-dev \
  libmagic-dev \
  mime-support \
  libzbar0 \
  poppler-utils \
  default-libmysqlclient-dev \
  automake \
  libtool \
  pkg-config \
  git \
  curl \
  libtiff-dev \
  libpng-dev \
  libleptonica-dev \
  sudo \
  mc
msg_ok "Installed Dependencies"

msg_info "Installing OCR Dependencies (Patience)"
apt-get install -y --no-install-recommends \
  unpaper \
  ghostscript \
  icc-profiles-free \
  qpdf \
  liblept5 \
  libxml2 \
  pngquant \
  zlib1g \
  tesseract-ocr \
  tesseract-ocr-eng
msg_ok "Installed OCR Dependencies"

msg_info "Installing JBIG2"
git clone https://github.com/agl/jbig2enc /opt/jbig2enc
cd /opt/jbig2enc
bash ./autogen.sh
bash ./configure
make
make install
rm -rf /opt/jbig2enc
msg_ok "Installed JBIG2"

msg_info "Installing Paperless-ngx (Patience)"
Paperlessngx=$(wget -q https://github.com/paperless-ngx/paperless-ngx/releases/latest -O - | grep "title>Release" | cut -d " " -f 5)
cd /opt
wget https://github.com/paperless-ngx/paperless-ngx/releases/download/$Paperlessngx/paperless-ngx-$Paperlessngx.tar.xz
tar -xf paperless-ngx-$Paperlessngx.tar.xz -C /opt/
mv paperless-ngx paperless
rm paperless-ngx-$Paperlessngx.tar.xz
cd /opt/paperless
sed -i 's/scipy==1.8.1/scipy==1.10.1/g' requirements.txt
## python 3.10+ doesn't like the '-e', so we remove it from this the requirements file

sed -i -e 's|-e git+https://github.com/paperless-ngx/django-q.git|git+https://github.com/paperless-ngx/django-q.git|' /opt/paperless/requirements.txt
pip install --upgrade pip
pip install -r requirements.txt
curl -s -o /opt/paperless/paperless.conf https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/paperless.conf.example
msg_ok "Installed Paperless-ngx"

msg_info "Installing Natural Language Toolkit (Patience)"
python3 -m nltk.downloader -d /usr/share/nltk_data all
msg_ok "Installed Natural Language Toolkit"

msg_info "Setting up database"
DB_USER=paperless
DB_PASS="$(openssl rand -base64 18 | cut -c1-13)"
DB_NAME=paperlessdb
sudo -u postgres psql -c "CREATE ROLE $DB_USER WITH LOGIN PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME WITH OWNER $DB_USER TEMPLATE template0;"
echo "Paperless-ngx Database User" >>~/paperless.creds
echo $DB_USER >>~/paperless.creds
echo "Paperless-ngx Database Password" >>~/paperless.creds
echo $DB_PASS >>~/paperless.creds
echo "Paperless-ngx Database Name" >>~/paperless.creds
echo $DB_NAME >>~/paperless.creds
mkdir -p {consume,media}
sed -i -e 's|#PAPERLESS_DBNAME=paperless|PAPERLESS_DBNAME=paperlessdb|' /opt/paperless/paperless.conf
sed -i -e "s|#PAPERLESS_DBPASS=paperless|PAPERLESS_DBPASS=$DB_PASS|" /opt/paperless/paperless.conf
SECRET_KEY="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)"
sed -i -e "s|#PAPERLESS_SECRET_KEY=change-me|PAPERLESS_SECRET_KEY=$SECRET_KEY|" /opt/paperless/paperless.conf
cd /opt/paperless/src
python3 manage.py migrate
msg_ok "Set up database"

msg_info "Setting up admin Paperless-ngx User & Password"
## From https://github.com/linuxserver/docker-paperless-ngx/blob/main/root/etc/cont-init.d/99-migrations

cat <<EOF | python3 /opt/paperless/src/manage.py shell
from django.contrib.auth import get_user_model
UserModel = get_user_model()
user = UserModel.objects.create_user('admin', password='$DB_PASS')
user.is_superuser = True
user.is_staff = True
user.save()
EOF
echo "" >>~/paperless.creds
echo "Paperless-ngx WebUI User" >>~/paperless.creds
echo admin >>~/paperless.creds
echo "Paperless-ngx WebUI Password" >>~/paperless.creds
echo $DB_PASS >>~/paperless.creds
msg_ok "Set up admin Paperless-ngx User & Password"

msg_info "Creating Services"
cat <<EOF >/etc/systemd/system/paperless-scheduler.service
[Unit]
Description=Paperless Celery beat
Requires=redis.service

[Service]
WorkingDirectory=/opt/paperless/src
ExecStart=celery --app paperless beat --loglevel INFO

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/systemd/system/paperless-task-queue.service
[Unit]
Description=Paperless Celery Workers
Requires=redis.service

[Service]
WorkingDirectory=/opt/paperless/src
ExecStart=celery --app paperless worker --loglevel INFO

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/systemd/system/paperless-consumer.service
[Unit]
Description=Paperless consumer
Requires=redis.service

[Service]
WorkingDirectory=/opt/paperless/src
ExecStart=python3 manage.py document_consumer

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/systemd/system/paperless-webserver.service
[Unit]
Description=Paperless webserver
After=network.target
Wants=network.target
Requires=redis.service

[Service]
WorkingDirectory=/opt/paperless/src
ExecStart=/usr/local/bin/gunicorn -c /opt/paperless/gunicorn.conf.py paperless.asgi:application

[Install]
WantedBy=multi-user.target
EOF

sed -i -e 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml

systemctl daemon-reload
systemctl enable --now paperless-consumer paperless-webserver paperless-scheduler paperless-task-queue.service
msg_ok "Created Services"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

photoprism() {
banlet photoprism 

msg_info "Installing Dependencies (Patience)"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gcc
apt-get install -y g++
apt-get install -y git
apt-get install -y gnupg
apt-get install -y make
apt-get install -y zip
apt-get install -y exiftool
apt-get install -y ffmpeg
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get -y install nodejs
msg_ok "Installed Node.js"

msg_info "Installing Golang"
set +o pipefail
RELEASE=$(curl -s https://go.dev/dl/ | grep -o "go.*\linux-amd64.tar.gz" | head -n 1)
wget -q https://golang.org/dl/$RELEASE
tar -xzf $RELEASE -C /usr/local
ln -s /usr/local/go/bin/go /usr/local/bin/go
msg_ok "Installed Golang"

msg_info "Installing Go Dependencies"
go install github.com/tianon/gosu@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/psampaz/go-mod-outdated@latest
go install github.com/dsoprea/go-exif/v3/command/exif-read-tool@latest
go install github.com/mikefarah/yq/v4@latest
go install github.com/kyoh86/richgo@latest
cp /root/go/bin/* /usr/local/go/bin/
cp /usr/local/go/bin/richgo /usr/local/bin/richgo
cp /usr/local/go/bin/gosu /usr/local/sbin/gosu
chown root:root /usr/local/sbin/gosu
chmod 755 /usr/local/sbin/gosu
msg_ok "Installed Go Dependencies"

msg_info "Installing Tensorflow"
if grep -q avx2 /proc/cpuinfo; then
  suffix="avx2-"
elif grep -q avx /proc/cpuinfo; then
  suffix="avx-"
else
  suffix="1"
fi
version=$(curl -s https://dl.photoprism.org/tensorflow/amd64/ | grep -o "libtensorflow-amd64-$suffix.*\\.tar.gz" | head -n 1)
wget -q https://dl.photoprism.org/tensorflow/amd64/$version
tar -C /usr/local -xzf $version
ldconfig
set -o pipefail
msg_ok "Installed Tensorflow"

msg_info "Cloning PhotoPrism"
mkdir -p /opt/photoprism/bin
mkdir -p /var/lib/photoprism/storage
git clone https://github.com/photoprism/photoprism.git
cd photoprism
git checkout release
msg_ok "Cloned PhotoPrism"

msg_info "Building PhotoPrism (Patience)"
make -B
./scripts/build.sh prod /opt/photoprism/bin/photoprism
cp -r assets/ /opt/photoprism/
msg_ok "Built PhotoPrism"

env_path="/var/lib/photoprism/.env"
echo " 
PHOTOPRISM_AUTH_MODE='password'
PHOTOPRISM_ADMIN_PASSWORD='changeme'
PHOTOPRISM_HTTP_HOST='0.0.0.0'
PHOTOPRISM_HTTP_PORT='2342'
PHOTOPRISM_SITE_CAPTION='https://tteck.github.io/Proxmox/'
PHOTOPRISM_STORAGE_PATH='/var/lib/photoprism/storage'
PHOTOPRISM_ORIGINALS_PATH='/var/lib/photoprism/photos/Originals'
PHOTOPRISM_IMPORT_PATH='/var/lib/photoprism/photos/Import'
" >$env_path

msg_info "Creating Service"
service_path="/etc/systemd/system/photoprism.service"

echo "[Unit]
Description=PhotoPrism service
After=network.target

[Service]
Type=forking
User=root
WorkingDirectory=/opt/photoprism
EnvironmentFile=/var/lib/photoprism/.env
ExecStart=/opt/photoprism/bin/photoprism up -d
ExecStop=/opt/photoprism/bin/photoprism down

[Install]
WantedBy=multi-user.target" >$service_path
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm -rf /var/{cache,log}/* \
  /photoprism \
  /$RELEASE \
  /$version
msg_ok "Cleaned"

msg_info "Starting PhotoPrism"
systemctl enable -q --now photoprism
msg_ok "Started PhotoPrism"
banlet zApps.sh
msg_ok "Cleaned"

msg_info "Starting PhotoPrism"
systemctl enable -q --now photoprism
msg_ok "Started PhotoPrism"
}

############################################################################################


###############################################################################################

pihole() {
banlet pihole 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y ufw
apt-get install -y ntp
msg_ok "Installed Dependencies"

msg_info "Installing Pi-hole"
mkdir -p /etc/pihole/
cat <<EOF >/etc/pihole/setupVars.conf
PIHOLE_INTERFACE=eth0
PIHOLE_DNS_1=8.8.8.8
PIHOLE_DNS_2=8.8.4.4
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
CACHE_SIZE=10000
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSMASQ_LISTENING=local
WEBPASSWORD=$(openssl rand -base64 48)
BLOCKING_ENABLED=true
EOF
# View script https://install.pi-hole.net

bash <(curl -fsSL https://install.pi-hole.net) --unattended
msg_ok "Installed Pi-hole"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

plex() {
banlet plex 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

if [[ "$CTTYPE" == "0" ]]; then
  msg_info "Setting Up Hardware Acceleration"
  apt-get -y install \
    va-driver-all \
    ocl-icd-libopencl1 
  if [[ ${PCT_OSVERSION} == "20.04" ]]; then 
  apt-get install -y beignet-opencl-icd
  else
  apt-get install -y intel-opencl-icd
  fi
  /bin/chgrp video /dev/dri
  /bin/chmod 755 /dev/dri
  /bin/chmod 660 /dev/dri/*
  msg_ok "Set Up Hardware Acceleration"
fi

msg_info "Setting Up Plex Media Server Repository"
wget -qO- https://downloads.plex.tv/plex-keys/PlexSign.key >/etc/apt/trusted.gpg.d/PlexSign.asc
echo "deb [arch=$(dpkg --print-architecture)] https://downloads.plex.tv/repo/deb/ public main" >/etc/apt/sources.list.d/plexmediaserver.list
msg_ok "Set Up Plex Media Server Repository"

msg_info "Installing Plex Media Server"
apt-get update
apt-get -o Dpkg::Options::="--force-confold" install -y plexmediaserver
msg_ok "Installed Plex Media Server"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

podman() {
banlet podman 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Podman"
apt-get -y install podman
systemctl enable --now podman.socket
echo -e 'unqualified-search-registries=["docker.io"]' >> /etc/containers/registries.conf
msg_ok "Installed Podman"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

podman-homeassistant() {
banlet podman-homeassistant 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Podman"
apt-get -y install podman
systemctl enable --now podman.socket
msg_ok "Installed Podman"

msg_info "Pulling Home Assistant Image"
podman pull docker.io/homeassistant/home-assistant:stable
msg_ok "Pulled Home Assistant Image"

msg_info "Installing Home Assistant"
podman volume create hass_config
podman run -d \
  --name homeassistant \
  --restart unless-stopped \
  -v /dev:/dev \
  -v hass_config:/config \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  --net=host \
  homeassistant/home-assistant:stable
podman generate systemd \
  --new --name homeassistant \
  >/etc/systemd/system/homeassistant.service
systemctl enable --now homeassistant
msg_ok "Installed Home Assistant"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

postgresql() {
banlet postgresql 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
msg_ok "Installed Dependencies"

msg_info "Setting up PostgreSQL Repository"
VERSION="$(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)"
echo "deb http://apt.postgresql.org/pub/repos/apt ${VERSION}-pgdg main" >/etc/apt/sources.list.d/pgdg.list
curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor --output /etc/apt/trusted.gpg.d/postgresql.gpg
msg_ok "Setup PostgreSQL Repository"

msg_info "Installing PostgreSQL"
apt-get update
apt-get install -y postgresql

cat <<EOF >/etc/postgresql/15/main/pg_hba.conf
# PostgreSQL Client Authentication Configuration File

local   all             postgres                                peer
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only

local   all             all                                     peer
# IPv4 local connections:

host    all             all             127.0.0.1/32            scram-sha-256
host    all             all             0.0.0.0/24              md5
# IPv6 local connections:

host    all             all             ::1/128                 scram-sha-256
host    all             all             0.0.0.0/0               md5
# Allow replication connections from localhost, by a user with the

# replication privilege.

local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256
EOF

cat <<EOF >/etc/postgresql/15/main/postgresql.conf
# -----------------------------

# PostgreSQL configuration file

# -----------------------------


#------------------------------------------------------------------------------

# FILE LOCATIONS

#------------------------------------------------------------------------------


data_directory = '/var/lib/postgresql/15/main'       
hba_file = '/etc/postgresql/15/main/pg_hba.conf'     
ident_file = '/etc/postgresql/15/main/pg_ident.conf'   
external_pid_file = '/var/run/postgresql/15-main.pid'                   

#------------------------------------------------------------------------------

# CONNECTIONS AND AUTHENTICATION

#------------------------------------------------------------------------------


# - Connection Settings -


listen_addresses = '*'                 
port = 5432                             
max_connections = 100                  
unix_socket_directories = '/var/run/postgresql' 

# - SSL -


ssl = on
ssl_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
ssl_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'

#------------------------------------------------------------------------------

# RESOURCE USAGE (except WAL)

#------------------------------------------------------------------------------


shared_buffers = 128MB                
dynamic_shared_memory_type = posix      

#------------------------------------------------------------------------------

# WRITE-AHEAD LOG

#------------------------------------------------------------------------------


max_wal_size = 1GB
min_wal_size = 80MB

#------------------------------------------------------------------------------

# REPORTING AND LOGGING

#------------------------------------------------------------------------------


# - What to Log -


log_line_prefix = '%m [%p] %q%u@%d '           
log_timezone = 'Etc/UTC'

#------------------------------------------------------------------------------

# PROCESS TITLE

#------------------------------------------------------------------------------


cluster_name = '15/main'                

#------------------------------------------------------------------------------

# CLIENT CONNECTION DEFAULTS

#------------------------------------------------------------------------------


# - Locale and Formatting -


datestyle = 'iso, mdy'
timezone = 'Etc/UTC'
lc_messages = 'C'                      
lc_monetary = 'C'                       
lc_numeric = 'C'                        
lc_time = 'C'                           
default_text_search_config = 'pg_catalog.english'

#------------------------------------------------------------------------------

# CONFIG FILE INCLUDES

#------------------------------------------------------------------------------


include_dir = 'conf.d'                  
EOF

sudo systemctl restart postgresql
msg_ok "Installed PostgreSQL"

read -r -p "Would you like to add Adminer? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
  msg_info "Installing Adminer"
  apt install -y adminer
  a2enconf adminer
  systemctl reload apache2
  msg_ok "Installed Adminer"
fi


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

prometheus() {
banlet prometheus 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Prometheus"
RELEASE=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v${RELEASE}/prometheus-${RELEASE}.linux-amd64.tar.gz
tar -xvf prometheus-${RELEASE}.linux-amd64.tar.gz
cd prometheus-${RELEASE}.linux-amd64
mv prometheus promtool /usr/local/bin/
mv consoles/ console_libraries/ /etc/prometheus/
mv prometheus.yml /etc/prometheus/prometheus.yml
msg_ok "Installed Prometheus"

msg_info "Creating Service"
service_path="/etc/systemd/system/prometheus.service"
echo "[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=root
Restart=always
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.listen-address=0.0.0.0:9090

[Install]
WantedBy=multi-user.target" >$service_path
sudo systemctl enable --now prometheus
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm -rf ../prometheus-${RELEASE}.linux-amd64 ../prometheus-${RELEASE}.linux-amd64.tar.gz
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

prowlarr() {
banlet prowlarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y sqlite3
msg_ok "Installed Dependencies"

msg_info "Installing Prowlarr"
mkdir -p /var/lib/prowlarr/
chmod 775 /var/lib/prowlarr/
wget --content-disposition 'https://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Prowlarr.master.*.tar.gz
mv Prowlarr /opt
chmod 775 /opt/Prowlarr
msg_ok "Installed Prowlarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/prowlarr.service
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target
[Service]
UMask=0002
Type=simple
ExecStart=/opt/Prowlarr/Prowlarr -nobrowser -data=/var/lib/prowlarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
systemctl -q daemon-reload
systemctl enable --now -q prowlarr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Prowlarr.master.*.tar.gz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

qbittorrent() {
banlet qbittorrent 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing qbittorrent-nox"
apt-get install -y qbittorrent-nox
msg_ok "qbittorrent-nox"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/qbittorrent-nox.service
[Unit]
Description=qBittorrent client
After=network.target
[Service]
ExecStart=/usr/bin/qbittorrent-nox --webui-port=8090
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now qbittorrent-nox
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

radarr() {
banlet radarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y sqlite3
msg_ok "Installed Dependencies"

msg_info "Installing Radarr"
mkdir -p /var/lib/radarr/
chmod 775 /var/lib/radarr/
wget --content-disposition 'https://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Radarr.master.*.tar.gz
mv Radarr /opt
chmod 775 /opt/Radarr
msg_ok "Installed Radarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/radarr.service
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
UMask=0002
Type=simple
ExecStart=/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
systemctl -q daemon-reload
systemctl enable --now -q radarr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Radarr.master.*.tar.gz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

rdtclient() {
banlet rdtclient 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y unzip
msg_ok "Installed Dependencies"

msg_info "Installing ASP.NET Core Runtime"
wget -q https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update
apt-get install -y dotnet-sdk-6.0
msg_ok "Installed ASP.NET Core Runtime"

msg_info "Installing rdtclient"
wget -q https://github.com/rogerfar/rdt-client/releases/latest/download/RealDebridClient.zip
unzip -qq RealDebridClient.zip -d /opt/rdtc
rm RealDebridClient.zip
cd /opt/rdtc
mkdir -p data/db/ data/downloads
sed -i 's#/data/db/#/opt/rdtc&#g' /opt/rdtc/appsettings.json
msg_ok "Installed rdtclient"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/rdtc.service
[Unit]
Description=RdtClient Service

[Service]
WorkingDirectory=/opt/rdtc
ExecStart=/usr/bin/dotnet RdtClient.Web.dll
SyslogIdentifier=RdtClient
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now rdtc
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

readarr() {
banlet readarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y sqlite3
msg_ok "Installed Dependencies"

msg_info "Installing Readarr"
mkdir -p /var/lib/readarr/
chmod 775 /var/lib/readarr/
wget --content-disposition 'https://readarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Readarr.develop.*.tar.gz
mv Readarr /opt
chmod 775 /opt/Readarr
msg_ok "Installed Readarr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/readarr.service
[Unit]
Description=Readarr Daemon
After=syslog.target network.target
[Service]
UMask=0002
Type=simple
ExecStart=/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
systemctl -q daemon-reload
systemctl enable --now -q readarr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Readarr.develop.*.tar.gz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

rtsptoweb() {
banlet rtsptoweb 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y git
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Golang"
wget https://golang.org/dl/go1.20.1.linux-amd64.tar.gz
tar -xzf go1.20.1.linux-amd64.tar.gz -C /usr/local
ln -s /usr/local/go/bin/go /usr/local/bin/go
rm -rf go1.20.1.linux-amd64.tar.gz
msg_ok "Installed Golang"

msg_info "Installing RTSPtoWeb"
git clone https://github.com/deepch/RTSPtoWeb /opt/rtsptoweb
cat <<EOF >>/opt/rtsptoweb/start
#!/bin/bash

cd /opt/rtsptoweb && GO111MODULE=on go run *.go
EOF
chmod +x /opt/rtsptoweb/start
msg_ok "Installed RTSPtoWeb"

msg_info "Creating Service"
service_path="/etc/systemd/system/rtsptoweb.service"
echo "[Unit]
Description=RTSP to Web Streaming Service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/opt/rtsptoweb/start

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable -q --now rtsptoweb
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

sabnzbd() {
banlet sabnzbd 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y par2
apt-get install -y p7zip-full
wget -q http://http.us.debian.org/debian/pool/non-free/u/unrar-nonfree/unrar_6.0.3-1+deb11u1_amd64.deb
dpkg -i unrar_6.0.3-1+deb11u1_amd64.deb
rm unrar_6.0.3-1+deb11u1_amd64.deb
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
apt-get install -y python3-setuptools
msg_ok "Updated Python3"

msg_info "Installing SABnzbd"
RELEASE=$(curl -s https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
tar zxvf <(curl -fsSL https://github.com/sabnzbd/sabnzbd/releases/download/$RELEASE/SABnzbd-${RELEASE}-src.tar.gz)
mv SABnzbd-${RELEASE} /opt/sabnzbd
cd /opt/sabnzbd
python3 -m pip install -r requirements.txt
msg_ok "Installed SABnzbd"

msg_info "Creating Service"
service_path="/etc/systemd/system/sabnzbd.service"
echo "[Unit]
Description=SABnzbd
After=network.target
[Service]
WorkingDirectory=/opt/sabnzbd
ExecStart=python3 SABnzbd.py -s 0.0.0.0:7777
Restart=always
User=root
[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now -q sabnzbd.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

scrypted() {
banlet scrypted 

msg_info "Installing Dependencies (Patience)"
apt-get -y install software-properties-common apt-utils
apt-get -y update
apt-get -y upgrade
apt-get install -y avahi-daemon
apt-get -y install \
    build-essential \
    gcc \
    gir1.2-gtk-3.0 \
    libcairo2-dev \
    libgirepository1.0-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libgif-dev \
    libopenjp2-7 \
    libpango1.0-dev \
    librsvg2-dev \
    pkg-config \
    curl \
    sudo \
    mc
msg_ok "Installed Dependencies"

if [[ "$CTTYPE" == "0" ]]; then
  msg_info "Setting Up Hardware Acceleration"
  apt-get -y install \
    va-driver-all \
    ocl-icd-libopencl1 \
    intel-opencl-icd

  /bin/chgrp video /dev/dri
  /bin/chmod 755 /dev/dri
  /bin/chmod 660 /dev/dri/*
  msg_ok "Set Up Hardware Acceleration"
fi
msg_info "Installing GStreamer (Patience)"
apt-get -y install \
    gstreamer1.0-tools \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    gstreamer1.0-alsa
msg_ok "Installed GStreamer"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Python3 Dependencies"
apt-get -y install \
    python3-gi \
    python3-gst-1.0 \
    python3-matplotlib \
    python3-numpy \
    python3-opencv \
    python3-pil \
    python3-setuptools \
    python3-skimage \
    python3-wheel
python3 -m pip install --upgrade pip
python3 -m pip install aiofiles debugpy typing_extensions typing
msg_ok "Installed Python3 Dependencies"

read -r -p "Would you like to add Coral Edge TPU support? <y/N> " prompt
if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
msg_info "Adding Coral Edge TPU Support"
wget -qO /etc/apt/trusted.gpg.d/coral-repo.asc "https://packages.cloud.google.com/apt/doc/apt-key.gpg"
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" >/etc/apt/sources.list.d/coral-edgetpu.list
apt-get -y update
apt-get -y install libedgetpu1-std
msg_ok "Coral Edge TPU Support Added"
fi

msg_info "Installing Scrypted"
sudo -u root npx -y scrypted@latest install-server
msg_ok "Installed Scrypted"

msg_info "Creating Service"
service_path="/etc/systemd/system/scrypted.service"
echo "[Unit]
Description=Scrypted service
After=network.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/bin/npx -y scrypted serve
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now scrypted.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

shinobi() {
banlet shinobi 

ubuntuversion=$(lsb_release -r | awk '{print $2}' | cut -d . -f1)
if [ "$ubuntuversion" = "18" ] || [ "$ubuntuversion" -le "18" ]; then
    apt install sudo wget -y
    sudo apt install -y software-properties-common
    sudo add-apt-repository universe -y
    apt update -y
    apt update --fix-missing -y
fi

msg_info "Installing Dependencies"
apt-get install -y curl sudo git mc
apt-get install -y make zip net-tools
apt-get install -y gcc g++ cmake
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing FFMPEG"
apt-get install -y ffmpeg
msg_ok "Installed FFMPEG"

msg_info "Clonning Shinobi"
cd /opt
git clone https://gitlab.com/Shinobi-Systems/Shinobi.git -b master Shinobi
cd Shinobi
gitVersionNumber=$(git rev-parse HEAD)
theDateRightNow=$(date)
touch version.json
chmod 777 version.json
echo '{"Product" : "'"Shinobi"'" , "Branch" : "'"master"'" , "Version" : "'"$gitVersionNumber"'" , "Date" : "'"$theDateRightNow"'" , "Repository" : "'"https://gitlab.com/Shinobi-Systems/Shinobi.git"'"}' > version.json
msg_ok "Cloned Shinobi"

msg_info "Installing Database"
sqlpass=""
echo "mariadb-server mariadb-server/root_password password $sqlpass" | debconf-set-selections
echo "mariadb-server mariadb-server/root_password_again password $sqlpass" | debconf-set-selections
apt-get install -y mariadb-server
service mysql start
sqluser="root"
mysql -e "source sql/user.sql" || true
mysql -e "source sql/framework.sql" || true
msg_ok "Installed Database"
cp conf.sample.json conf.json
cronKey=$(head -c 1024 < /dev/urandom | sha256sum | awk '{print substr($1,1,29)}')
sed -i -e 's/Shinobi/'"$cronKey"'/g' conf.json
cp super.sample.json super.json

msg_info "Installing Shinobi"
npm i npm -g
npm install --unsafe-perm
npm install pm2@latest -g
chmod -R 755 .
touch INSTALL/installed.txt
ln -s /opt/Shinobi/INSTALL/shinobi /usr/bin/shinobi
node /opt/Shinobi/tools/modifyConfiguration.js addToConfig="{\"cron\":{\"key\":\"$(head -c 64 < /dev/urandom | sha256sum | awk '{print substr($1,1,60)}')\"}}" &>/dev/null
pm2 start camera.js
pm2 start cron.js
pm2 startup
pm2 save
pm2 list
msg_ok "Installed Shinobi"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

sonarr() {
banlet sonarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg 
apt-get install -y ca-certificates
msg_ok "Installed Dependencies"

msg_info "Installing Sonarr"
wget -qO /etc/apt/trusted.gpg.d/sonarr-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2009837cbffd68f45bc180471f4f90de2a9b4bf8"
echo "deb https://apt.sonarr.tv/debian testing-main main" >/etc/apt/sources.list.d/sonarr.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" install -qqy sonarr &>/dev/null
msg_ok "Installed Sonarr"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

syncthing() {
banlet syncthing 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
msg_ok "Installed Dependencies"

msg_info "Installing Syncthing"
curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" > /etc/apt/sources.list.d/syncthing.list'
apt-get update
apt-get install -y syncthing
systemctl enable syncthing@root.service
systemctl start syncthing@root.service
sleep 5
sed -i "{s/127.0.0.1:8384/0.0.0.0:8384/g}" /root/.config/syncthing/config.xml
systemctl restart syncthing@root.service
msg_ok "Installed Syncthing"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

tautulli() {
banlet tautulli 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y pip
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Tautulli"
cd /opt
git clone https://github.com/Tautulli/Tautulli.git
python3 -m pip install -q -r /opt/Tautulli/requirements.txt
pip install pyopenssl
msg_ok "Installed Tautulli"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/tautulli.service
[Unit]
Description=Tautulli
After=syslog.target network.target

[Service]
WorkingDirectory=/opt/Tautulli/
Restart=on-failure
RestartSec=5
Type=simple
ExecStart=/usr/bin/python3 /opt/Tautulli/Tautulli.py
KillSignal=SIGINT
TimeoutStopSec=20
SyslogIdentifier=tautulli

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now tautulli
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

tdarr() {
banlet tdarr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

if [[ "$CTTYPE" == "0" ]]; then
  msg_info "Setting Up Hardware Acceleration"
  apt-get -y install \
    va-driver-all \
    ocl-icd-libopencl1 \
    intel-opencl-icd
    
  /bin/chgrp video /dev/dri
  /bin/chmod 755 /dev/dri
  /bin/chmod 660 /dev/dri/*
  msg_ok "Set Up Hardware Acceleration"
fi

msg_info "Installing Tdarr"
mkdir -p /opt/tdarr
cd /opt/tdarr
wget -q https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip
unzip Tdarr_Updater.zip
rm -rf Tdarr_Updater.zip
chmod +x Tdarr_Updater
./Tdarr_Updater &>/dev/null
msg_ok "Installed Tdarr"

msg_info "Creating Service"
service_path="/etc/systemd/system/tdarr-server.service"
echo "[Unit]
Description=Tdarr Server Daemon
After=network.target
# Enable if using ZFS, edit and enable if other FS mounting is required to access directory

#Requires=zfs-mount.service


[Service]
User=root
Group=root

Type=simple
WorkingDirectory=/opt/tdarr/Tdarr_Server
ExecStartPre=/opt/tdarr/Tdarr_Updater                  
ExecStart=/opt/tdarr/Tdarr_Server/Tdarr_Server
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target" >$service_path

service_path="/etc/systemd/system/tdarr-node.service"
echo "[Unit]
Description=Tdarr Node Daemon
After=network.target
Requires=tdarr-server.service

[Service]
User=root
Group=root

Type=simple
WorkingDirectory=/opt/tdarr/Tdarr_Node
ExecStart=/opt/tdarr/Tdarr_Node/Tdarr_Node
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now -q tdarr-server.service
systemctl enable --now -q tdarr-node.service
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Tdarr_Updater.zip
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

technitiumdns() {
banlet technitiumdns 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing ASP.NET Core Runtime"
wget -q https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -rf packages-microsoft-prod.deb
apt-get update
apt-get install -y aspnetcore-runtime-7.0
msg_ok "Installed ASP.NET Core Runtime"

msg_info "Installing Technitium DNS"
bash <(curl -fsSL https://download.technitium.com/dns/install.sh)
msg_ok "Installed Technitium DNS"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

transmission() {
banlet transmission 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"


msg_info "Installing Transmission"
apt-get install -y transmission-daemon
systemctl stop transmission-daemon
sed -i '{s/"rpc-whitelist-enabled": true/"rpc-whitelist-enabled": false/g; s/"rpc-host-whitelist-enabled": true,/"rpc-host-whitelist-enabled": false,/g}' /etc/transmission-daemon/settings.json
systemctl start transmission-daemon
msg_ok "Installed Transmission"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

trilium() {
banlet trilium 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

RELEASE=$(curl -s https://api.github.com/repos/zadam/trilium/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 3, length($2)-4) }')

msg_info "Installing Trilium"
wget -q https://github.com/zadam/trilium/releases/download/v$RELEASE/trilium-linux-x64-server-$RELEASE.tar.xz
tar -xvf trilium-linux-x64-server-$RELEASE.tar.xz
mv trilium-linux-x64-server /opt/trilium
msg_ok "Installed Trilium"

msg_info "Creating Service"
service_path="/etc/systemd/system/trilium.service"

echo "[Unit]
Description=Trilium Daemon
After=syslog.target network.target

[Service]
User=root
Type=simple
ExecStart=/opt/trilium/trilium
WorkingDirectory=/opt/trilium/
TimeoutStopSec=20
Restart=always

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now -q trilium
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
rm -rf /root/trilium-linux-x64-server-$RELEASE.tar.xz
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

ubuntu() {
banlet ubuntu 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

umbrel() {
banlet umbrel 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Umbrel (Patience)"
DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
mkdir -p $(dirname $DOCKER_CONFIG_PATH)
if [ "$ST" == "yes" ]; then
VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
cd /usr/local/bin
curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/$VER/fuse-overlayfs-x86_64
chmod 755 /usr/local/bin/fuse-overlayfs
cd ~
echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
else
echo -e '{\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
fi
bash <(curl -fsSL https://umbrel)
systemctl daemon-reload
systemctl enable --now umbrel-startup.service
msg_ok "Installed Umbrel"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

unifi() {
banlet unifi 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y apt-transport-https
msg_ok "Installed Dependencies"

if [[ "$PCT_OSVERSION" == "12" ]]; then
  echo -e "deb http://ftp.debian.org/debian bullseye main" >/etc/apt/sources.list.d/openjdk-11-jre-headless.list
  apt-get update
fi

msg_info "Installing OpenJDK"
apt-get install -y openjdk-11-jre-headless
apt-mark hold openjdk-11-*
msg_ok "Installed OpenJDK"

msg_info "Installing MongoDB"
wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
wget -qL https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.23_amd64.deb
dpkg -i mongodb-org-server_3.6.23_amd64.deb
msg_ok "Installed MongoDB"

msg_info "Installing UniFi Network Application"
wget -qO /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' >/etc/apt/sources.list.d/100-ubnt-unifi.list
apt-get update
apt-get install -y unifi
msg_ok "Installed UniFi Network Application"


msg_info "Cleaning up"
rm -rf mongodb-org-server_3.6.23_amd64.deb libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

uptimekuma() {
banlet uptimekuma 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
sudo apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Uptime Kuma"
git clone https://github.com/louislam/uptime-kuma.git
mv uptime-kuma /opt/uptime-kuma
cd /opt/uptime-kuma
npm run setup
msg_ok "Installed Uptime Kuma"

msg_info "Creating Service"
service_path="/etc/systemd/system/uptime-kuma.service"
echo "[Unit]
Description=uptime-kuma

[Service]
Type=simple
Restart=always
User=root
WorkingDirectory=/opt/uptime-kuma
ExecStart=/usr/bin/npm start

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now uptime-kuma.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

vaultwarden() {
banlet vaultwarden 

msg_info "Installing Dependencies"
apt-get update
apt-get -qqy install \
  git \
  build-essential \
  pkgconf \
  libssl-dev \
  libmariadb-dev-compat \
  libpq-dev \
  curl \
  sudo \
  argon2 \
  mc
msg_ok "Installed Dependencies"

WEBVAULT=$(curl -s https://api.github.com/repos/dani-garcia/bw_web_builds/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 2, length($2)-3) }')

VAULT=$(curl -s https://api.github.com/repos/dani-garcia/vaultwarden/releases/latest |
  grep "tag_name" |
  awk '{print substr($2, 2, length($2)-3) }')

msg_info "Installing Rust"
wget -qL https://sh.rustup.rs
bash index.html -y --profile minimal
echo 'export PATH=~/.cargo/bin:$PATH' >>~/.bashrc
export PATH=~/.cargo/bin:$PATH
rm index.html
msg_ok "Installed Rust"

msg_info "Building Vaultwarden ${VAULT} (Patience)"
git clone https://github.com/dani-garcia/vaultwarden
cd vaultwarden
cargo build --features "sqlite,mysql,postgresql" --release
msg_ok "Built Vaultwarden ${VAULT}"

addgroup --system vaultwarden
adduser --system --home /opt/vaultwarden --shell /usr/sbin/nologin --no-create-home --gecos 'vaultwarden' --ingroup vaultwarden --disabled-login --disabled-password vaultwarden
mkdir -p /opt/vaultwarden/bin
mkdir -p /opt/vaultwarden/data
cp target/release/vaultwarden /opt/vaultwarden/bin/

msg_info "Downloading Web-Vault ${WEBVAULT}"
curl -fsSLO https://github.com/dani-garcia/bw_web_builds/releases/download/$WEBVAULT/bw_web_$WEBVAULT.tar.gz
tar -xzf bw_web_$WEBVAULT.tar.gz -C /opt/vaultwarden/
msg_ok "Downloaded Web-Vault ${WEBVAULT}"

cat <<EOF >/opt/vaultwarden/.env
ADMIN_TOKEN=''
ROCKET_ADDRESS=0.0.0.0
DATA_FOLDER=/opt/vaultwarden/data
DATABASE_MAX_CONNS=10
WEB_VAULT_FOLDER=/opt/vaultwarden/web-vault
WEB_VAULT_ENABLED=true
EOF

msg_info "Creating Service"
chown -R vaultwarden:vaultwarden /opt/vaultwarden/
chown root:root /opt/vaultwarden/bin/vaultwarden
chmod +x /opt/vaultwarden/bin/vaultwarden
chown -R root:root /opt/vaultwarden/web-vault/
chmod +r /opt/vaultwarden/.env

service_path="/etc/systemd/system/vaultwarden.service"
echo "[Unit]
Description=Bitwarden Server (Powered by Vaultwarden)
Documentation=https://github.com/dani-garcia/vaultwarden
After=network.target
[Service]
User=vaultwarden
Group=vaultwarden
EnvironmentFile=-/opt/vaultwarden/.env
ExecStart=/opt/vaultwarden/bin/vaultwarden
LimitNOFILE=65535
LimitNPROC=4096
PrivateTmp=true
PrivateDevices=true
ProtectHome=true
ProtectSystem=strict
DevicePolicy=closed
ProtectControlGroups=yes
ProtectKernelModules=yes
ProtectKernelTunables=yes
RestrictNamespaces=yes
RestrictRealtime=yes
MemoryDenyWriteExecute=yes
LockPersonality=yes
WorkingDirectory=/opt/vaultwarden
ReadWriteDirectories=/opt/vaultwarden/data
AmbientCapabilities=CAP_NET_BIND_SERVICE
[Install]
WantedBy=multi-user.target" >$service_path
systemctl daemon-reload
systemctl enable --now vaultwarden.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

whisparr() {
banlet whisparr 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y sqlite3 
msg_ok "Installed Dependencies"

msg_info "Installing Whisparr"
mkdir -p /var/lib/whisparr/
chmod 775 /var/lib/whisparr/
wget --content-disposition 'https://whisparr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
tar -xvzf Whisparr.develop.*.tar.gz
mv Whisparr /opt
chmod 775 /opt/Whisparr
msg_ok "Installed Whisparr"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/whisparr.service
[Unit]
Description=whisparr Daemon
After=syslog.target network.target
[Service]
UMask=0002
Type=simple
ExecStart=/opt/Whisparr/Whisparr -nobrowser -data=/var/lib/whisparr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
systemctl -q daemon-reload
systemctl enable --now -q whisparr
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf Whisparr.develop.*.tar.gz
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

whoogle() {
banlet whoogle 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Updating Python3"
apt-get install -y \
  python3 \
  python3-dev \
  python3-pip
msg_ok "Updated Python3"

msg_info "Installing Whoogle"
pip install brotli
pip install whoogle-search

service_path="/etc/systemd/system/whoogle.service"
echo "[Unit]
Description=Whoogle-Search
After=network.target
[Service]
ExecStart=/usr/local/bin/whoogle-search --host 0.0.0.0
Restart=always
User=root
[Install]
WantedBy=multi-user.target" >$service_path

systemctl enable --now whoogle.service
msg_ok "Installed Whoogle"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

wikijs() {
banlet wikijs 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_16.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Installing Wiki.js"
mkdir -p /opt/wikijs
cd /opt/wikijs
wget https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz
tar xzf wiki-js.tar.gz
rm wiki-js.tar.gz

cat <<EOF >/opt/wikijs/config.yml
bindIP: 0.0.0.0
port: 3000
db:
  type: sqlite
  storage: /opt/wikijs/db.sqlite
logLevel: info
logFormat: default
dataPath: /opt/wikijs/data
bodyParserLimit: 5mb
EOF
npm rebuild sqlite3
msg_ok "Installed Wiki.js"

msg_info "Creating Service"
service_path="/etc/systemd/system/wikijs.service"

echo "[Unit]
Description=Wiki.js
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/node server
Restart=always
User=root
Environment=NODE_ENV=production
WorkingDirectory=/opt/wikijs

[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable --now wikijs
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

wireguard() {
banlet wireguard 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gunicorn
msg_ok "Installed Dependencies"

msg_info "Installing WireGuard (using pivpn.io)"
OPTIONS_PATH='/options.conf'
cat >$OPTIONS_PATH <<'EOF'
IPv4dev=eth0
install_user=root
VPN=wireguard
pivpnNET=10.6.0.0
subnetClass=24
ALLOWED_IPS="0.0.0.0/0, ::0/0"
pivpnMTU=1420
pivpnPORT=51820
pivpnDNS1=1.1.1.1
pivpnDNS2=8.8.8.8
pivpnHOST=
pivpnPERSISTENTKEEPALIVE=25
UNATTUPG=1
EOF
bash <(curl -fsSL https://install.pivpn.io) --unattended options.conf
msg_ok "Installed WireGuard"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

yunohost() {
banlet yunohost 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y gnupg
apt-get install -y apt-transport-https
apt-get install -y lsb-release
apt-get install -y ca-certificates
msg_ok "Installed Dependencies"

msg_info "Installing YunoHost (Patience)"
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
bash <(curl -fsSL https://install.yunohost.org) -a
msg_ok "Installed YunoHost"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

zigbee2mqtt() {
banlet zigbee2mqtt 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
apt-get install -y make
apt-get install -y g++
apt-get install -y gcc
msg_ok "Installed Dependencies"

msg_info "Setting up Node.js Repository"
bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
msg_ok "Set up Node.js Repository"

msg_info "Installing Node.js"
apt-get install -y nodejs
msg_ok "Installed Node.js"

msg_info "Setting up Zigbee2MQTT Repository"
git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
msg_ok "Set up Zigbee2MQTT Repository"

read -r -p "Switch to Edge/dev branch? (y/N) " prompt
if [[ $prompt == "y" ]]; then
  DEV="y"
else
  DEV="n"
fi

msg_info "Installing Zigbee2MQTT"
cd /opt/zigbee2mqtt
if [[ $DEV == "y" ]]; then
git checkout dev
fi
npm ci
echo "bash -c \"\$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/${app}.sh)\"" >/usr/bin/update
chmod +x /usr/bin/update
msg_ok "Installed Zigbee2MQTT"

msg_info "Creating Service"
service_path="/etc/systemd/system/zigbee2mqtt.service"
echo "[Unit]
Description=zigbee2mqtt
After=network.target
[Service]
Environment=NODE_ENV=production
ExecStart=/usr/bin/npm start
WorkingDirectory=/opt/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
Restart=always
User=root
[Install]
WantedBy=multi-user.target" >$service_path
systemctl enable zigbee2mqtt.service
msg_ok "Created Service"


msg_info "Cleaning up"
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

zoraxy() {
banlet zoraxy 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Installing Golang"
set +o pipefail
RELEASE=$(curl -s https://go.dev/dl/ | grep -o "go.*\linux-amd64.tar.gz" | head -n 1)
wget -q https://golang.org/dl/$RELEASE
tar -xzf $RELEASE -C /usr/local
ln -s /usr/local/go/bin/go /usr/local/bin/go
set -o pipefail
msg_ok "Installed Golang"

msg_info "Installing Zoraxy (Patience)"
git clone https://github.com/tobychui/zoraxy /opt/zoraxy
cd /opt/zoraxy/src
go mod tidy
go build
msg_ok "Installed Zoraxy"

msg_info "Creating Service"
cat <<EOF >/etc/systemd/system/zoraxy.service
[Unit]
Description=General purpose request proxy and forwarding tool
After=syslog.target network-online.target

[Service]
ExecStart=/opt/zoraxy/src/./zoraxy
WorkingDirectory=/opt/zoraxy/src/
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl enable -q --now zoraxy.service
msg_ok "Created Service"


msg_info "Cleaning up"
rm -rf $RELEASE
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################


###############################################################################################

zwave-js-ui() {
banlet zwave-js-ui 

msg_info "Installing Dependencies"
apt-get install -y curl
apt-get install -y sudo
apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Z-Wave JS UI"
mkdir /opt/zwave-js-ui
cd /opt/zwave-js-ui
RELEASE=$(curl -s https://api.github.com/repos/zwave-js/zwave-js-ui/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
wget https://github.com/zwave-js/zwave-js-ui/releases/download/${RELEASE}/zwave-js-ui-${RELEASE}-linux.zip
unzip zwave-js-ui-${RELEASE}-linux.zip
msg_ok "Installed Z-Wave JS UI"

msg_info "Creating Service"
service_path="/etc/systemd/system/zwave-js-ui.service"
echo "[Unit]
Description=zwave-js-ui
Wants=network-online.target
After=network-online.target
[Service]
User=root
WorkingDirectory=/opt/zwave-js-ui
ExecStart=/opt/zwave-js-ui/zwave-js-ui-linux
[Install]
WantedBy=multi-user.target" >$service_path
systemctl start zwave-js-ui
systemctl enable zwave-js-ui
msg_ok "Created Service"


msg_info "Cleaning up"
rm zwave-js-ui-${RELEASE}-linux.zip
apt-get autoremove
apt-get autoclean
msg_ok "Cleaned"
banlet zApps.sh
msg_ok "Cleaned"
}

############################################################################################

