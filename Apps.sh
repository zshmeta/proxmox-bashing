#!/bin/bash





APPS_PORT=(adguardPORT="3000" alpinegrafanaPORT="3000" alpinevaultwardenPORT="80" alpinezigbee2mqttPORT="8080" audiobookshelfPORT="80" autobrrPORT="3000" bazarrPORT="6767" blockyPORT="3000" casaosPORT="80" changedetectionPORT="80"  cloudflaredPORT="5053" croniclePORT="3012" daemonsyncPORT="80" dashyPORT="80" deconzPORT="80" delugePORT="8112" dockerPORT="2375" embyPORT="8096" emqxPORT="18083" esphomePORT="6052" fhemPORT="8083" go2rtcPORT="80" grafanaPORT="3000" grocyPORT="80" heimdalldashboardPORT="80" homeassistantcorePORT="8123" homeassistantPORT="8123" homebridgePORT="8581" homerPORT="8080" hyperionPORT="8090" influxdbPORT="8086" iobrokerPORT="8081" jackettPORT="9117" jellyfinPORT="8096" jellyseerrPORT="8181" k0sPORT="6443" kavitaPORT="80" keycloakPORT="8080" lidarrPORT="8686" magicmirrorPORT="8080" mariadbPORT="3306" meshcentralPORT="443" motioneyePORT="8765" mqttPORT="1883" n8nPORT="5678"    navidromePORT="4533"  nginxproxymanagerPORT="81"  nocodbPORT="8080" noderedPORT="1880" ombiPORT="3579" omvPORT="80" omadaPORT="8088" openhabPORT="800" openobservePORT="80" overseerrPORT="505"  paperlessngxPORT="8000" photoprismPORT="2342" piholePORT="80" plexPORT="32400" podmanhomeassistantPORT="8123"   podmanPORT="8123" postgresqlPORT="5432" prometheusPORT="9090" prowlarrPORT="9696" qbittorrentPORT="8080" radarrPORT="7878" rdtclientPORT="3389" radarrPORT="8787" rtsptowebPORT="8080" sabnzbdPORT="8080" scryptedPORT="9443" shinobiPORT="8080" sonarrPORT="8989" syncthingPORT="8384" tautulliPORT="8181" tdarrPORT="8265" technitiumdnsPORT="5380"  transmissionPORT="9091" triliumPORT="8080" ubuntuPORT="80" umbrelPORT="80" unifiPORT="8443" uptimekumaPORT="3000" vaultwardenPORT="80" whisparrPORT="9696" whooglePORT="5000" wikijsPORT="3000" wireguardPORT="51820" yunohostPORT="80" zigbee2mqttPORT="8080" zwavePORT="8091" penpotPORT="9001" nextcloudpiPORT="4443" coolifyPORT="8000")

 echo "${APPS_PORT[@]}" 

########################################################################################################################
#############################################################################################################################################################

adguard () {    


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port"

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ___       __                           __
          /   | ____/ /___ ___  ______ __________/ /
         / /| |/ __  / __  / / / / __  / ___/ __  /
        / ___ / /_/ / /_/ / /_/ / /_/ / /  / /_/ /
       /_/  |_\__,_/\__, /\__,_/\__,_/_/   \__,_/
                   /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing AdGuard Home"
      tar zxvf <(curl -fsSL https://static.adtidy.org/adguardhome/release/AdGuardHome_linux_amd64.tar.gz) -C /opt
      echo "Installed AdGuard Home"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ___       __                           __
          /   | ____/ /___ ___  ______ __________/ /
         / /| |/ __  / __  / / / / __  / ___/ __  /
        / ___ / /_/ / /_/ / /_/ / /_/ / /  / /_/ /
       /_/  |_\__,_/\__, /\__,_/\__,_/_/   \__,_/
                   /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      echo -e "${APP} Setup should be reachable by going to the following URL.
      ${BL}http://${IP}:3000${CL} \n"
}

#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
alpinedocker () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="alpine"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____             __
           / __ \____  _____/ /_  __  _____
          / / / / __ \/ ___/ //_/ _ \/ ___/
         / /_/ / /_/ / /__/ ,< /  __/ /
        /_____/\____/\___/_/|_|\___/_/
         Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
    
      apk add newt
      apk add curl
      apk add openssh
      apk add nano
      apk add mc
    
    

      get_latest_release() {
        curl -sL https://api.github.com/repos/"$1"/releases/latest | grep '"tag_name":' | cut -d'"' -f4
      }
      DOCKER_COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")
    
      read -r -p "Would you like to add Portainer? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
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
      fi
    
      read -r -p "Would you like to add Docker Compose? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
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
         Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    
    
    


#############################################################################################################################################################

########################################################################################################################
alpinegrafana () {


      DISK_SIZE="0"
      msg_info "Suggested Disk: 0.$DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="256"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="alpine"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______           ____
          / ____/________ _/ __/___ _____  ____ _
         / / __/ ___/ __  / /_/ __  / __ \/ __  /
        / /_/ / /  / /_/ / __/ /_/ / / / / /_/ /
        \____/_/   \__,_/_/  \__,_/_/ /_/\__,_/
         Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apk add newt
      apk add curl
      apk add openssh
      apk add nano
      apk add mc
      echo "Installed Dependencies"
    
      echo "Installing Grafana"
      apk add grafana
      sed -i '/http_addr/s/127.0.0.1/0.0.0.0/g' /etc/conf.d/grafana
      rc-service grafana start
      rc-update add grafana default
      echo "Installed Grafana"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______           ____
          / ____/________ _/ __/___ _____  ____ _
         / / __/ ___/ __  / /_/ __  / __ \/ __  /
        / /_/ / /  / /_/ / __/ /_/ / / / / /_/ /
        \____/_/   \__,_/_/  \__,_/_/ /_/\__,_/
         Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:3000${CL} or ${BL}http://${HOSTNAME}:3000${CL}"
}
#####################################################################################################################################################
#####################################################################################################################################################
    


alpinevaultwarden () {


      DISK_SIZE="0"
      msg_info "Suggested Disk: 0.$DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="256"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="alpine"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
          _    __            ____                          __
        | |  / /___ ___  __/ / /__      ______ __________/ /__  ____
        | | / / __ / / / / / __/ | /| / / __ / ___/ __  / _ \/ __ \
        | |/ / /_/ / /_/ / / /_ | |/ |/ / /_/ / /  / /_/ /  __/ / / /
        |___/\__,_/\__,_/_/\__/ |__/|__/\__,_/_/   \__,_/\___/_/ /_/
         Alpine
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apk add newt
      apk add curl
      apk add openssl
      apk add openssh
      apk add nano
      apk add mc
      apk add argon2
      echo "Installed Dependencies"
    
      echo "Installing Alpine-Vaultwarden"
      apk add vaultwarden
      sed -i -e 's/# export ADMIN_TOKEN=.*/export ADMIN_TOKEN='\'''\''/' -e '/^# export ROCKET_ADDRESS=0\.0\.0\.0/s/^# //' -e 's|export WEB_VAULT_ENABLED=.*|export WEB_VAULT_ENABLED=true|' /etc/conf.d/vaultwarden
      echo "Installed Alpine-Vaultwarden"
    
      echo "Installing Web-Vault"
      apk add vaultwarden-web-vault
      echo "Installed Web-Vault"
    
      echo "Starting Alpine-Vaultwarden"
      rc-service vaultwarden start
      rc-update add vaultwarden default
      echo "Started Alpine-Vaultwarden"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
          _    __            ____                          __
        | |  / /___ ___  __/ / /__      ______ __________/ /__  ____
        | | / / __ / / / / / __/ | /| / / __ / ___/ __  / _ \/ __ \
        | |/ / /_/ / /_/ / / /_ | |/ |/ / /_/ / /  / /_/ /  __/ / / /
        |___/\__,_/\__,_/_/\__/ |__/|__/\__,_/_/   \__,_/\___/_/ /_/
         Alpine
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
alpinezigbee2mqtt () {


      DISK_SIZE="0"
      msg_info "Suggested Disk: 0.$DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="256"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="alpine"
      msg_warn "This app is meant to run on $OS_TYPE"    
        echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" figlet -t -
      c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
          _____   _       __             ___   __  _______  ____________
        /__  /  (_)___ _/ /_  ___  ___ |__ \ /  |/  / __ \/_  __/_  __/
          / /  / / __  / __ \/ _ \/ _ \__/ // /|_/ / / / / / /   / /
         / /__/ / /_/ / /_/ /  __/  __/ __// /  / / /_/ / / /   / /
        /____/_/\__, /_.___/\___/\___/____/_/  /_/\___\_\/_/   /_/
               /____/ Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apk add newt
      apk add curl
      apk add openssh
      apk add nano
      apk add mc
      echo "Installed Dependencies"
    
      echo "Installing Alpine-Zigbee2MQTT"
      apk add zigbee2mqtt
      echo "Installed Alpine-Zigbee2MQTT"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
          _____   _       __             ___   __  _______  ____________
        /__  /  (_)___ _/ /_  ___  ___ |__ \ /  |/  / __ \/_  __/_  __/
          / /  / / __  / __ \/ _ \/ _ \__/ // /|_/ / / / / / /   / /
         / /__/ / /_/ / /_/ /  __/  __/ __// /  / / /_/ / / /   / /
        /____/_/\__, /_.___/\___/\___/____/_/  /_/\___\_\/_/   /_/
               /____/ Alpine
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################

    


#############################################################################################################################################################

########################################################################################################################
audiobookshelf () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

    
      figlet -t -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                            ___       __                __        __         ______
          ____ ___  ______/ (_)___  / /_  ____  ____  / /_______/ /_  ___  / / __/
         / __ / / / / __  / / __ \/ __ \/ __ \/ __ \/ //_/ ___/ __ \/ _ \/ / /_
        / /_/ / /_/ / /_/ / / /_/ / /_/ / /_/ / /_/ / ,< (__  ) / / /  __/ / __/
        \__,_/\__,_/\__,_/_/\____/_.___/\____/\____/_/|_/____/_/ /_/\___/_/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y gnupg
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing audiobookshelf"
      curl -fsSL https://advplyr.github.io/audiobookshelf-ppa/KEY.gpg >/etc/apt/trusted.gpg.d/audiobookshelf-ppa.asc
      echo "deb [signed-by=/etc/apt/trusted.gpg.d/audiobookshelf-ppa.asc] https://advplyr.github.io/audiobookshelf-ppa ./" >/etc/apt/sources.list.d/audiobookshelf.list
      apt-get update
      apt install audiobookshelf
      echo "Installed audiobookshelf"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                            ___       __                __        __         ______
          ____ ___  ______/ (_)___  / /_  ____  ____  / /_______/ /_  ___  / / __/
         / __ / / / / __  / / __ \/ __ \/ __ \/ __ \/ //_/ ___/ __ \/ _ \/ / /_
        / /_/ / /_/ / /_/ / / /_/ / /_/ / /_/ / /_/ / ,< (__  ) / / /  __/ / __/
        \__,_/\__,_/\__,_/_/\____/_.___/\____/\____/_/|_/____/_/ /_/\___/_/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
autobrr () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ___         __        __
           /   | __  __/ /_____  / /_  __________
          / /| |/ / / / __/ __ \/ __ \/ ___/ ___/
         / ___ / /_/ / /_/ /_/ / /_/ / /  / /
        /_/  |_\__,_/\__/\____/_.___/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Autobrr"
      wget -q "$(curl -s https://api.github.com/repos/autobrr/autobrr/releases/latest | grep download | grep linux_x86_64 | cut -d\" -f4)"
      tar -C /usr/local/bin -xzf autobrr*.tar.gz
        rm -rf autobrr*.tar.gz
        mkdir -p /root/.config/autobrr
      cat <<-EOF >/root/.config/autobrr/config.toml
      # https://autobrr.com/configuration/autobrr
      host = "0.0.0.0"
      port = 7474
      logLevel = "DEBUG"
      sessionSecret = "$(openssl rand -base64 24)"
EOF
      echo "Installed Autobrr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ___         __        __
           /   | __  __/ /_____  / /_  __________
          / /| |/ / / / __/ __ \/ __ \/ ___/ ___/
         / ___ / /_/ / /_/ /_/ / /_/ / /  / /
        /_/  |_\__,_/\__/\____/_.___/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


########################################################################################################################
blocky () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____  __           __
           / __ )/ /___  _____/ /____  __
          / __  / / __ \/ ___/ //_/ / / /
         / /_/ / / /_/ / /__/ ,< / /_/ /
        /_____/_/\____/\___/_/|_|\__, /
                                /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Blocky"
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
      echo "Installed Blocky"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____  __           __
           / __ )/ /___  _____/ /____  __
          / __  / / __ \/ ___/ //_/ / / /
         / /_/ / / /_/ / /__/ ,< / /_/ /
        /_____/_/\____/\___/_/|_|\__, /
                                /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
casaos () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______                 ____  _____
          / ____/___ __________ _/ __ \/ ___/
         / /   / __ / ___/ __ / / / /\__ \
        / /___/ /_/ (__  ) /_/ / /_/ /___/ /
        \____/\__,_/____/\__,_/\____//____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing CasaOS (Patience)"
      DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
      mkdir -p "$(dirname $DOCKER_CONFIG_PATH)"
      if [ "$ST" == "yes" ]; then
        VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
        cd /usr/local/bin
        curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/"$VER"/fuse-overlayfs-x86_64
        chmod 755 /usr/local/bin/fuse-overlayfs
        cd ~
        echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
      else
        echo -e '{\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
      fi
      bash <(curl -fsSL https://get.casaos.io)
      echo "Installed CasaOS"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______                 ____  _____
          / ____/___ __________ _/ __ \/ ___/
         / /   / __ / ___/ __ / / / /\__ \
        / /___/ /_/ (__  ) /_/ / /_/ /___/ /
        \____/\__,_/____/\__,_/\____//____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
changedetection () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ________                              ____       __            __  _
          / ____/ /_  ____ _____  ____ ____     / __ \___  / /____  _____/ /_(_)___  ____
         / /   / __ \/ __ / __ \/ __ / _ \   / / / / _ \/ __/ _ \/ ___/ __/ / __ \/ __ \
        / /___/ / / / /_/ / / / / /_/ /  __/  / /_/ /  __/ /_/  __/ /__/ /_/ / /_/ / / / /
        \____/_/ /_/\__,_/_/ /_/\__, /\___/  /_____/\___/\__/\___/\___/\__/_/\____/_/ /_/
                               /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ________                              ____       __            __  _
          / ____/ /_  ____ _____  ____ ____     / __ \___  / /____  _____/ /_(_)___  ____
         / /   / __ \/ __ / __ \/ __ / _ \   / / / / _ \/ __/ _ \/ ___/ __/ / __ \/ __ \
        / /___/ / / / /_/ / / / / /_/ /  __/  / /_/ /  __/ /_/  __/ /__/ /_/ / /_/ / / / /
        \____/_/ /_/\__,_/_/ /_/\__, /\___/  /_____/\___/\__/\___/\___/\__/_/\____/_/ /_/
                               /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    
coolify() {
      
      
        VERSION="1.0.0"
      DOCKER_VERSION="23.0"
      
      CDN="https://cdn.coollabs.io/coolify"
      OS_TYPE=$(grep -w "ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
      OS_VERSION=$(grep -w "VERSION_ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
      LATEST_VERSION=$(curl --silent $CDN/versions.json | grep -i version | sed -n '2p' | xargs | awk '{print $2}' | tr -d ',')
      DATE=$(date +"%Y%m%d-%H%M%S")
      
      if [ $EUID != 0 ]; then
          echo "Please run as root"
          exit
      fi
      if [ "$OS_TYPE" != "ubuntu" ] && [ "$OS_TYPE" != "debian" ]; then
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
            
      # Check if /etc/docker/daemon.json exists and is not empty
      if [ -s /etc/docker/daemon.json ]; then
          cp /etc/docker/daemon.json /etc/docker/daemon.json.original-"$DATE"
      else
          # Using sed to extract content between the markers, remove the leading hashtags and spaces/tabs, then write to /etc/docker/daemon.json
          sed -n '/#BEGINJSON/,/#ENDJSON/p' "$0" | sed 's/^#[ \t]*//' > /etc/docker/daemon.json
      fi
      
      # ... rest of your script ...
      
      #BEGINJSON
      #{
      #  "live-restore": true,
      #  "log-driver": "json-file",
      #  "log-opts": {
      #    "max-size": "10m",
      #    "max-file": "3"
      #  }
      #}
      #ENDJSON
      # Using sed to extract content between the markers, remove the leading hashtags and spaces/tabs, then write to /etc/docker/daemon.json.coolify
      sed -n '/#BEGINCOOLIFYJSON/,/#ENDCOOLIFYJSON/p' "$0" | sed 's/^#[ \t]*//' > /etc/docker/daemon.json.coolify
      
      # ... rest of your script ...
      
      #BEGINCOOLIFYJSON
      #{
      #  "live-restore": true,
      #  "log-driver": "json-file",
      #  "log-opts": {
      #    "max-size": "10m",
      #    "max-file": "3"
      #  }
      #}
      #ENDCOOLIFYJSON
      
      jq . /etc/docker/daemon.json.coolify > /tmp/daemon_coolify_temp.json
      mv /tmp/daemon_coolify_temp.json /etc/docker/daemon.json.coolify
      
      jq -s '.[0] * .[1]' /etc/docker/daemon.json /etc/docker/daemon.json.coolify > /tmp/daemon_merged_temp.json
      mv /tmp/daemon_merged_temp.json /etc/docker/daemon.json
      DIFF=$(diff <(jq --sort-keys . /etc/docker/daemon.json) <(jq --sort-keys . /etc/docker/daemon.json.original-"$DATE"))
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
      
      if
        ! grep -qw "root@coolify" ~/.ssh/authorized_keys; then
        addSshKey
      fi
      
      bash /data/coolify/source/upgrade.sh "${LATEST_VERSION:-latest}"
      
      echo -e "\nCongratulations! Your Coolify instance is ready to use.\n"
      echo "Please visit http://$(curl -4s https://ifconfig.io):8000 to get started."
      
}

#############################################################################################################################################################

########################################################################################################################
cloudflared () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ________                ________                    __
          / ____/ /___  __  ______/ / __/ /___ _________  ____/ /
         / /   / / __ \/ / / / __  / /_/ / __ / ___/ _ \/ __  /
        / /___/ / /_/ / /_/ / /_/ / __/ / /_/ / /  /  __/ /_/ /
        \____/_/\____/\__,_/\__,_/_/ /_/\__,_/_/   \___/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Cloudflared"
      mkdir  --mode=0755 /usr/share/keyrings
      curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg >/usr/share/keyrings/cloudflare-main.gpg
      echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $VERSION main" >/etc/apt/sources.list.d/cloudflared.list
      apt-get update
      apt-get install -y cloudflared
      echo "Installed Cloudflared"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ________                ________                    __
          / ____/ /___  __  ______/ / __/ /___ _________  ____/ /
         / /   / / __ \/ / / / __  / /_/ / __ / ___/ _ \/ __  /
        / /___/ / /_/ / /_/ / /_/ / __/ / /_/ / /  /  __/ /_/ /
        \____/_/\____/\__,_/\__,_/_/ /_/\__,_/_/   \___/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat

      msg_info "Please run the following command to configure Cloudflared:"
      msg_info "cloudflared tunnel login"
}
#####################################################################################################################################################
    
    
bazarr() {
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____
           / __ )____ _____  ____ ___________
          / __  / __ /_  / / __ / ___/ ___/
         / /_/ / /_/ / / /_/ /_/ / /  / /
        /_____/\__,_/ /___/\__,_/_/  /_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
          python3 \
          python3-dev \
          python3-pip
      echo "Updated Python3"
    
      echo "Installing Bazarr"
      mkdir -p /var/lib/bazarr/
      wget -q https://github.com/morpheus65535/bazarr/releases/latest/download/bazarr.zip
      unzip -qq bazarr -d /opt/bazarr
      chmod 775 /opt/bazarr /var/lib/bazarr/
      python3 -m pip install -q -r /opt/bazarr/requirements.txt
      echo "Installed Bazarr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____
           / __ )____ _____  ____ ___________
    
          / __  / __ /_  / / __ / ___/ ___/
      Wesh Alors Prod - zshmeta' | lolcat
    
}
#####################################################################################################################################################

#############################################################################################################################################################

########################################################################################################################
cronicle () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

    
      figlet -t -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______                 _      __
          / ____/________  ____  (_)____/ /__
         / /   / ___/ __ \/ __ \/ / ___/ / _ \
        / /___/ /  / /_/ / / / / / /__/ /  __/
        \____/_/   \____/_/ /_/_/\___/_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      apt-get install -y make
      apt-get install -y g++
      apt-get install -y gcc
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______                 _      __
          / ____/________  ____  (_)____/ /__
         / /   / ___/ __ \/ __ \/ / ___/ / _ \
        / /___/ /  / /_/ / / / / / /__/ /  __/
        \____/_/   \____/_/ /_/_/\___/_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
daemonsync () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____                                      _____
           / __ \____ ____  ____ ___  ____  ____     / ___/__  ______  _____
          / / / / __  / _ \/ __  __ \/ __ \/ __ \    \__ \/ / / / __ \/ ___/
         / /_/ / /_/ /  __/ / / / / / /_/ / / / /   ___/ / /_/ / / / / /__
        /_____/\__,_/\___/_/ /_/ /_/\____/_/ /_/   /____/\__, /_/ /_/\___/
                                                        /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y g++-multilib
      echo "Installed Dependencies"
    
      echo "Installing Daemon Sync Server"
      wget -qL https://github.com/tteck/Proxmox/raw/main/misc/daemonsync_2.2.0.0059_amd64.deb
      dpkg -i daemonsync_2.2.0.0059_amd64.deb
      echo "Installed Daemon Sync Server"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____                                      _____
           / __ \____ ____  ____ ___  ____  ____     / ___/__  ______  _____
          / / / / __  / _ \/ __  __ \/ __ \/ __ \    \__ \/ / / / __ \/ ___/
         / /_/ / /_/ /  __/ / / / / / /_/ / / / /   ___/ / /_/ / / / / /__
        /_____/\__,_/\___/_/ /_/ /_/\____/_/ /_/   /____/\__, /_/ /_/\___/
                                                        /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
dashy () {


      DISK_SIZE="6"
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
           / __ \____ ______/ /_  __  __
          / / / / __  / ___/ __ \/ / / /
         / /_/ / /_/ (__  ) / / / /_/ /
        /_____/\__,_/____/_/ /_/\__, /
                               /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Installing Node.js (Patience)"
      apt-get install -y npm
      npm cache clean -f
      npm install -g n
      n 16.20.1
      npm install -g pnpm
      ln -sf /usr/local/bin/node /usr/bin/node
      echo "Installed Node.js"
    
      echo "Installing Yarn"
      npm install --global yarn
      ln -sf /usr/local/bin/yarn /usr/bin/yarn
      echo "Installed Yarn"
    
      echo "Installing Dashy (Patience)"
      git clone https://github.com/Lissy93/dashy.git
      cd /dashy
      yarn
      export NODE_OPTIONS=--max-old-space-size=1000
      yarn build
      echo "Installed Dashy"
    
      echo "Creating Service"
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
      systemctl enable dashy
      systemctl start dashy
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____             __
           / __ \____ ______/ /_  __  __
          / / / / __  / ___/ __ \/ / / /
         / /_/ / /_/ (__  ) / / / /_/ /
        /_____/\__,_/____/_/ /_/\__, /
                               /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################



#############################################################################################################################################################

########################################################################################################################
deconz () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                __     __________  _   _______
          ____/ /__  / ____/ __ \/ | / /__  /
         / __  / _ \/ /   / / / /  |/ /  / /
        / /_/ /  __/ /___/ /_/ / /|  /  / /__
        \__,_/\___/\____/\____/_/ |_/  /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Setting Phoscon Repository"
      curl -fsSL http://phoscon.de/apt/deconz.pub.key >/etc/apt/trusted.gpg.d/deconz.pub.asc
      echo "deb [arch=amd64] http://phoscon.de/apt/deconz $VERSION main" >/etc/apt/sources.list.d/deconz.list
      echo "Setup Phoscon Repository"
    
      echo "Installing deConz"
      wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      apt-get update
      apt-get install -y deconz
      echo "Installed deConz"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                __     __________  _   _______
          ____/ /__  / ____/ __ \/ | / /__  /
         / __  / _ \/ /   / / / /  |/ /  / /
        / /_/ /  __/ /___/ /_/ / /|  /  / /__
        \__,_/\___/\____/\____/_/ |_/  /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
deluge () {


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
    
             ____       __
           / __ \___  / /_  ______ ____
          / / / / _ \/ / / / / __ / _ \
         / /_/ /  __/ / /_/ / /_/ /  __/
        /_____/\___/_/\__,_/\__, /\___/
                           /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
          python3 \
          python3-dev \
          python3-pip
      echo "Updated Python3"
    
      echo "Installing Deluge"
      pip install deluge\[all\]
      pip install lbry-libtorrent
      echo "Installed Deluge"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ____       __
           / __ \___  / /_  ______ ____
          / / / / _ \/ / / / / __ / _ \
         / /_/ /  __/ / /_/ / /_/ /  __/
        /_____/\___/_/\__,_/\__, /\___/
                           /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
docker () {


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
}
#####################################################################################################################################################



########################################################################################################################
emby () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="ubuntu"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ______          __
           / ____/___ ___  / /_  __  __
          / __/ / __  __ \/ __ \/ / / /
         / /___/ / / / / / /_/ / /_/ /
        /_____/_/ /_/ /_/_.___/\__, /
                              /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      if [[ "$CTTYPE" == "0" ]]; then
        echo "Setting Up Hardware Acceleration"
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
        echo "Set Up Hardware Acceleration"
      fi
    
      LATEST=$(curl -sL https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
    
      echo "Installing Emby"
      wget -q https://github.com/MediaBrowser/Emby.Releases/releases/download/"${LATEST}"/emby-server-deb_"${LATEST}"_amd64.deb
      dpkg -i emby-server-deb_"${LATEST}"_amd64.deb
      echo "Installed Emby"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ______          __
           / ____/___ ___  / /_  __  __
          / __/ / __  __ \/ __ \/ / / /
         / /___/ / / / / / /_/ / /_/ /
        /_____/_/ /_/ /_/_.___/\__, /
                              /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


########################################################################################################################
emqx () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ________  _______   _  __
           / ____/  |/  / __ \ | |/ /
          / __/ / /|_/ / / / / |   /
         / /___/ /  / / /_/ / /   |
        /_____/_/  /_/\___\_\/_/|_|
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing EMQX"
      bash <(curl -fsSL https://packagecloud.io/install/repositories/emqx/emqx/script.deb.sh)
      apt-get install -y emqx
      systemctl enable --now emqx
      echo "Installed EMQX"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ________  _______   _  __
           / ____/  |/  / __ \ | |/ /
          / __/ / /|_/ / / / / |   /
         / /___/ /  / / /_/ / /   |
        /_____/_/  /_/\___\_\/_/|_|
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
esphome () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ___________ ____  __  __
           / ____/ ___// __ \/ / / /___  ____ ___  ___
          / __/  \__ \/ /_/ / /_/ / __ \/ __ __ \/ _ \
         / /___ ___/ / ____/ __  / /_/ / / / / / /  __/
        /_____//____/_/   /_/ /_/\____/_/ /_/ /_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
          python3 \
          python3-dev \
          python3-pip \
          python3-venv
    
      echo "Updated Python3"
    
      echo "Installing ESPHome"
      #mkdir /srv/esphome
      #cd /srv/esphome
      #python3 -m venv .
      #source bin/activate
      pip install esphome tornado esptool
      echo "Installed ESPHome"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ___________ ____  __  __
           / ____/ ___// __ \/ / / /___  ____ ___  ___
          / __/  \__ \/ /_/ / /_/ / __ \/ __ __ \/ _ \
         / /___ ___/ / ____/ __  / /_/ / / / / / /  __/
        /_____//____/_/   /_/ /_/\____/_/ /_/ /_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
fhem () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ________
           / ____/ /_  ___  ____ ___
          / /_  / __ \/ _ \/ __ __ \
         / __/ / / / /  __/ / / / / /
        /_/   /_/ /_/\___/_/ /_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y avahi-daemon
      apt-get install -y gnupg2
      echo "Installed Dependencies"
    
      echo "Setting up Fhem Repository"
      curl -sSf https://debian.fhem.de/archive.key | gpg --dearmor >/etc/apt/trusted.gpg.d/debianfhemde-archive-keyring.gpg
      echo 'deb [signed-by=/etc/apt/trusted.gpg.d/debianfhemde-archive-keyring.gpg] https://debian.fhem.de/nightly/ /' >/etc/apt/sources.list.d/fhem.list
      echo "Set up Fhem Repository"
    
      echo "Installing Fhem"
      apt-get update
      apt-get install -y fhem
      echo "Installed Fhem"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
             ________
           / ____/ /_  ___  ____ ___
          / /_  / __ \/ _ \/ __ __ \
         / __/ / / / /  __/ / / / / /
        /_/   /_/ /_/\___/_/ /_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
go2rtc () {


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
    
                        ___        __
           ____ _____ |__ \ _____/ /______
          / __ / __ \__/ // ___/ __/ ___/
         / /_/ / /_/ / __// /  / /_/ /__
         \__, /\____/____/_/   \__/\___/
        /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing go2rtc"
      mkdir -p /opt/go2rtc
      cd /opt/go2rtc
      wget -q https://github.com/AlexxIT/go2rtc/releases/latest/download/go2rtc_linux_amd64
      chmod +x go2rtc_linux_amd64
      echo "Installed go2rtc"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                        ___        __
           ____ _____ |__ \ _____/ /______
          / __ / __ \__/ // ___/ __/ ___/
         / /_/ / /_/ / __// /  / /_/ /__
         \__, /\____/____/_/   \__/\___/
        /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
grafana () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______           ____
          / ____/________ _/ __/___ _____  ____ _
         / / __/ ___/ __  / /_/ __  / __ \/ __  /
        / /_/ / /  / /_/ / __/ /_/ / / / / /_/ /
        \____/_/   \__,_/_/  \__,_/_/ /_/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      apt-get install -y apt-transport-https
      apt-get install -y software-properties-common
      echo "Installed Dependencies"
    
      echo "Setting up Grafana Repository"
      wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
      sh -c 'echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" > /etc/apt/sources.list.d/grafana.list'
      echo "Set up Grafana Repository"
    
      echo "Installing Grafana"
      apt-get update
      apt-get install -y grafana
      systemctl start grafana-server
      systemctl enable --now -q grafana-server.service
      echo "Installed Grafana"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ______           ____
          / ____/________ _/ __/___ _____  ____ _
         / / __/ ___/ __  / /_/ __  / __ \/ __  /
        / /_/ / /  / /_/ / __/ /_/ / / / / /_/ /
        \____/_/   \__,_/_/  \__,_/_/ /_/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
grocy () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ____ __________  _______  __
          / __  / ___/ __ \/ ___/ / / /
         / /_/ / /  / /_/ / /__/ /_/ /
         \__, /_/   \____/\___/\__, /
        /____/                /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y apt-transport-https
      echo "Installed Dependencies"
    
      echo "Installing PHP 8.1"
      curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
      echo -e "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $VERSION main" >/etc/apt/sources.list.d/php.list
      apt-get update
      apt-get install -y php8.1
      apt-get install -y libapache2-mod-php8.1
      apt-get install -y php8.1-sqlite3
      apt-get install -y php8.1-gd
      apt-get install -y php8.1-intl
      apt-get install -y php8.1-mbstring
      echo "Installed PHP 8.1"
    
      echo "Installing grocy"
      latest=$(curl -s https://api.github.com/repos/grocy/grocy/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
      wget -q https://github.com/grocy/grocy/releases/download/v"${latest}"/grocy_"${latest}".zip
      unzip grocy_"${latest}".zip -d /var/www/html
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
      echo "Installed grocy"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            ____ __________  _______  __
          / __  / ___/ __ \/ ___/ / / /
         / /_/ / /  / /_/ / /__/ /_/ /
         \__, /_/   \____/\___/\__, /
        /____/                /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
heimdalldashboard (){


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                     _               _       _ _      ___          _     _                         _
          /\  /\___(_)_ __ ___   __| | __ _| | |    /   \__ _ ___| |__ | |__   ___   __ _ _ __ __| |
         / /_/ / _ \ | \_ \ _ \ / _ \| \_ \| | | | / /\ \/_/ /___| | | | | | | (_) | (_| | | |  __/
        / __  /  __/ | | | | | | (_| | (_| | | |  / /_// (_| \__ \ | | | |_) | (_) | (_| | | | (_| |
        \/ /_/ \___|_|_| |_| |_|\__,_|\__,_|_|_| /___, \__,_|___/_| |_|_.__/ \___/ \__,_|_|  \__,_|
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
         
         msg_info "Installing PHP"
         $STD apt-get install -y php
         $STD apt-get install -y php-sqlite3
         $STD apt-get install -y php-zip
         $STD apt-get install -y php-xml
         msg_ok "Installed PHP"
         
         RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/Heimdall/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]')
         msg_info "Installing Heimdall Dashboard \"${RELEASE}\""
         curl --silent -o "${RELEASE}".tar.gz -L "https://github.com/linuxserver/Heimdall/archive/\"${RELEASE}\".tar.gz"
        tar xvzf "${RELEASE}".tar.gz
         VER=$(curl -s https://api.github.com/repos/linuxserver/Heimdall/releases/latest |
           grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
         rm -rf "${RELEASE}".tar.gz
         mv Heimdall-"${VER}" /opt/Heimdall
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
         ExecStart=\"/usr/bin/php\" artisan serve --port 7990 --host 0.0.0.0
         TimeoutStopSec=30
         
         [Install]
         WantedBy=multi-user.target" >$service_path
         $STD sudo systemctl enable --now heimdall.service
         msg_ok "Created Service"

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                     _               _       _ _      ___          _     _                         _
          /\  /\___(_)_ __ ___   __| | __ _| | |    /   \__ _ ___| |__ | |__   ___   __ _ _ __ __| |
         / /_/ / _ \ | _  _ \ / _ |/ _ | | |   / /\ / _ / __|  _ \|  _ \ / _ \ / _ | __/ _ |
        / __  /  __/ | | | | | | (_| | (_| | | |  / /_// (_| \__ \ | | | |_) | (_) | (_| | | | (_| |
        \/ /_/ \___|_|_| |_| |_|\__,_|\__,_|_|_| /___, \__,_|___/_| |_|_.__/ \___/ \__,_|_|  \__,_|
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
homeassistant-core () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                                     _           _     _              _       ___
      /\  /\___  _ __ ___   ___    /_\  ___ ___(_)___| |_ __ _ _ __ | |_    / __\___  _ __ ___
     / /_/ / _ \|  _  _ \ / _ \  //_\/ __/ __| / __| __/ _ |  _ \| __|  / /  / _ \|  __/ _ \
    / __  / (_) | | | | | |  __/ /  _  \__ \__ \ \__ \ || (_| | | | | |_  / /__| (_) | | |  __/
    \/ /_/ \___/|_| |_| |_|\___| \_/ \_/___/___/_|___/\__\__,_|_| |_|\__| \____/\___/|_|  \___|
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
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
        { echo "export PYENV_ROOT=\"\$HOME/.pyenv\""; echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\""; } >> ~/.bashrc
        msg_ok "Installed pyenv"
        #shellcheck source=/dev/null
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
      #shellcheck source=/dev/null
      source bin/activate
      pip install --upgrade pip
      python3 -m pip install wheel
      pip install homeassistant
      pip install mysqlclient
      pip install psycopg2-binary
      mkdir -p /root/.homeassistant
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
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _           _     _              _       ___
      /\  /\___  _ __ ___   ___    /_\  ___ ___(_)___| |_ __ _ _ __ | |_    / __\___  _ __ ___
     / /_/ / _ \|  _  _ \ / _ \  //_\/ __/ __| / __| __/ _ |  _ \| __|  / /  / _ \|  __/ _ \
    / __  / (_) | | | | | |  __/ /  _  \__ \__ \ \__ \ || (_| | | | | |_  / /__| (_) | | |  __/
    \/ /_/ \___/|_| |_| |_|\___| \_/ \_/___/___/_|___/\__\__,_|_| |_|\__| \____/\___/|_|  \___|
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
homeassistant () {


      DISK_SIZE="16"
      msg_info "Suggested Disk: 1$DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __                        ___              _      __              __
       / / / /___  ____ ___  ___     /   |  __________(_)____/ /_____ _____  / /_
      / /_/ / __ \/ __  __ \/ _ \   / /| | / ___/ ___/ / ___/ __/ __  / __ \/ __/
     / __  / /_/ / / / / / /  __/  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_
    /_/ /_/\____/_/ /_/ /_/\___/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip \
      python3-venv
      echo "Updated Python3"
      get_latest_release() {
      curl -sL https://api.github.com/repos/"$1"/releases/latest | grep '"tag_name":' | cut -d'"' -f4
      }
    
      DOCKER_LATEST_VERSION=$(get_latest_release "moby/moby")
      CORE_LATEST_VERSION=$(get_latest_release "home-assistant/core")
    
      echo "Installing Docker $DOCKER_LATEST_VERSION"
      DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
      mkdir -p "$(dirname $DOCKER_CONFIG_PATH)"
      if [ "$ST" == "yes" ]; then
        VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
        cd /usr/local/bin
        curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/"$VER"/fuse-overlayfs-x86_64
        chmod 755 /usr/local/bin/fuse-overlayfs
        cd ~
        echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
      else
        echo -e '{\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
      fi
      sh <(curl -sSL https://get.docker.com)
      echo "Installed Docker $DOCKER_LATEST_VERSION"
    
      echo "Pulling Portainer $\"$APPS\"portAINER_LATEST_VERSION Image"
      docker pull portainer/portainer-ce:latest
      echo "Pulled Portainer $\"$APPS\"portAINER_LATEST_VERSION Image"
    
      echo "Installing Portainer $\"$APPS\"portAINER_LATEST_VERSION"
      docker volume create portainer_data
      docker run -d \
      -p 8000:8000 \
      -p 9000:9000 \
      --name=portainer \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data \
      portainer/portainer-ce:latest
      echo "Installed Portainer $\"$APPS\"portAINER_LATEST_VERSION"
    
      echo "Pulling Home Assistant $CORE_LATEST_VERSION Image"
      docker pull ghcr.io/home-assistant/home-assistant:stable
      echo "Pulled Home Assistant $CORE_LATEST_VERSION Image"
    
      echo "Installing Home Assistant $CORE_LATEST_VERSION"
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
      echo "Installed Home Assistant $CORE_LATEST_VERSION"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __                        ___              _      __              __
       / / / /___  ____ ___  ___     /   |  __________(_)____/ /_____ _____  / /_
      / /_/ / __ \/ __  __ \/ _ \   / /| | / ___/ ___/ / ___/ __/ __  / __ \/ __/
     / __  / /_/ / / / / / /  __/  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_
    /_/ /_/\____/_/ /_/ /_/\___/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
homebridge () {



      
      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE \"$$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ______  __  _____________  ____  ________  ____________
       / / / / __ \/  |/  / ____/ __ // __ \/  _/ __ \/ ____/ ____/
      / /_/ / / / / /|_/ / __/ / __  / /_/ // // / / / / __/ __/
     / __  / /_/ / /  / / /___/ /_/ / _, _// // /_/ / /_/ / /___
    /_/ /_/\____/_/  /_/_____/_____/_/ |_/___/_____/\____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y avahi-daemon
      apt-get install -y gnupg2
      echo "Installed Dependencies"
    
      echo "Setting up Homebridge Repository"
      curl -sSf https://repo.homebridge.io/KEY.gpg | gpg --dearmor >/etc/apt/trusted.gpg.d/homebridge.gpg
      echo 'deb [signed-by=/etc/apt/trusted.gpg.d/homebridge.gpg] https://repo.homebridge.io stable main' >/etc/apt/sources.list.d/homebridge.list
      echo "Set up Homebridge Repository"
    
      echo "Installing Homebridge"
      apt update
      apt-get install -y homebridge
      echo "Installed Homebridge"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ______  __  _____________  ____  ________  ____________
       / / / / __ \/  |/  / ____/ __ / __ \/  _/ __ \/ ____/ ____/
      / /_/ / / / / /|_/ / __/ / __  / /_/ // // / / / / __/ __/
     / __  / /_/ / /  / / /___/ /_/ / _, _// // /_/ / /_/ / /___
    /_/ /_/\____/_/  /_/_____/_____/_/ |_/___/_____/\____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
homepage () {


      
      DISK_SIZE="3"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __
       / / / /___  ____ ___  ___  ____  ____ _____ ____
      / /_/ / __ \/ __ __ \/ _ \/ __ \/ __ / __ / _ \
     / __  / /_/ / / / / / /  __/ /_/ / /_/ / /_/ /  __/
    /_/ /_/\____/_/ /_/ /_/\___/ .___/\__,_/\__, /\___/
                              /_/          /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs git make g++ gcc
      npm install -g pnpm
      echo "Installed Node.js"
    
      echo "Installing Homepage (Patience)"
      cd /opt
      git clone https://github.com/benphelps/homepage.git
      cd /opt/homepage
      mkdir -p config
      cp /opt/homepage/src/skeleton/* /opt/homepage/config
      pnpm install
      pnpm build
      echo "Installed Homepage"
    
      echo "Creating Service"
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
      WantedBy='multi-user.target'" >$service_path
      systemctl enable --now homepage
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __
       / / / /___  ____ ___  ___  ____  ____ _____ ____
      / /_/ / __ \/ __ __ \/ _ \/ __ \/ __ / __ / _ \
     / __  / /_/ / / / / / /  __/ /_/ / /_/ / /_/ /  __/
    /_/ /_/\____/_/ /_/ /_/\___/ .___/\__,_/\__, /\___/
                              /_/          /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
homer () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __
       / / / /___  ____ ___  ___  _____
      / /_/ / __ \/ __ __ \/ _ \/ ___/
     / __  / /_/ / / / / / /  __/ /
    /_/ /_/\____/_/ /_/ /_/\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y pip
      echo "Installed Dependencies"
    
      echo "Installing Homer"
      mkdir -p /opt/homer
      cd /opt/homer
      wget -q https://github.com/bastienwirtz/homer/releases/latest/download/homer.zip
      unzip homer.zip
      rm -rf homer.zip
      cp assets/config.yml.dist assets/config.yml
      echo "Installed Homer"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __
       / / / /___  ____ ___  ___  _____
      / /_/ / __ \/ __ __ \/ _ \/ ___/
     / __  / /_/ / / / / / /  __/ /
    /_/ /_/\____/_/ /_/ /_/\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
hyperion () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __                      _
       / / / /_  ______  ___  _____(_)___  ____
      / /_/ / / / / __ \/ _ \/ ___/ / __ \/ __ \
     / __  / /_/ / /_/ /  __/ /  / / /_/ / / / /
    /_/ /_/\__, / .___/\___/_/  /_/\____/_/ /_/
          /____/_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y lsb-release
      apt-get install -y gpg
      apt-get install -y apt-transport-https
      echo "Installed Dependencies"
    
      echo "Installing Hyperion"
      wget -qO- https://apt.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg
      sh -c 'echo "deb [signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.hyperion-project.org/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/hyperion.list'
      apt-get update
      apt-get install -y hyperion
      systemctl enable --now hyperion@root.service
      echo "Installed Hyperion"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  __                      _
       / / / /_  ______  ___  _____(_)___  ____
      / /_/ / / / / __ \/ _ \/ ___/ / __ \/ __ \
     / __  / /_/ / /_/ /  __/ /  / / /_/ / / / /
    /_/ /_/\__, / .___/\___/_/  /_/\____/_/ /_/
          /____/_/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
influxdb () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____      ______           ____  ____
       /  _/___  / __/ /_  ___  __/ __ \/ __ )
       / // __ \/ /_/ / / / / |/_/ / / / __  |
     _/ // / / / __/ / /_/ />  </ /_/ / /_/ /
    /___/_/ /_/_/ /_/\__,_/_/|_/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y lsb-base
      apt-get install -y lsb-release
      apt-get install -y gnupg2
      echo "Installed Dependencies"
    
      echo "Setting up InfluxDB Repository"
      wget -q https://repos.influxdata.com/influxdata-archive_compat.key
      gpg --dearmor < influxdata-archive_compat.key | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
      sh -c 'echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main" > /etc/apt/sources.list.d/influxdata.list'
      echo "Set up InfluxDB Repository"
    
      read -r -p "Which version of InfluxDB to install? (1 or 2) " prompt
      if [[ $prompt == "2" ]]; then
        INFLUX="2"
      else
        INFLUX="1"
      fi
    
      echo "Installing InfluxDB"
      apt-get update
      if [[ $INFLUX == "2" ]]; then
        apt-get install -y influxdb2
      else
        apt-get install -y influxdb
        wget -q https://dl.influxdata.com/chronograf/releases/chronograf_1.10.1_amd64.deb
        dpkg -i chronograf_1.10.1_amd64.deb
      fi
      systemctl enable --now influxdb
      echo "Installed InfluxDB"
    
      read -r -p "Would you like to add Telegraf? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
        echo "Installing Telegraf"
        apt-get install -y telegraf
        echo "Installed Telegraf"
      fi
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____      ______           ____  ____
       /  _/___  / __/ /_  ___  __/ __ \/ __ )
       / // __ \/ /_/ / / / / |/_/ / / / __  |
     _/ // / / / __/ / /_/ />  </ /_/ / /_/ /
    /___/_/ /_/_/ /_/\__,_/_/|_/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
iobroker () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _       ____             __
       (_)___  / __ )_________  / /_____  _____
      / / __ \/ __  / ___/ __ \/ //_/ _ \/ ___/
     / / /_/ / /_/ / /  / /_/ / ,< /  __/ /
    /_/\____/_____/_/   \____/_/|_|\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing ioBroker (Patience)"
      bash <(curl -fsSL https://iobroker.net/install.sh)
      echo "Installed ioBroker"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _       ____             __
       (_)___  / __ )_________  / /_____  _____
      / / __ \/ __  / ___/ __ \/ //_/ _ \/ ___/
     / / /_/ / /_/ / /  / /_/ / ,< /  __/ /
    /_/\____/_____/_/   \____/_/|_|\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
jackett () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            __           __        __  __
          / /___ ______/ /_____  / /_/ /_
     __  / / __ / ___/ //_/ _ \/ __/ __/
    / /_/ / /_/ / /__/ ,< /  __/ /_/ /_
    \____/\__,_/\___/_/|_|\___/\__/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Jackett"
      RELEASE=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4)
      wget -q https://github.com/Jackett/Jackett/releases/download/"$RELEASE"/Jackett.Binaries.LinuxAMDx64.tar.gz
      tar -xzf Jackett.Binaries.LinuxAMDx64.tar.gz -C /opt
      rm -rf Jackett.Binaries.LinuxAMDx64.tar.gz
      echo "Installed Jackett"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            __           __        __  __
          / /___ ______/ /_____  / /_/ /_
     __  / / __ / ___/ //_/ _ \/ __/ __/
    / /_/ / /_/ / /__/ ,< /  __/ /_/ /_
    \____/\__,_/\___/_/|_|\___/\__/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
jellyfin () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="ubuntu"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            __     ____      _____
          / /__  / / /_  __/ __(_)___
     __  / / _ \/ / / / / / /_/ / __ \
    / /_/ /  __/ / / /_/ / __/ / / / /
    \____/\___/_/_/\__, /_/ /_/_/ /_/
                  /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y gnupg
      apt-get install -y mc
      echo "Installed Dependencies"
    
      if [[ "$CTTYPE" == "0" ]]; then
        echo "Setting Up Hardware Acceleration"
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
        echo "Set Up Hardware Acceleration"
      fi
    
      echo "Installing Jellyfin"
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
      echo "Installed Jellyfin"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
            __     ____      _____
          / /__  / / /_  __/ __(_)___
     __  / / _ \/ / / / / / /_/ / __ \
    / /_/ /  __/ / / /_/ / __/ / / / /
    \____/\___/_/_/\__, /_/ /_/_/ /_/
                  /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
jellyseerr() {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
    #  CORE_COUNT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
           __     ____
          / /__  / / /_  __________  ___  __________
     __  / / _ \/ / / / / / ___/ _ \/ _ \/ ___/ ___/
    / /_/ /  __/ / / /_/ (__  )  __/  __/ /  / /
    \____/\___/_/_/\__, /____/\___/\___/_/  /_/
                  /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
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
  echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" EOF

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
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:5055${CL} \n"
    
}
    
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
k0s () {


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
    
         __   ____          __ __      __                         __
       / /__/ __ \_____   / //_/_  __/ /_  ___  _________  ___  / /____  _____
      / //_/ / / / ___/  / ,< / / / / __ \/ _ \/ ___/ __ \/ _ \/ __/ _ \/ ___/
     / ,< / /_/ (__  )  / /| / /_/ / /_/ /  __/ /  / / / /  __/ /_/  __(__  )
    /_/|_|\____/____/  /_/ |_\__,_/_.___/\___/_/  /_/ /_/\___/\__/\___/____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Installing k0s Kubernetes"
      bash <(curl -sSLf https://get.k0s.sh)
      k0s install controller --single
      k0s start
      mkdir -p /etc/k0s
      k0s config create > /etc/k0s/k0s.yaml
      echo "Installed k0s Kubernetes"
    
      read -r -p "Would you like to add Helm Package Manager? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
        echo "Installing Helm"
        bash <(curl -sSLf https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
        echo "Installed Helm"
      fi
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __   ____          __ __      __                         __
       / /__/ __ \_____   / //_/_  __/ /_  ___  _________  ___  / /____  _____
      / //_/ / / / ___/  / ,< / / / / __ \/ _ \/ ___/ __ \/ _ \/ __/ _ \/ ___/
     / ,< / /_/ (__  )  / /| / /_/ / /_/ /  __/ /  / / / /  __/ /_/  __(__  )
    /_/|_|\____/____/  /_/ |_\__,_/_.___/\___/_/  /_/ /_/\___/\__/\___/____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
kavita () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __ __            _ __
       / //_/___ __   __(_) /_____ _
      / ,< / __ / | / / / __/ __ /
     / /| / /_/ /| |/ / / /_/ /_/ /
    /_/ |_\__,_/ |___/_/\__/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Kavita"
      cd /opt
      RELEASE=$(curl -s https://api.github.com/repos/Kareadita/Kavita/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
      tar -xvzf <(curl -fsSL https://github.com/Kareadita/Kavita/releases/download/"$RELEASE"/kavita-linux-x64.tar.gz) --no-same-owner
      echo "Installed Kavita"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __ __            _ __
       / //_/___ __   __(_) /_____ _
      / ,< / __ / | / / / __/ __ /
     / /| / /_/ /| |/ / / /_/ /_/ /
    /_/ |_\__,_/ |___/_/\__/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
keycloak () {


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
    
         __ __                __            __
       / //_/__  __  _______/ /___  ____ _/ /__
      / ,< / _ \/ / / / ___/ / __ \/ __  / //_/
     / /| /  __/ /_/ / /__/ / /_/ / /_/ / ,<
    /_/ |_\___/\__, /\___/_/\____/\__,_/_/|_|
              /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
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
      wget -q https://github.com/keycloak/keycloak/releases/download/"$RELEASE"/keycloak-"$RELEASE".tar.gz
      tar -xvf keycloak-"$RELEASE".tar.gz
      mv keycloak-"$RELEASE" keycloak
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
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __ __                __            __
       / //_/__  __  _______/ /___  ____ _/ /__
      / ,< / _ \/ / / / ___/ / __ \/ __  / //_/
     / /| /  __/ /_/ / /__/ / /_/ / /_/ / ,<
    /_/ |_\___/\__, /\___/_/\____/\__,_/_/|_|
              /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
lidarr () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __    _     __
       / /   (_)___/ /___  __________
      / /   / / __  / __ / ___/ ___/
     / /___/ / /_/ / /_/ / /  / /
    /_____/_/\__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y sqlite3
      apt-get install -y libchromaprint-tools
      apt-get install -y mediainfo
      echo "Installed Dependencies"
    
      echo "Installing Lidarr"
      mkdir -p /var/lib/lidarr/
      chmod 775 /var/lib/lidarr/
      wget --content-disposition 'https://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
      tar -xvzf Lidarr.master.*.tar.gz
      mv Lidarr /opt
      chmod 775 /opt/Lidarr
      echo "Installed Lidarr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __    _     __
       / /   (_)___/ /___  __________
      / /   / / __  / __ / ___/ ___/
     / /___/ / /_/ / /_/ / /  / /
    /_____/_/\__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
magicmirror () {


      DISK_SIZE="3"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___            _      __  ____
       /  |/  /___ _____ _(_)____/  |/  (_)_____________  _____
      / /|_/ / __  / __  / / ___/ /|_/ / / ___/ ___/ __ \/ ___/
     / /  / / /_/ / /_/ / / /__/ /  / / / /  / /  / /_/ / /
    /_/  /_/\__,_/\__, /_/\___/_/  /_/_/_/  /_/   \____/_/
                 /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Installing Node.js"
      bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
      #shellcheck source=/dev/null
      . ~/.bashrc
      nvm install 16.20.1
      ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
      echo "Installed Node.js"
      apt install npm nodejs -y
      echo "Setting up MagicMirror Repository"
      git clone https://github.com/MichMich/MagicMirror /opt/magicmirror
      echo "Set up MagicMirror Repository"
    
      echo "Installing MagicMirror"
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
      echo "Installed MagicMirror"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___            _      __  ____
       /  |/  /___ _____ _(_)____/  |/  (_)_____________  _____
      / /|_/ / __  / __  / / ___/ /|_/ / / ___/ ___/ __ \/ ___/
     / /  / / /_/ / /_/ / / /__/ /  / / / /  / /  / /_/ / /
    /_/  /_/\__,_/\__, /_/\___/_/  /_/_/_/  /_/   \____/_/
                 /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
mariadb () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___           _       ____  ____
       /  |/  /___ ______(_)___ _/ __ \/ __ )
      / /|_/ / __  / ___/ / __  / / / / __  |
     / /  / / /_/ / /  / / /_/ / /_/ / /_/ /
    /_/  /_/\__,_/_/  /_/\__,_/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing MariaDB"
      apt-get install -y mariadb-server
      echo "Installed MariaDB"
    
      read -r -p "Would you like to add Adminer? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
        echo "Installing Adminer"
        apt install -y adminer
        a2enconf adminer
        systemctl reload apache2
        echo "Installed Adminer"
      fi
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___           _       ____  ____
       /  |/  /___ ______(_)___ _/ __ \/ __ )
      / /|_/ / __  / ___/ / __  / / / / __  |
     / /  / / /_/ / /  / / /_/ / /_/ / /_/ /
    /_/  /_/\__,_/_/  /_/\__,_/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
meshcentral () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___          __    ______           __             __
       /  |/  /__  _____/ /_  / ____/__  ____  / /__________ _/ /
      / /|_/ / _ \/ ___/ __ \/ /   / _ \/ __ \/ __/ ___/ __  / /
     / /  / /  __(__  ) / / / /___/  __/ / / / /_/ /  / /_/ / /
    /_/  /_/\___/____/_/ /_/\____/\___/_/ /_/\__/_/   \__,_/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      
    
      echo "Installing Node.js"
      bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
      #shellcheck source=/dev/null
      . ~/.bashrc
      nvm install 16.20.1
      ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
      echo "Installed Node.js"
      apt install npm nodejs -y
    
      echo "Installing MeshCentral"
      mkdir /opt/meshcentral
      cd /opt/meshcentral
      npm install meshcentral
      node node_modules/meshcentral --install
      echo "Installed MeshCentral"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___          __    ______           __             __
       /  |/  /__  _____/ /_  / ____/__  ____  / /__________ _/ /
      / /|_/ / _ \/ ___/ __ \/ /   / _ \/ __ \/ __/ ___/ __  / /
     / /  / /  __(__  ) / / / /___/  __/ / / / /_/ /  / /_/ / /
    /_/  /_/\___/____/_/ /_/\____/\___/_/ /_/\__/_/   \__,_/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
motioneye () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___      __  _
       /  |/  /___  / /_(_)___  ____  ___  __  _____
      / /|_/ / __ \/ __/ / __ \/ __ \/ _ \/ / / / _ \
     / /  / / /_/ / /_/ / /_/ / / / /  __/ /_/ /  __/
    /_/  /_/\____/\__/_/\____/_/ /_/\___/\__, /\___/
                                        /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      apt-get install -y cifs-utils
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip
      echo "Updated Python3"
    
      echo "Installing Motion"
      apt-get install -y motion
      systemctl stop motion
      systemctl disable motion
      echo "Installed Motion"
    
      echo "Installing FFmpeg"
      apt-get install -y ffmpeg v4l-utils
      echo "Installed FFmpeg"
    
      echo "Installing MotionEye"
      apt-get update
      pip install git+https://github.com/motioneye-project/motioneye.git@dev
      mkdir -p /etc/motioneye
      chown -R root:root /etc/motioneye
      chmod -R 777 /etc/motioneye
      wget -qO /etc/motioneye/motioneye.conf https://raw.githubusercontent.com/motioneye-project/motioneye/dev/motioneye/extra/motioneye.conf.sample
      mkdir -p /var/lib/motioneye
      echo "Installed MotionEye"
    
      echo "Creating Service"
      wget -qO /etc/systemd/system/motioneye.service https://raw.githubusercontent.com/motioneye-project/motioneye/dev/motioneye/extra/motioneye.systemd
      systemctl enable -q --now motioneye
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___      __  _
       /  |/  /___  / /_(_)___  ____  ___  __  _____
      / /|_/ / __ \/ __/ / __ \/ __ \/ _ \/ / / / _ \
     / /  / / /_/ / /_/ / /_/ / / / /  __/ /_/ /  __/
    /_/  /_/\____/\__/_/\____/_/ /_/\___/\__, /\___/
                                        /____/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
mqtt () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___           ____        _ ____________
       /  |/  /___  _____/ __ \__  __(_)_  __/_  __/___
      / /|_/ / __ \/ ___/ / / / / / / / / /   / / / __ \
     / /  / / /_/ (__  ) /_/ / /_/ / / / /   / / / /_/ /
    /_/  /_/\____/____/\___\_\__,_/_/ /_/   /_/  \____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
      echo "Installing Mosquitto MQTT Broker"
      apt-get -y install mosquitto
      apt-get -y install mosquitto-clients
      echo "Installed Mosquitto MQTT Broker"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         __  ___           ____        _ ____________
       /  |/  /___  _____/ __ \__  __(_)_  __/_  __/___
      / /|_/ / __ \/ ___/ / / / / / / / / /   / / / __ \
     / /  / / /_/ (__  ) /_/ / /_/ / / / /   / / / /_/ /
    /_/  /_/\____/____/\___\_\__,_/_/ /_/   /_/  \____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
n8n () {


      DISK_SIZE="3"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
              ___
            / _ \
      _ __ | (_) |____
     |  _ \ > _ <|  _ \
     | | | | (_) | | | |
     |_| |_|\___/|_| |_|
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Installing n8n (Patience)"
      npm install --global n8n
      echo "Installed n8n"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
              ___
            / _ \
      _ __ | (_) |____
     |  _ \ > _ <|  _ \
     | | | | (_) | | | |
     |_| |_|\___/|_| |_|
    
      Wesh Alors Prod - zshmeta' | lolcat


}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
navidrome () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __            _     __
       / | / /___ __   __(_)___/ /________  ____ ___  ___
      /  |/ / __  / | / / / __  / ___/ __ \/ __  __ \/ _ \
     / /|  / /_/ /| |/ / / /_/ / /  / /_/ / / / / / /  __/
    /_/ |_/\__,_/ |___/_/\__,_/_/   \____/_/ /_/ /_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
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
      wget https://github.com/navidrome/navidrome/releases/download/v"${RELEASE}"/navidrome_"${RELEASE}"_Linux_x86_64.tar.gz -O Navidrome.tar.gz
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
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __            _     __
       / | / /___ __   __(_)___/ /________  ____ ___  ___
      /  |/ / __  / | / / / __  / ___/ __ \/ __  __ \/ _ \
     / /|  / /_/ /| |/ / / /_/ / /  / /_/ / / / / / /  __/
    /_/ |_/\__,_/ |___/_/\__,_/_/   \____/_/ /_/ /_/\___/
    
      Wesh Alors Prod - zshmeta' | lolcat

      msg_info "Navidrome is now available at http://$IP:4533"

      echo "echo 'Navidrome is now available at http://$IP:4533'" >>/etc/update-motd.d/99-nextcloudpi
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
nextcloudpi () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE \"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __          __  ________                ______  _
       / | / /__  _  __/ /_/ ____/ /___  __  ______/ / __ \(_)
      /  |/ / _ \| |/_/ __/ /   / / __ \/ / / / __  / /_/ / /
     / /|  /  __/>  </ /_/ /___/ / /_/ / /_/ / /_/ / ____/ /
    /_/ |_/\___/_/|_|\__/\____/_/\____/\__,_/\__,_/_/   /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing NextCloudPi (Patience)"
      bash <(curl -fsSL https://raw.githubusercontent.com/nextcloud/nextcloudpi/master/install.sh)
      sed -i "s/3 => 'nextcloudpi.lan',/3 => '0.0.0.0',/g" /var/www/nextcloud/config/config.php
      sed -i '{s|root:/usr/sbin/nologin|root:/bin/bash|g}' /etc/passwd
      sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/8.1/fpm/php.ini /etc/php/8.1/cli/php.ini
      service apache2 restart
      echo "Installed NextCloudPi"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __          __  ________                ______  _
       / | / /__  _  __/ /_/ ____/ /___  __  ______/ / __ \(_)
      /  |/ / _ \| |/_/ __/ /   / / __ \/ / / / __  / /_/ / /
     / /|  /  __/>  </ /_/ /___/ / /_/ / /_/ / /_/ / ____/ /
    /_/ |_/\___/_/|_|\__/\____/_/\____/\__,_/\__,_/_/   /_/
    
      Wesh Alors Prod - zshmeta' | lolcat

      msg_info "NextCloudPi is now available at http://$IP:4443"
      

      echo "echo 'alias nextcloud=\"cd /var/www/nextcloud/\"' >> ~/.bashrc" >> ~/.zshrc
      echo "echo 'NextcloudPi is now available at http://$IP:4443'" >> ~/.zshrc
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
nginxproxymanager () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __      _               ____                           __  ___
       / | / /___ _(_)___  _  __   / __ \_________ __  ____  __   /  |/  /___ _____  ____ _____ ____  _____
      /  |/ / __  / / __ \| |/_/  / /_/ / ___/ __ \| |/_/ / / /  / /|_/ / __  / __ \/ __  / __  / _ \/ ___/
     / /|  / /_/ / / / / />  <   / ____/ /  / /_/ />  </ /_/ /  / /  / / /_/ / / / / /_/ / /_/ /  __/ /
    /_/ |_/\__, /_/_/ /_/_/|_|  /_/   /_/   \____/_/|_|\__, /  /_/  /_/\__,_/_/ /_/\__,_/\__, /\___/_/
          /____/                                      /____/                            /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
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
      echo "Installed Dependencies"
    
      echo "Updating Python"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip \
      python3-venv \
      python3-cffi \
      python3-certbot \
      python3-certbot-dns-cloudflare
    
      python3 -m venv /opt/certbot/
      echo "Updated Python"
    
    
      echo "Installing Openresty"
      wget -qO - https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/openresty-archive-keyring.gpg
      echo -e "deb http://openresty.org/package/debian bullseye openresty" >/etc/apt/sources.list.d/openresty.list
      apt-get update
      apt-get -y install openresty
      echo "Installed Openresty"
    
      echo "Installing Node.js"
      bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
      #shellcheck source=/dev/null
      . ~/.bashrc
      nvm install 16.20.1
      ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
      echo "Installed Node.js"
      apt install npm nodejs -y
      echo "Installing Yarn"
      npm install -g yarn
      echo "Installed Yarn"
    
      RELEASE=$(curl -s https://api.github.com/repos/NginxProxyManager/nginx-proxy-manager/releases/latest |
        grep "tag_name" |
      awk '{print substr($2, 3, length($2)-4) }')
    
      echo "Downloading Nginx Proxy Manager v${RELEASE}"
      wget -q https://codeload.github.com/NginxProxyManager/nginx-proxy-manager/tar.gz/v"${RELEASE}" -O - | tar -xz
      cd ./nginx-proxy-manager-"${RELEASE}"
      echo "Downloaded Nginx Proxy Manager v${RELEASE}"
    
      echo "Setting up Enviroment"
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
      echo "Set up Enviroment"
    
      echo "Building Frontend"
      cd ./frontend
      export NODE_ENV=development
      yarn install --network-timeout=30000
      yarn build
      cp -r dist/* /app/frontend
      cp -r app-images/* /app/frontend/images
      echo "Built Frontend"
    
      echo "Initializing Backend"
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
      echo "Initialized Backend"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __      _               ____                           __  ___
       / | / /___ _(_)___  _  __   / __ \_________ __  ____  __   /  |/  /___ _____  ____ _____ ____  _____
      /  |/ / __  / / __ \| |/_/  / /_/ / ___/ __ \| |/_/ / / /  / /|_/ / __  / __ \/ __  / __  / _ \/ ___/
     / /|  / /_/ / / / / />  <   / ____/ /  / /_/ />  </ /_/ /  / /  / / /_/ / / / / /_/ / /_/ /  __/ /
    /_/ |_/\__, /_/_/ /_/_/|_|  /_/   /_/   \____/_/|_|\__, /  /_/  /_/\__,_/_/ /_/\__,_/\__, /\___/_/
          /____/                                      /____/                            /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
        



      echo "Starting Service"
      systemctl daemon-reload
      systemctl enable npm.service
      systemctl start npm.service
      echo "Started Service"
      msg_ok "NGINX PROXY MANAGER INSTALLED"

      msg_info "You can now access the app on http://$IP:81"
      
      echo "echo 'alias npm=\"systemctl start npm.service\"' >> ~/.bashrc" >> ~/.zshrc
      echo "echo 'Nginx installed visit http://$IP:81' >> ~/.bashrc" >> ~/.zshrc
}
    
    


########################################################################################################################
#############################################################################################################################################################

##################################################################################################################################################
nocodb(){


    
      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __                 ____  ____
       / | / /___  ____  ___  / __ \/ __ )
      /  |/ / __ \/ ___/ __ \/ / / / __  |
     / /|  / /_/ / /__/ /_/ / /_/ / /_/ /
    /_/ |_/\____/\___/\____/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      apt-get install -y make
      apt-get install -y g++
      apt-get install -y gcc
      echo "Installed Dependencies"
    
      echo "Installing Node.js"
      bash <(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)
      #shellcheck source=/dev/null
      . ~/.bashrc
      nvm install 16.20.1
      ln -sf /root/.nvm/versions/node/v16.20.1/bin/node /usr/bin/node
      echo "Installed Node.js"
      apt install npm nodejs -y
      echo "Installing NocoDB"
      git clone https://github.com/nocodb/nocodb-seed
      mv nocodb-seed /opt/nocodb
      cd /opt/nocodb
      npm install
      echo "Installed NocoDB"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __                 ____  ____
       / | / /___  ____  ___  / __ \/ __ )
      /  |/ / __ \/ ___/ __ \/ / / / __  |
     / /|  / /_/ / /__/ /_/ / /_/ / /_/ /
    /_/ |_/\____/\___/\____/_____/_____/

    
      Wesh Alors Prod - zshmeta' | lolcat

      msg_info "NocoDB is now running on http://$IP:8080"
      echo "echo 'NocoDB is now running on http://$IP:8080'" >>/wtc/motd
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
nodered () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __          __        ____           __
       / | / /___  ____/ /__     / __ \___  ____/ /
      /  |/ / __ \/ __  / _ \   / /_/ / _ \/ __  /
     / /|  / /_/ / /_/ /  __/  / _, _/  __/ /_/ /
    /_/ |_/\____/\__,_/\___/  /_/ |_|\___/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Installing Node-Red"
      npm install -g --unsafe-perm node-red
      echo "Installed Node-Red"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         _   __          __        ____           __
       / | / /___  ____/ /__     / __ \___  ____/ /
      /  |/ / __ \/ __  / _ \   / /_/ / _ \/ __  /
     / /|  / /_/ / /_/ /  __/  / _, _/  __/ /_/ /
    /_/ |_/\____/\__,_/\___/  /_/ |_|\___/\__,_/

    
      Wesh Alors Prod - zshmeta' | lolcat

      msg_info "Node-Red is now available at http://$IP:1880"
      echo "echo \"Node-Red is now available at http://$IP:1880\"" >>~/.zshrc
}


#####################################################################################################################################################

#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
omada () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        ____                      __
      / __ \____ ___  ____ _____/ /___ _
     / / / / __  __ \/ __  / __  / __  /
    / /_/ / / / / / / /_/ / /_/ / /_/ /
    \____/_/ /_/ /_/\__,_/\__,_/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      apt-get install -y jsvc
      echo "Installed Dependencies"
    
      echo "Installing Azul Zulu"
      wget -qO /etc/apt/trusted.gpg.d/zulu-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xB1998361219BD9C9"
      wget -q https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
      dpkg -i zulu-repo_1.0.0-3_all.deb
      apt-get update
      apt-get -y install zulu8-jdk
      echo "Installed Azul Zulu"
    
      echo "Installing MongoDB"
      wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      wget -qL https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.23_amd64.deb
      dpkg -i mongodb-org-server_3.6.23_amd64.deb
      echo "Installed MongoDB"
    
      echo "Installing Omada Controller v5.9.31"
      wget -qL https://static.tp-link.com/upload/software/2023/202303/20230321/Omada_SDN_Controller_v5.9.31_Linux_x64.deb
      dpkg -i Omada_SDN_Controller_v5.9.31_Linux_x64.deb
      echo "Installed Omada Controller"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        ____                      __
      / __ \____ ___  ____ _____/ /___ _
     / / / / __  __ \/ __  / __  / __  /
    / /_/ / / / / / / /_/ / /_/ / /_/ /
    \____/_/ /_/ /_/\__,_/\__,_/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      echo "Starting Omada Controller"
      service omada start
      echo "Started Omada Controller" 
      msg_info "Omada Controller is now available at https://$IP:8043"
      msg_info "Default username and password is admin/admin"
      echo "figlet -w 13 -t -f term 'Omada Controller at https://$IP:8043 using admin/admin'" >> ~/.zshrc 
}
    


#############################################################################################################################################################

########################################################################################################################
ombi(){


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
        echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" figlet -t -
      c -W -w 150 -f term 'by zshmeta - Le Z c le S
       ____            __    _
      / __ \____ ___  / /_  (_)
     / / / / __  __ \/ __ \/ /
    / /_/ / / / / / / /_/ / /
    \____/_/ /_/ /_/_.___/_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      echo "Installing Dependencies"
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Ombi"
      LATEST=$(curl -sL https://api.github.com/repos/Ombi-app/Ombi/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
    # wget -q https://github.com/Ombi-app/Ombi/releases/download/${LATEST}/linux-x64.tar.gz
      wget -q https://github.com/Ombi-app/Ombi/releases/download/v4.43.2/linux-x64.tar.gz
      mkdir -p /opt/ombi
      tar -xzf linux-x64.tar.gz -C /opt/ombi
      echo "Installed Ombi"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      motd_ssh
      customize
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:5000${CL} \n"
    
    }
    
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
omv () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        ____                   __  ___         ___      _    __            ____
      / __ \____  ___  ____  /  |/  /__  ____/ (_)___ | |  / /___ ___  __/ / /_
     / / / / __ \/ _ \/ __ \/ /|_/ / _ \/ __  / / __ / | / / __ / / / / / __/
    / /_/ / /_/ /  __/ / / / /  / /  __/ /_/ / / /_/ /| |/ / /_/ / /_/ / / /_
    \____/ .___/\___/_/ /_/_/  /_/\___/\__,_/_/\__,_/ |___/\__,_/\__,_/_/\__/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      echo "Installed Dependencies"
    
      echo "Installing OpenMediaVault (Patience)"
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
      echo "Installed OpenMediaVault"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        ____                   __  ___         ___      _    __            ____
      / __ \____  ___  ____  /  |/  /__  ____/ (_)___ | |  / /___ ___  __/ / /_
     / / / / __ \/ _ \/ __ \/ /|_/ / _ \/ __  / / __ / | / / __ / / / / / __/
    / /_/ / /_/ /  __/ / / / /  / /  __/ /_/ / / /_/ /| |/ / /_/ / /_/ / / /_
    \____/ .___/\___/_/ /_/_/  /_/\___/\__,_/_/\__,_/ |___/\__,_/\__,_/_/\__/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}${CL} \n"
    
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
openhab () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                               __  _____    ____
      ____  ____  ___  ____  / / / /   |  / __ )
     / __ \/ __ \/ _ \/ __ \/ /_/ / /| | / __  |
    / /_/ / /_/ /  __/ / / / __  / ___ |/ /_/ /
    \____/ .___/\___/_/ /_/_/ /_/_/  |_/_____/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      apt-get install -y apt-transport-https
      echo "Installed Dependencies"
    
      echo "Installing Azul Zulu"
      wget -qO /etc/apt/trusted.gpg.d/zulu-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xB1998361219BD9C9"
      wget -q https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
      dpkg -i zulu-repo_1.0.0-3_all.deb
      apt-get update
      apt-get -y install zulu11-jdk
      echo "Installed Azul Zulu"
    
      echo "Installing openHAB"
      curl -fsSL "https://openhab.jfrog.io/artifactory/api/gpg/key/public" | gpg --dearmor >openhab.gpg
      mv openhab.gpg /usr/share/keyrings
      chmod u=rw,g=r,o=r /usr/share/keyrings/openhab.gpg
      echo "deb [signed-by=/usr/share/keyrings/openhab.gpg] https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main" > /etc/apt/sources.list.d/openhab.list
      apt update
      apt-get -y install openhab
      systemctl daemon-reload
      systemctl enable -q --now openhab.service
      echo "Installed openHAB"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                               __  _____    ____
      ____  ____  ___  ____  / / / /   |  / __ )
     / __ \/ __ \/ _ \/ __ \/ /_/ / /| | / __  |
    / /_/ / /_/ /  __/ / / / __  / ___ |/ /_/ /
    \____/ .___/\___/_/ /_/_/ /_/_/  |_/_____/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:8080${CL} \n"
    
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
openobserve () {


      DISK_SIZE="3"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
    
       ____                   ____  __
      / __ \____  ___  ____  / __ \/ /_  ________  ______   _____
     / / / / __ \/ _ \/ __ \/ / / / __ \/ ___/ _ \/ ___/ | / / _ \
    / /_/ / /_/ /  __/ / / / /_/ / /_/ (__  )  __/ /   | |/ /  __/
    \____/ .___/\___/_/ /_/\____/_.___/____/\___/_/    |___/\___/
        /_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing OpenObserve"
      mkdir -p /opt/openobserve/data
      LATEST=$(curl -sL https://api.github.com/repos/openobserve/openobserve/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
      tar zxvf <(curl -fsSL https://github.com/openobserve/openobserve/releases/download/"$LATEST"/openobserve-"${LATEST}"-linux-amd64.tar.gz) -C /opt/openobserve
    
      cat <<EOF >/opt/openobserve/data/.env
    ZO_ROOT_USER_EMAIL = "admin@example.com"
    ZO_ROOT_USER_PASSWORD = "$(openssl rand -base64 18 | cut -c1-13)"
    ZO_DATA_DIR = "/opt/openobserve/data"
    ZO_HTTPPORT = "5080"
EOF
      echo "Installed OpenObserve"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
    
       ____                   ____  __
      / __ \____  ___  ____  / __ \/ /_  ________  ______   _____
     / / / / __ \/ _ \/ __ \/ / / / __ \/ ___/ _ \/ ___/ | / / _ \
    / /_/ / /_/ /  __/ / / / /_/ / /_/ (__  )  __/ /   | |/ /  __/
    \____/ .___/\___/_/ /_/\____/_.___/____/\___/_/    |___/\___/
        /_/
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:5080${CL} \n"
    
}
    
    
#####################################################################################################################################################



overseerr(){    


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
        echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" figlet -t -
      c -W -w 150 -f term 'by zshmeta - Le Z c le S
       ____
      / __ \_   _____  _____________  ___  __________
     / / / / | / / _ \/ ___/ ___/ _ \/ _ \/ ___/ ___/
    / /_/ /| |/ /  __/ /  (__  )  __/  __/ /  / /
    \____/ |___/\___/_/  /____/\___/\___/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      echo "Installing Dependencies"
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Installing Yarn"
      npm install -g yarn
      echo "Installed Yarn"
    
      echo "Installing Overseerr (Patience)"
      git clone -q https://github.com/sct/overseerr.git /opt/overseerr
      cd /opt/overseerr
      yarn install
      yarn build
      echo "Installed Overseerr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:5055${CL} \n"
    
}


#####################################################################################################################################################motd_ssh
    


#############################################################################################################################################################

########################################################################################################################
paperlessngx () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                        __
       / __ \____ _____  ___  _____/ /__  __________    ____  ____ __  __
      / /_/ / __ / __ \/ _ \/ ___/ / _ \/ ___/ ___/___/ __ \/ __ / |/_/
     / ____/ /_/ / /_/ /  __/ /  / /  __(__  |__  )___/ / / / /_/ />  <
    /_/    \__,_/ .___/\___/_/  /_/\___/____/____/   /_/ /_/\__, /_/|_|
               /_/                                         /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                        __
       / __ \____ _____  ___  _____/ /__  __________    ____  ____ __  __
      / /_/ / __ / __ \/ _ \/ ___/ / _ \/ ___/ ___/___/ __ \/ __ / |/_/
     / ____/ /_/ / /_/ /  __/ /  / /  __(__  |__  )___/ / / / /_/ />  <
    /_/    \__,_/ .___/\___/_/  /_/\___/____/____/   /_/ /_/\__, /_/|_|
               /_/                                         /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:8000${CL} \n"
    
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
photoprism () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="4"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="4096"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  __  ______  __________  ____  ____  _________ __  ___
       / __ \/ / / / __ \/_  __/ __ \/ __ \/ __ \/  _/ ___//  |/  /
      / /_/ / /_/ / / / / / / / / / / /_/ / /_/ // / \__ \/ /|_/ /
     / ____/ __  / /_/ / / / / /_/ / ____/ _, _// / ___/ / /  / /
    /_/   /_/ /_/\____/ /_/  \____/_/   /_/ |_/___//____/_/  /_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  __  ______  __________  ____  ____  _________ __  ___
       / __ \/ / / / __ \/_  __/ __ \/ __ \/ __ \/  _/ ___//  |/  /
      / /_/ / /_/ / / / / / / / / / / /_/ / /_/ // / \__ \/ /|_/ /
     / ____/ __  / /_/ / / / / /_/ / ____/ _, _// / ___/ / /  / /
    /_/   /_/ /_/\____/ /_/  \____/_/   /_/ |_/___//____/_/  /_/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
pihole () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  ____   __  ______  __    ______
       / __ \/  _/  / / / / __ \/ /   / ____/
      / /_/ // /___/ /_/ / / / / /   / __/
     / ____// /___/ __  / /_/ / /___/ /___
    /_/   /___/  /_/ /_/\____/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y ufw
      apt-get install -y ntp
      echo "Installed Dependencies"
    
      echo "Installing Pi-hole"
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
      echo "Installed Pi-hole"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  ____   __  ______  __    ______
       / __ \/  _/  / / / / __ \/ /   / ____/
      / /_/ // /___/ /_/ / / / / /   / __/
     / ____// /___/ __  / /_/ / /___/ /___
    /_/   /___/  /_/ /_/\____/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
plex () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="ubuntu"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  __             __  ___         ___          _____
       / __ \/ /__  _  __   /  |/  /__  ____/ (_)___ _   / ___/___  ______   _____  _____
      / /_/ / / _ \| |/_/  / /|_/ / _ \/ __  / / __ /   \__ \/ _ \/ ___/ | / / _ \/ ___/
     / ____/ /  __/>  <   / /  / /  __/ /_/ / / /_/ /   ___/ /  __/ /   | |/ /  __/ /
    /_/   /_/\___/_/|_|  /_/  /_/\___/\__,_/_/\__,_/   /____/\___/_/    |___/\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      if [[ "$CTTYPE" == "0" ]]; then
        echo "Setting Up Hardware Acceleration"
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
        echo "Set Up Hardware Acceleration"
      fi
    
      echo "Setting Up Plex Media Server Repository"
      wget -qO- https://downloads.plex.tv/plex-keys/PlexSign.key >/etc/apt/trusted.gpg.d/PlexSign.asc
      echo "deb [arch=$(dpkg --print-architecture)] https://downloads.plex.tv/repo/deb/ public main" >/etc/apt/sources.list.d/plexmediaserver.list
      echo "Set Up Plex Media Server Repository"
    
      echo "Installing Plex Media Server"
      apt-get update
      apt-get -o Dpkg::Options::="--force-confold" install -y plexmediaserver
      echo "Installed Plex Media Server"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  __             __  ___         ___          _____
       / __ \/ /__  _  __   /  |/  /__  ____/ (_)___ _   / ___/___  ______   _____  _____
      / /_/ / / _ \| |/_/  / /|_/ / _ \/ __  / / __ /   \__ \/ _ \/ ___/ | / / _ \/ ___/
     / ____/ /  __/>  <   / /  / /  __/ /_/ / / /_/ /   ___/ /  __/ /   | |/ /  __/ /
    /_/   /_/\___/_/|_|  /_/  /_/\___/\__,_/_/\__,_/   /____/\___/_/    |___/\___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    

penpot(){

      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      figlet -t -c -W -w 150 -f term 'PenPot'
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S'
        
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
   
      
      get_latest_release() {
        curl -sL https://api.github.com/repos/"$1"/releases/latest | grep '"tag_name":' | cut -d'"' -f4
      }
          
      DOCKER_LATEST_VERSION=$(get_latest_release "moby/moby")
      DOCKER_COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")
      
      msg_info "Installing Docker $DOCKER_LATEST_VERSION"
      DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
      mkdir -p "$(dirname $DOCKER_CONFIG_PATH)"
      if [ "$ST" == "yes" ]; then
        VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
        cd /usr/local/bin
        curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/"$VER"/fuse-overlayfs-x86_64
        chmod 755 /usr/local/bin/fuse-overlayfs
        cd ~
        echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
      else
        echo -e '{\n  "log-driver": "journald"\n}' >/etc/docker/daemon.json
      fi
      sh <(curl -sSL https://get.docker.com)
      msg_ok "Installed Docker $DOCKER_LATEST_VERSION"
      
      msg_info "Installing Docker Compose $DOCKER_COMPOSE_LATEST_VERSION"
      DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
      mkr -p "$DOCKER_CONFIG"/cli-plugins
      cu -sSL https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_LATEST_VERSION"/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
      chd +x "$DOCKER_CONFIG"/cli-plugins/docker-compose
      msg_ok "Installed Docker Compose \"$DOCKER_COMPOSE_LATEST_VERSION\""
      msg_get https://raw.githubusercontent.com/penpot/penpot/main/docker/images/docker-compose.yaml
      docker compose -p penpot -f docker-compose.yaml up -d
       
      msg_info "Installing Portainer \"$\"$APPS\"portAINER_LATEST_VERSION\""
      figlet -t -c -W -w 150 -f big 'PenPot'
      figlet -t -c -W -w 150 -f term "by zshmeta - Le Z c le S\nvisit port 9000 to configure\"\nWesh Alors Prod - zshmeta" | lolcat

}


#############################################################################################################################################################

########################################################################################################################
podmanhomeassistant () {


      DISK_SIZE="16"
      msg_info "Suggested Disk: 1$DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                          ____            __
                        / __ \____  ____/ /___ ___  ____ _____
                       / /_/ / __ \/ __  / __  __ \/ __  / __ \
                      / ____/ /_/ / /_/ / / / / / / /_/ / / / /
        __  __       /_/    \____/\__,_/_/ /_/ /_/\__,_/_/ /_/__              __
       / / / /___  ____ ___  ___     /   |  __________(_)____/ /_____ _____  / /_
      / /_/ / __ \/ __  __ \/ _ \   / /| | / ___/ ___/ / ___/ __/ __  / __ \/ __/
     / __  / /_/ / / / / / /  __/  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_
    /_/ /_/\____/_/ /_/ /_/\___/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Podman"
      apt-get -y install podman
      systemctl enable --now podman.socket
      echo "Installed Podman"
    
      echo "Pulling Home Assistant Image"
      podman pull docker.io/homeassistant/home-assistant:stable
      echo "Pulled Home Assistant Image"
    
      echo "Installing Home Assistant"
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
      echo "Installed Home Assistant"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
                          ____            __
                        / __ \____  ____/ /___ ___  ____ _____
                       / /_/ / __ \/ __  / __  __ \/ __  / __ \
                      / ____/ /_/ / /_/ / / / / / / /_/ / / / /
        __  __       /_/    \____/\__,_/_/ /_/ /_/\__,_/_/ /_/__              __
       / / / /___  ____ ___  ___     /   |  __________(_)____/ /_____ _____  / /_
      / /_/ / __ \/ __  __ \/ _ \   / /| | / ___/ ___/ / ___/ __/ __  / __ \/ __/
     / __  / /_/ / / / / / /  __/  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_
    /_/ /_/\____/_/ /_/ /_/\___/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
podman () {


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
    
         ____            __
       / __ \____  ____/ /___ ___  ____ _____
      / /_/ / __ \/ __  / __ __ \/ __ / __ \
     / ____/ /_/ / /_/ / / / / / / /_/ / / / /
    /_/    \____/\__,_/_/ /_/ /_/\__,_/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Podman"
      apt-get -y install podman
      systemctl enable --now podman.socket
      echo -e 'unqualified-search-registries=["docker.io"]' >> /etc/containers/registries.conf
      echo "Installed Podman"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____            __
       / __ \____  ____/ /___ ___  ____ _____
      / /_/ / __ \/ __  / __ __ \/ __ / __ \
     / ____/ /_/ / /_/ / / / / / / /_/ / / / /
    /_/    \____/\__,_/_/ /_/ /_/\__,_/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
postgresql () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____             __                 _____ ____    __
       / __ \____  _____/ /_____ _________ / ___// __ \  / /
      / /_/ / __ \/ ___/ __/ __  / ___/ _ \__ \/ / / / / /
     / ____/ /_/ (__  ) /_/ /_/ / /  /  __/__/ / /_/ / / /___
    /_/    \____/____/\__/\__, /_/   \___/____/\___\_\/_____/
                         /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      echo "Installed Dependencies"
    
      echo "Setting up PostgreSQL Repository"
      echo "deb http://apt.postgresql.org/pub/repos/apt ${VERSION}-pgdg main" >/etc/apt/sources.list.d/pgdg.list
      curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor --output /etc/apt/trusted.gpg.d/postgresql.gpg
      echo "Setup PostgreSQL Repository"
    
      echo "Installing PostgreSQL"
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
      echo "Installed PostgreSQL"
    
      read -r -p "Would you like to add Adminer? <y/N> " prompt
      if [[ "${prompt,,}" =~ ^(y|yes)$ ]]; then
        echo "Installing Adminer"
        apt install -y adminer
        a2enconf adminer
        systemctl reload apache2
        echo "Installed Adminer"
      fi
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____             __                 _____ ____    __
       / __ \____  _____/ /_____ _________ / ___// __ \  / /
      / /_/ / __ \/ ___/ __/ __  / ___/ _ \__ \/ / / / / /
     / ____/ /_/ (__  ) /_/ /_/ / /  /  __/__/ / /_/ / / /___
    /_/    \____/____/\__/\__, /_/   \___/____/\___\_\/_____/
                         /____/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
prometheus () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                            __  __
       / __ \_________  ____ ___  ___  / /_/ /_  ___  __  _______
      / /_/ / ___/ __ \/ __  __ \/ _ \/ __/ __ \/ _ \/ / / / ___/
     / ____/ /  / /_/ / / / / / /  __/ /_/ / / /  __/ /_/ (__  )
    /_/   /_/   \____/_/ /_/ /_/\___/\__/_/ /_/\___/\__,_/____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Prometheus"
      RELEASE=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4) }')
      mkdir -p /etc/prometheus
      mkdir -p /var/lib/prometheus
      wget https://github.com/prometheus/prometheus/releases/download/v"${RELEASE}""/prometheus-\"${RELEASE}".linux-amd64.tar.gz
      tar -xvf prometheus-"${RELEASE}".linux-amd64.tar.gz
      cd prometheus-"${RELEASE}".linux-amd64
      mv prometheus promtool /usr/local/bin/
      mv consoles/ console_libraries/ /etc/prometheus/
      mv prometheus.yml /etc/prometheus/prometheus.yml
      echo "Installed Prometheus"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                            __  __
       / __ \_________  ____ ___  ___  / /_/ /_  ___  __  _______
      / /_/ / ___/ __ \/ __  __ \/ _ \/ __/ __ \/ _ \/ / / / ___/
     / ____/ /  / /_/ / / / / / /  __/ /_/ / / /  __/ /_/ (__  )
    /_/   /_/   \____/_/ /_/ /_/\___/\__/_/ /_/\___/\__,_/____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:9090${CL} \n"
    
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
prowlarr () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                     __
       / __ \_________ _      __/ /___  __________
      / /_/ / ___/ __ \ | /| / / / __ / ___/ ___/
     / ____/ /  / /_/ / |/ |/ / / /_/ / /  / /
    /_/   /_/   \____/|__/|__/_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y sqlite3
      echo "Installed Dependencies"
    
      echo "Installing Prowlarr"
      mkdir -p /var/lib/prowlarr/
      chmod 775 /var/lib/prowlarr/
      wget --content-disposition 'https://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
      tar -xvzf Prowlarr.master.*.tar.gz
      mv Prowlarr /opt
      chmod 775 /opt/Prowlarr
      echo "Installed Prowlarr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____                     __
       / __ \_________ _      __/ /___  __________
      / /_/ / ___/ __ \ | /| / / / __ / ___/ ___/
     / ____/ /  / /_/ / |/ |/ / / /_/ / /  / /
    /_/   /_/   \____/|__/|__/_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:9696${CL} \n"
    
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
qbittorrent () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
              ____  _ __  __                             __
      ____ _/ __ )(_) /_/ /_____  _____________  ____  / /_
     / __ / __  / / __/ __/ __ \/ ___/ ___/ _ \/ __ \/ __/
    / /_/ / /_/ / / /_/ /_/ /_/ / /  / /  /  __/ / / / /_
    \__, /_____/_/\__/\__/\____/_/  /_/   \___/_/ /_/\__/
      /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing qbittorrent-nox"
      apt-get install -y qbittorrent-nox
      echo "qbittorrent-nox"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
              ____  _ __  __                             __
      ____ _/ __ )(_) /_/ /_____  _____________  ____  / /_
     / __ / __  / / __/ __/ __ \/ ___/ ___/ _ \/ __ \/ __/
    / /_/ / /_/ / / /_/ /_/ /_/ / /  / /  /  __/ / / / /_
    \__, /_____/_/\__/\__/\____/_/  /_/   \___/_/ /_/\__/
      /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
radarr () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____            __
       / __ \____ _____/ /___  __________
      / /_/ / __ / __  / __ / ___/ ___/
     / _, _/ /_/ / /_/ / /_/ / /  / /
    /_/ |_|\__,_/\__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y sqlite3
      echo "Installed Dependencies"
    
      echo "Installing Radarr"
      mkdir -p /var/lib/radarr/
      chmod 775 /var/lib/radarr/
      wget --content-disposition 'https://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
      tar -xvzf Radarr.master.*.tar.gz
      mv Radarr /opt
      chmod 775 /opt/Radarr
      echo "Installed Radarr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____            __
       / __ \____ _____/ /___  __________
      / /_/ / __ / __  / __ / ___/ ___/
     / _, _/ /_/ / /_/ / /_/ / /  / /
    /_/ |_|\__,_/\__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:7878${CL} \n"
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
rdtclient () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____             __    ____       __         _     __   ______                           __     _________            __
       / __ \___  ____  / /   / __ \___  / /_  _____(_)___/ /  /_  __/___  _____________  ____  / /_   / ____/ (_)__  ____  / /_
      / /_/ / _ \/ __ / /___/ / / / _ \/ __ \/ ___/ / __  /    / / / __ \/ ___/ ___/ _ \/ __ \/ __/  / /   / / / _ \/ __ \/ __/
     / _, _/  __/ /_/ / /___/ /_/ /  __/ /_/ / /  / / /_/ /    / / / /_/ / /  / /  /  __/ / / / /_   / /___/ / /  __/ / / / /_
    /_/ |_|\___/\__,_/_/   /_____/\___/_.___/_/  /_/\__,_/    /_/  \____/_/  /_/   \___/_/ /_/\__/   \____/_/_/\___/_/ /_/\__/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y unzip
      echo "Installed Dependencies"
    
      echo "Installing ASP.NET Core Runtime"
      wget -q https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
      dpkg -i packages-microsoft-prod.deb
      rm packages-microsoft-prod.deb
      apt-get update
      apt-get install -y dotnet-sdk-6.0
      echo "Installed ASP.NET Core Runtime"
    
      echo "Installing rdtclient"
      wget -q https://github.com/rogerfar/rdt-client/releases/latest/download/RealDebridClient.zip
      unzip -qq RealDebridClient.zip -d /opt/rdtc
      rm RealDebridClient.zip
      cd /opt/rdtc
      mkdir -p data/db/ data/downloads
      sed -i 's#/data/db/#/opt/rdtc&#g' /opt/rdtc/appsettings.json
      echo "Installed rdtclient"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____             __    ____       __         _     __   ______                           __     _________            __
       / __ \___  ____  / /   / __ \___  / /_  _____(_)___/ /  /_  __/___  _____________  ____  / /_   / ____/ (_)__  ____  / /_
      / /_/ / _ \/ __ / /___/ / / / _ \/ __ \/ ___/ / __  /    / / / __ \/ ___/ ___/ _ \/ __ \/ __/  / /   / / / _ \/ __ \/ __/
     / _, _/  __/ /_/ / /___/ /_/ /  __/ /_/ / /  / / /_/ /    / / / /_/ / /  / /  /  __/ / / / /_   / /___/ / /  __/ / / / /_
    /_/ |_|\___/\__,_/_/   /_____/\___/_.___/_/  /_/\__,_/    /_/  \____/_/  /_/   \___/_/ /_/\__/   \____/_/_/\___/_/ /_/\__/
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:5000${CL} \n"
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
rtsptoweb () {


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
    
         ____  ___________ ____  __      _       __     __
       / __ \/_  __/ ___// __ \/ /_____| |     / /__  / /_
      / /_/ / / /  \__ \/ /_/ / __/ __ \ | /| / / _ \/ __ \
     / _, _/ / /  ___/ / ____/ /_/ /_/ / |/ |/ /  __/ /_/ /
    /_/ |_| /_/  /____/_/    \__/\____/|__/|__/\___/_.___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y git
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Golang"
      wget https://golang.org/dl/go1.20.1.linux-amd64.tar.gz
      tar -xzf go1.20.1.linux-amd64.tar.gz -C /usr/local
      ln -s /usr/local/go/bin/go /usr/local/bin/go
      rm -rf go1.20.1.linux-amd64.tar.gz
      echo "Installed Golang"
    
      echo "Installing RTSPtoWeb"
      git clone https://github.com/deepch/RTSPtoWeb /opt/rtsptoweb
      cat <<EOF >>/opt/rtsptoweb/start
    cd /opt/rtsptoweb && GO111MODULE=on go run *.go
EOF
      chmod +x /opt/rtsptoweb/start
      echo "Installed RTSPtoWeb"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
         ____  ___________ ____  __      _       __     __
       / __ \/_  __/ ___// __ \/ /_____| |     / /__  / /_
      / /_/ / / /  \__ \/ /_/ / __/ __ \ | /| / / _ \/ __ \
     / _, _/ / /  ___/ / ____/ /_/ /_/ / |/ |/ /  __/ /_/ /
    /_/ |_| /_/  /____/_/    \__/\____/|__/|__/\___/_.___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:8080${CL} \n"
    }
    
    
##

########################################################################################################################
#############################################################################################################################################################

################################################################################################################################################echo "\n$last_block\n\n" >> "${file}.tmp"
sabnzbd() {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____ ___    ____              __        __
      / ___//   |  / __ )____  ____  / /_  ____/ /
      \__ \/ /| | / __  / __ \/_  / / __ \/ __  /
     ___/ / ___ |/ /_/ / / / / / /_/ /_/ / /_/ /
    /____/_/  |_/_____/_/ /_/ /___/_.___/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y par2
      apt-get install -y p7zip-full
      wget -q http://http.us.debian.org/debian/pool/non-free/u/unrar-nonfree/unrar_6.0.3-1+deb11u1_amd64.deb
      dpkg -i unrar_6.0.3-1+deb11u1_amd64.deb
      rm unrar_6.0.3-1+deb11u1_amd64.deb
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip
      apt-get install -y python3-setuptools
      echo "Updated Python3"
    
      echo "Installing SABnzbd"
      RELEASE=$(curl -s https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
      tar zxvf <(curl -fsSL https://github.com/sabnzbd/sabnzbd/releases/download/"$RELEASE"/SABnzbd-"${RELEASE}"-src.tar.gz)
      mv SABnzbd-"${RELEASE}" /opt/sabnzbd
      cd /opt/sabnzbd
      python3 -m pip install -r requirements.txt
      echo "Installed SABnzbd"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____ ___    ____              __        __
      / ___//   |  / __ )____  ____  / /_  ____/ /
      \__ \/ /| | / __  / __ \/_  / / __ \/ __  /
     ___/ / ___ |/ /_/ / / / / / /_/ /_/ / /_/ /
    /____/_/  |_/_____/_/ /_/ /___/_.___/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
      msg_ok "Completed Successfully!\n"
      echo -e "${APP} should be reachable by going to the following URL.
      ${BL}http://${IP}:7777${CL} \n"
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
scrypted () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____                       __           __
      / ___/____________  ______  / /____  ____/ /
      \__ \/ ___/ ___/ / / / __ \/ __/ _ \/ __  /
     ___/ / /__/ /  / /_/ / /_/ / /_/  __/ /_/ /
    /____/\___/_/   \__, / .___/\__/\___/\__,_/
                   /____/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
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
    
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____                       __           __
      / ___/____________  ______  / /____  ____/ /
      \__ \/ ___/ ___/ / / / __ \/ __/ _ \/ __  /
     ___/ / /__/ /  / /_/ / /_/ / /_/  __/ /_/ /
    /____/\___/_/   \__, / .___/\__/\___/\__,_/
                   /____/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
shinobi () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="ubuntu"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____ __    _             __    _
      / ___// /_  (_)___  ____  / /_  (_)
      \__ \/ __ \/ / __ \/ __ \/ __ \/ /
     ___/ / / / / / / / / /_/ / /_/ / /
    /____/_/ /_/_/_/ /_/\____/_.___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl sudo git mc
      apt-get install -y make zip net-tools
      apt-get install -y gcc g++ cmake
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs npm
      echo "Installed Node.js"
    
      echo "Installing FFMPEG"
      apt-get install -y ffmpeg
      echo "Installed FFMPEG"
    
      echo "Clonning Shinobi"
      cd /opt
      git clone https://gitlab.com/Shinobi-Systems/Shinobi.git -b master Shinobi
      cd Shinobi
      gitVersionNumber=$(git rev-parse HEAD)
      theDateRightNow=$(date)
      touch version.json
      chmod 777 version.json
      echo '{"Product" : "'"Shinobi"'" , "Branch" : "'"master"'" , "Version" : "'"$gitVersionNumber"'" , "Date" : "'"$theDateRightNow"'" , "Repository" : "'"https://gitlab.com/Shinobi-Systems/Shinobi.git"'"}' > version.json
      echo "Cloned Shinobi"
    
      echo "Installing Database"
      sqlpass=""
      echo "mariadb-server mariadb-server/root_password password $sqlpass" | debconf-set-selections
      echo "mariadb-server mariadb-server/root_password_again password $sqlpass" | debconf-set-selections
      apt-get install -y mariadb-server
      service mysql start
      sqluser="root"
      mysql -e "source sql/user.sql" || true
      mysql -e "source sql/framework.sql" || true
      echo "Installed Database user $sqluser pass $sqlpass"
      cp conf.sample.json conf.json
      cronKey=$(head -c 1024 < /dev/urandom | sha256sum | awk '{print substr($1,1,29)}')
      sed -i -e 's/Shinobi/'"$cronKey"'/g' conf.json
      cp super.sample.json super.json
    
      echo "Installing Shinobi"
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
      echo "Installed Shinobi"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____ __    _             __    _
      / ___// /_  (_)___  ____  / /_  (_)
      \__ \/ __ \/ / __ \/ __ \/ __ \/ /
     ___/ / / / / / / / / /_/ / /_/ / /
    /____/_/ /_/_/_/ /_/\____/_.___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
sonarr () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____
      / ___/____  ____  ____  __________
      \__ \/ __ \/ __ \/ __ / ___/ ___/
     ___/ / /_/ / / / / /_/ / /  / /
    /____/\____/_/ /_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      apt-get install -y ca-certificates
      echo "Installed Dependencies"
    
      echo "Installing Sonarr"
      wget -qO /etc/apt/trusted.gpg.d/sonarr-repo.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2009837cbffd68f45bc180471f4f90de2a9b4bf8"
      echo "deb https://apt.sonarr.tv/debian testing-main main" >/etc/apt/sources.list.d/sonarr.list
      apt-get update
      DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" install -qqy sonarr &>/dev/null
      echo "Installed Sonarr"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____
      / ___/____  ____  ____  __________
      \__ \/ __ \/ __ \/ __ / ___/ ___/
     ___/ / /_/ / / / / /_/ / /  / /
    /____/\____/_/ /_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
syncthing () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____                  __  __    _
      / ___/__  ______  _____/ /_/ /_  (_)___  ____ _
      \__ \/ / / / __ \/ ___/ __/ __ \/ / __ \/ __ /
     ___/ / /_/ / / / / /__/ /_/ / / / / / / / /_/ /
    /____/\__, /_/ /_/\___/\__/_/ /_/_/_/ /_/\__, /
         /____/                             /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      echo "Installed Dependencies"
    
      echo "Installing Syncthing"
      curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
      sh -c 'echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" > /etc/apt/sources.list.d/syncthing.list'
      apt-get update
      apt-get install -y syncthing
      systemctl enable syncthing@root.service
      systemctl start syncthing@root.service
      sleep 5
      sed -i "{s/127.0.0.1:8384/0.0.0.0:8384/g}" /root/.config/syncthing/config.xml
      systemctl restart syncthing@root.service
      echo "Installed Syncthing"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        _____                  __  __    _
      / ___/__  ______  _____/ /_/ /_  (_)___  ____ _
      \__ \/ / / / __ \/ ___/ __/ __ \/ / __ \/ __ /
     ___/ / /_/ / / / / /__/ /_/ / / / / / / / /_/ /
    /____/\__, /_/ /_/\___/\__/_/ /_/_/_/ /_/\__, /
         /____/                             /____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
tautulli () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______            __        _____
     /_  __/___ ___  __/ /___  __/ / (_)
      / / / __ / / / / __/ / / / / / /
     / / / /_/ / /_/ / /_/ /_/ / / / /
    /_/  \__,_/\__,_/\__/\__,_/_/_/_/
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      apt-get install -y pip
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip
      echo "Updated Python3"
    
      echo "Installing Tautulli"
      cd /opt
      git clone https://github.com/Tautulli/Tautulli.git
      python3 -m pip install -q -r /opt/Tautulli/requirements.txt
      pip install pyopenssl
      echo "Installed Tautulli"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______            __        _____
     /_  __/___ ___  __/ /___  __/ / (_)
      / / / __ / / / / __/ / / / / / /
     / / / /_/ / /_/ / /_/ /_/ / / / /
    /_/  \__,_/\__,_/\__/\__,_/_/_/_/
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
tdarr () {


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
    
       ______    __
     /_  __/___/ /___  __________
      / / / __  / __ / ___/ ___/
     / / / /_/ / /_/ / /  / /
    /_/  \__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      if [[ "$CTTYPE" == "0" ]]; then
        echo "Setting Up Hardware Acceleration"
        apt-get -y install \
        va-driver-all \
        ocl-icd-libopencl1 \
        intel-opencl-icd
    
        /bin/chgrp video /dev/dri
        /bin/chmod 755 /dev/dri
        /bin/chmod 660 /dev/dri/*
        echo "Set Up Hardware Acceleration"
      fi
    
      echo "Installing Tdarr"
      mkdir -p /opt/tdarr
      cd /opt/tdarr
      wget -q https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip
      unzip Tdarr_Updater.zip
      rm -rf Tdarr_Updater.zip
      chmod +x Tdarr_Updater
      ./Tdarr_Updater &>/dev/null
      echo "Installed Tdarr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______    __
     /_  __/___/ /___  __________
      / / / __  / __ / ___/ ___/
     / / / /_/ / /_/ / /  / /
    /_/  \__,_/\__,_/_/  /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
technitiumdns () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______          __          _ __  _                    ____  _   _______
     /_  __/__  _____/ /_  ____  (_) /_(_)_  ______ ___     / __ \/ | / / ___/
      / / / _ \/ ___/ __ \/ __ \/ / __/ / / / / __  __ \   / / / /  |/ /\__ \
     / / /  __/ /__/ / / / / / / / /_/ / /_/ / / / / / /  / /_/ / /|  /___/ /
    /_/  \___/\___/_/ /_/_/ /_/_/\__/_/\__,_/_/ /_/ /_/  /_____/_/ |_//____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing ASP.NET Core Runtime"
      wget -q https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
      dpkg -i packages-microsoft-prod.deb
      rm -rf packages-microsoft-prod.deb
      apt-get update
      apt-get install -y aspnetcore-runtime-7.0
      echo "Installed ASP.NET Core Runtime"
    
      echo "Installing Technitium DNS"
      bash <(curl -fsSL https://download.technitium.com/dns/install.sh)
      echo "Installed Technitium DNS"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______          __          _ __  _                    ____  _   _______
     /_  __/__  _____/ /_  ____  (_) /_(_)_  ______ ___     / __ \/ | / / ___/
      / / / _ \/ ___/ __ \/ __ \/ / __/ / / / / __  __ \   / / / /  |/ /\__ \
     / / /  __/ /__/ / / / / / / / /_/ / /_/ / / / / / /  / /_/ / /|  /___/ /
    /_/  \___/\___/_/ /_/_/ /_/_/\__/_/\__,_/_/ /_/ /_/  /_____/_/ |_//____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
transmission () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______                                _           _
     /_  __/________ _____  _________ ___  (_)_________(_)___  ____
      / / / ___/ __ / __ \/ ___/ __ __ \/ / ___/ ___/ / __ \/ __ \
     / / / /  / /_/ / / / (__  ) / / / / / (__  |__  ) / /_/ / / / /
    /_/ /_/   \__,_/_/ /_/____/_/ /_/ /_/_/____/____/_/\____/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
    
      echo "Installing Transmission"
      apt-get install -y transmission-daemon
      systemctl stop transmission-daemon
      sed -i '{s/"rpc-whitelist-enabled": true/"rpc-whitelist-enabled": false/g; s/"rpc-host-whitelist-enabled": true,/"rpc-host-whitelist-enabled": false,/g}' /etc/transmission-daemon/settings.json
      systemctl start transmission-daemon
      echo "Installed Transmission"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______                                _           _
     /_  __/________ _____  _________ ___  (_)_________(_)___  ____
      / / / ___/ __ / __ \/ ___/ __ __ \/ / ___/ ___/ / __ \/ __ \
     / / / /  / /_/ / / / (__  ) / / / / / (__  |__  ) / /_/ / / / /
    /_/ /_/   \__,_/_/ /_/____/_/ /_/ /_/_/____/____/_/\____/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
trilium () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______     _ ___
     /_  __/____(_) (_)_  ______ ___
      / / / ___/ / / / / / / __ __
     / / / /  / / / / /_/ / / / / / /
    /_/ /_/  /_/_/_/\__,_/_/ /_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      RELEASE=$(curl -s https://api.github.com/repos/zadam/trilium/releases/latest |
        grep "tag_name" |
      awk '{print substr($2, 3, length($2)-4) }')
    
      echo "Installing Trilium"
      wget -q https://github.com/zadam/trilium/releases/download/v"$RELEASE"/trilium-linux-x64-server-"$RELEASE".tar.xz
      tar -xvf trilium-linux-x64-server-"$RELEASE".tar.xz
      mv trilium-linux-x64-server /opt/trilium
      echo "Installed Trilium"
    
      echo "Creating Service"
      service_path="/etc/systemd/system/trilium.service"
    
      echo "[Unit]
    Description=Trilium Daemon
    After=syslog.target network.target
    
    [Service]
    User=root
    Type=simple
    ExecStart=/opt/trilium/trilium.sh
    WorkingDirectory=/opt/trilium/
    TimeoutStopSec=20
    Restart=always
    
    [Install]
      WantedBy=multi-user.target" >$service_path
      systemctl enable --now -q trilium
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
       ______     _ ___
     /_  __/____(_) (_)_  ______ ___
      / / / ___/ / / / / / / __ __ \
     / / / /  / / / / /_/ / / / / / /
    /_/ /_/  /_/_/_/\__,_/_/ /_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
ubuntu () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="ubuntu"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  ____                __
      / / / / /_  __  ______  / /___  __
     / / / / __ \/ / / / __ \/ __/ / / /
    / /_/ / /_/ / /_/ / / / / /_/ /_/ /
    \____/_.___/\__,_/_/ /_/\__/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  ____                __
      / / / / /_  __  ______  / /___  __
     / / / / __ \/ / / / __ \/ __/ / / /
    / /_/ / /_/ / /_/ / / / / /_/ /_/ /
    \____/_.___/\__,_/_/ /_/\__/\__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
umbrel () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __          __              __
      / / / /___ ___  / /_  ________  / /
     / / / / __ __ \/ __ \/ ___/ _ \/ /
    / /_/ / / / / / / /_/ / /  /  __/ /
    \____/_/ /_/ /_/_.___/_/   \___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Umbrel (Patience)"
      DOCKER_CONFIG_PATH='/etc/docker/daemon.json'
      mkdir -p "$(dirname $DOCKER_CONFIG_PATH)"
    
      VER=$(curl -s https://api.github.com/repos/containers/fuse-overlayfs/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
      cd /usr/local/bin
      curl -sSL -o fuse-overlayfs https://github.com/containers/fuse-overlayfs/releases/download/"$VER"/fuse-overlayfs-x86_64
      chmod 755 /usr/local/bin/fuse-overlayfs
      cd ~
      echo -e '{\n  "storage-driver": "fuse-overlayfs",\n  "log-driver": "journald"\n}' > /etc/docker/daemon.json
    
      bash <(curl -fsSL https://umbrel.sh)
      systemctl daemon-reload
      systemctl enable --now umbrel-startup.service
      echo "Installed Umbrel"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __          __              __
      / / / /___ ___  / /_  ________  / /
     / / / / __ __ \/ __ \/ ___/ _ \/ /
    / /_/ / / / / / / /_/ / /  /  __/ /
    \____/_/ /_/ /_/_.___/_/   \___/_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
unifi () {


      DISK_SIZE="8"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __      _ _____
      / / / /__   (_) __(_)
     / / / / __ \/ / /_/ /
    / /_/ / / / / / __/ /
    \____/_/ /_/_/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y apt-transport-https
      echo "Installed Dependencies"
    
      
      echo -e "deb http://ftp.debian.org/debian bullseye main" >/etc/apt/sources.list.d/openjdk-11-jre-headless.list
      apt-get update
      
    
      echo "Installing OpenJDK"
      apt-get install -y openjdk-11-jre-headless
      apt-mark hold openjdk-11-*
      echo "Installed OpenJDK"
    
      echo "Installing MongoDB"
      wget -qL http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
      wget -qL https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.23_amd64.deb
      dpkg -i mongodb-org-server_3.6.23_amd64.deb
      echo "Installed MongoDB"
    
      echo "Installing UniFi Network Application"
      wget -qO /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
      echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' >/etc/apt/sources.list.d/100-ubnt-unifi.list
      apt-get update
      apt-get install -y unifi
      echo "Installed UniFi Network Application"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __      _ _____
      / / / /__   (_) __(_)
     / / / / __ \/ / /_/ /
    / /_/ / / / / / __/ /
    \____/_/ /_/_/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
uptimekuma () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __      __  _                   __ __
      / / / /___  / /_(_)___ ___  ___     / //_/_  ______ ___  ____ _
     / / / / __ \/ __/ / __  __ \/ _ \   / ,< / / / / __  __ \/ __  /
    / /_/ / /_/ / /_/ / / / / / /  __/  / /| / /_/ / / / / / / /_/ /
    \____/ .___/\__/_/_/ /_/ /_/\___/  /_/ |_\__,_/_/ /_/ /_/\__,_/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      sudo apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Installing Uptime Kuma"
      git clone https://github.com/louislam/uptime-kuma.git
      mv uptime-kuma /opt/uptime-kuma
      cd /opt/uptime-kuma
      npm run setup
      echo "Installed Uptime Kuma"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
        __  __      __  _                   __ __
      / / / /___  / /_(_)___ ___  ___     / //_/_  ______ ___  ____ _
     / / / / __ \/ __/ / __  __ \/ _ \   / ,< / / / / __  __ \/ __  /
    / /_/ / /_/ / /_/ / / / / / /  __/  / /| / /_/ / / / / / / /_/ /
    \____/ .___/\__/_/_/ /_/ /_/\___/  /_/ |_\__,_/_/ /_/ /_/\__,_/
        /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
vaultwarden () {


      DISK_SIZE="6"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="4"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="4096"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _    __            ____ _       __               __
    | |  / /___ ___  __/ / /| |     / /___ __________/ /__  ____
    | | / / __ / / / / / __/ | /| / / __ / ___/ __  / _ \/ __ \
    | |/ / /_/ / /_/ / / /_ | |/ |/ / /_/ / /  / /_/ /  __/ / / /
    |___/\__,_/\__,_/_/\__/ |__/|__/\__,_/_/   \__,_/\___/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
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
      echo "Installed Dependencies"
    
      WEBVAULT=$(curl -s https://api.github.com/repos/dani-garcia/bw_web_builds/releases/latest |
        grep "tag_name" |
      awk '{print substr($2, 2, length($2)-3) }')
    
      VAULT=$(curl -s https://api.github.com/repos/dani-garcia/vaultwarden/releases/latest |
        grep "tag_name" |
      awk '{print substr($2, 2, length($2)-3) }')
    
      echo "Installing Rust"
      wget -qL https://sh.rustup.rs
      bash index.html -y --profile minimal
      echo "export PATH=~/.cargo/bin:$PATH" >>~/.bashrc
      export PATH=~/.cargo/bin:$PATH
      rm index.html
      echo "Installed Rust"
    
      echo "Building Vaultwarden ${VAULT} (Patience)"
      git clone https://github.com/dani-garcia/vaultwarden
      cd vaultwarden
      cargo build --features "sqlite,mysql,postgresql" --release
      echo "Built Vaultwarden ${VAULT}"
    
      addgroup --system vaultwarden
      adduser --system --home /opt/vaultwarden --shell /usr/sbin/nologin --no-create-home --gecos 'vaultwarden' --ingroup vaultwarden --disabled-login --disabled-password vaultwarden
      mkdir -p /opt/vaultwarden/bin
      mkdir -p /opt/vaultwarden/data
      cp target/release/vaultwarden /opt/vaultwarden/bin/
    
      echo "Downloading Web-Vault ${WEBVAULT}"
      curl -fsSLO https://github.com/dani-garcia/bw_web_builds/releases/download/"$WEBVAULT"/bw_web_"$WEBVAULT".tar.gz
      tar -xzf bw_web_"$WEBVAULT".tar.gz -C /opt/vaultwarden/
      echo "Downloaded Web-Vault ${WEBVAULT}"
    
      cat <<EOF >/opt/vaultwarden/.env
    ADMIN_TOKEN=''
    ROCKET_ADDRESS=0.0.0.0
    DATA_FOLDER=/opt/vaultwarden/data
    DATABASE_MAX_CONNS=10
    WEB_VAULT_FOLDER=/opt/vaultwarden/web-vault
    WEB_VAULT_ENABLED=true
EOF
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _    __            ____ _       __               __
    | |  / /___ ___  __/ / /| |     / /___ __________/ /__  ____
    | | / / __ / / / / / __/ | /| / / __ / ___/ __  / _ \/ __ \
    | |/ / /_/ / /_/ / / /_ | |/ |/ / /_/ / /  / /_/ /  __/ / / /
    |___/\__,_/\__,_/_/\__/ |__/|__/\__,_/_/   \__,_/\___/_/ /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################
    


#############################################################################################################################################################

########################################################################################################################
whisparr () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ____    _
    | |     / / /_  (_)________  ____  __________
    | | /| / / __ \/ / ___/ __ \/ __ / ___/ ___/
    | |/ |/ / / / / (__  ) /_/ / /_/ / /  / /
    |__/|__/_/ /_/_/____/ .___/\__,_/_/  /_/
                       /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y sqlite3
      echo "Installed Dependencies"
    
      echo "Installing Whisparr"
      mkdir -p /var/lib/whisparr/
      chmod 775 /var/lib/whisparr/
      wget --content-disposition 'https://whisparr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
      tar -xvzf Whisparr.develop.*.tar.gz
      mv Whisparr /opt
      chmod 775 /opt/Whisparr
      echo "Installed Whisparr"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ____    _
    | |     / / /_  (_)________  ____  __________
    | | /| / / __ \/ / ___/ __ \/ __ / ___/ ___/
    | |/ |/ / / / / (__  ) /_/ / /_/ / /  / /
    |__/|__/_/ /_/_/____/ .___/\__,_/_/  /_/
                       /_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
whoogle () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ____  ______  ____  ________    ______
    | |     / / / / / __ \/ __ \/ ____/ /   / ____/
    | | /| / / /_/ / / / / / / / / __/ /   / __/
    | |/ |/ / __  / /_/ / /_/ / /_/ / /___/ /___
    |__/|__/_/ /_/\____/\____/\____/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Updating Python3"
      apt-get install -y \
      python3 \
      python3-dev \
      python3-pip
      echo "Updated Python3"
    
      echo "Installing Whoogle"
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
      echo "Installed Whoogle"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ____  ______  ____  ________    ______
    | |     / / / / / __ \/ __ \/ ____/ /   / ____/
    | | /| / / /_/ / / / / / / / / __/ /   / __/
    | |/ |/ / __  / /_/ / /_/ / /_/ / /___/ /___
    |__/|__/_/ /_/\____/\____/\____/_____/_____/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


#############################################################################################################################################################

########################################################################################################################
wikijs () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ___ __   _     _
    | |     / (_) /__(_)   (_)____
    | | /| / / / //_/ /   / / ___/
    | |/ |/ / / ,< / /   / (__  )
    |__/|__/_/_/|_/_(_)_/ /____/
                     /___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_16.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Installing Wiki.js"
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
      echo "Installed Wiki.js"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ___ __   _     _
    | |     / (_) /__(_)   (_)____
    | | /| / / / //_/ /   / / ___/
    | |/ |/ / / ,< / /   / (__  )
    |__/|__/_/_/|_/_(_)_/ /____/
                     /___/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################

#############################################################################################################################################################

wireguard () {


      DISK_SIZE="2"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="1"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="512"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ___           ______                     __
    | |     / (_)_______  / ____/_  ______ __________/ /
    | | /| / / / ___/ _ \/ / __/ / / / __ / ___/ __  /
    | |/ |/ / / /  /  __/ /_/ / /_/ / /_/ / /  / /_/ /
    |__/|__/_/_/   \___/\____/\__,_/\__,_/_/   \__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gunicorn
      echo "Installed Dependencies"
    
      echo "Installing WireGuard (using pivpn.io)"
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
      echo "Installed WireGuard"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _       ___           ______                     __
    | |     / (_)_______  / ____/_  ______ __________/ /
    | | /| / / / ___/ _ \/ / __/ / / / __ / ___/ __  /
    | |/ |/ / / /  /  __/ /_/ / /_/ / /_/ / /  / /_/ /
    |__/|__/_/_/   \___/\____/\__,_/\__,_/_/   \__,_/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################

#############################################################################################################################################################


yunohost () {


      DISK_SIZE="20"
      msg_info "Suggested Disk: 2$DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="2048"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
     __  __                  __  __           __
    \ \/ /_  ______  ____  / / / /___  _____/ /_
     \  / / / / __ \/ __ \/ /_/ / __ \/ ___/ __/
     / / /_/ / / / / /_/ / __  / /_/ (__  ) /_
    /_/\__,_/_/ /_/\____/_/ /_/\____/____/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y gnupg
      apt-get install -y apt-transport-https
      apt-get install -y lsb-release
      apt-get install -y ca-certificates
      echo "Installed Dependencies"
    
      echo "Installing YunoHost (Patience)"
      curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
      bash <(curl -fsSL https://install.yunohost.org) -a
      echo "Installed YunoHost"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
     __  __                  __  __           __
    \ \/ /_  ______  ____  / / / /___  _____/ /_
     \  / / / / __ \/ __ \/ /_/ / __ \/ ___/ __/
     / / /_/ / / / / /_/ / __  / /_/ (__  ) /_
    /_/\__,_/_/ /_/\____/_/ /_/\____/____/\__/
    
      Wesh Alors Prod - zshmeta' | lolcat
}
#####################################################################################################################################################


########################################################################################################################
zigbee2mqtt () {


      DISK_SIZE="4"
      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _____   _       __             ___   __  _______  ____________
    /__  /  (_)___ _/ /_  ___  ___ |__ \ /  |/  / __ \/_  __/_  __/
      / /  / / __  / __ \/ _ \/ _ \__/ // /|_/ / / / / / /   / /
     / /__/ / /_/ / /_/ /  __/  __/ __// /  / / /_/ / / /   / /
    /____/_/\__, /_.___/\___/\___/____/_/  /_/\___\_\/_/   /_/
           /____/ 🐝
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      apt-get install -y git
      apt-get install -y make
      apt-get install -y g++
      apt-get install -y gcc
      echo "Installed Dependencies"
    
      echo "Setting up Node.js Repository"
      bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
      echo "Set up Node.js Repository"
    
      echo "Installing Node.js"
      apt-get install -y nodejs
      echo "Installed Node.js"
    
      echo "Setting up Zigbee2MQTT Repository"
      git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
      echo "Set up Zigbee2MQTT Repository"
    
      read -r -p "Switch to Edge/dev branch? (y/N) " prompt
      if [[ $prompt == "y" ]]; then
        DEV="y"
      else
        DEV="n"
      fi
    
      echo "Installing Zigbee2MQTT"
      cd /opt/zigbee2mqtt
      if [[ $DEV == "y" ]]; then
        git checkout dev
      fi
      npm ci
      echo "Installed Zigbee2MQTT"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _____   _       __             ___   __  _______  ____________
    /__  /  (_)___ _/ /_  ___  ___ |__ \ /  |/  / __ \/_  __/_  __/
      / /  / / __  / __ \/ _ \/ _ \__/ // /|_/ / / / / / /   / /
     / /__/ / /_/ / /_/ /  __/  __/ __// /  / / /_/ / / /   / /
    /____/_/\__, /_.___/\___/\___/____/_/  /_/\___\_\/_/   /_/
           /____/ 🐝
    
      Wesh Alors Prod - zshmeta' | lolcat


}


########################################################################################################################
#############################################################################################################################################################

####################################################################################################################################################

zwave() {


      msg_info "Suggested Disk: $DISK_SIZE"
      CORE_UNIT="2"
      msg_info "Suggested CPU: $CORE_UNIT"
      RAM_SIZE="1024"
      msg_info "Suggested RAM: $RAM_SIZE"
      OS_TYPE="debian"
      msg_warn "This app is meant to run on $OS_TYPE"    
      echo "$OS_TYPE $DISK_SIZE $CORE_UNIT $RAM_SIZE $\"$APPS\"port" 

      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _____                                  _______    __  ______
    /__  /_      ______ __   _____         / / ___/   / / / /  _/
      / /| | /| / / __ / | / / _ \   __  / /\__ \   / / / // /
     / /_| |/ |/ / /_/ /| |/ /  __/  / /_/ /___/ /  / /_/ // /
    /____/__/|__/\__,_/ |___/\___/   \____//____/   \____/___/
    
      Wesh Alors Prod - zshmeta' | lolcat
    
    
      apt-get install -y curl
      apt-get install -y sudo
      apt-get install -y mc
      echo "Installed Dependencies"
    
      echo "Installing Z-Wave JS UI"
      mkdir /opt/zwave-js-ui
      cd /opt/zwave-js-ui
      RELEASE=$(curl -s https://api.github.com/repos/zwave-js/zwave-js-ui/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3) }')
      wget https://github.com/zwave-js/zwave-js-ui/releases/download/"${RELEASE}"/zwave-js-ui-"${RELEASE}"-linux.zip
      unzip zwave-js-ui-"${RELEASE}"-linux.zip
      echo "Installed Z-Wave JS UI"
    
      echo "Creating Service"
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
      echo "Created Service"
    
      figlet -t -c -W -w 150 -f term 'by zshmeta - Le Z c le S
    
      _____                                  _______    __  ______
    /__  /_      ______ __   _____         / / ___/   / / / /  _/
      / /| | /| / / __ / | / / _ \   __  / /\__ \   / / / // /
     / /_| |/ |/ / /_/ /| |/ /  __/  / /_/ /___/ /  / /_/ // /
    /____/__/|__/\__,_/ |___/\___/   \____//____/   \____/___/
    
      Wesh Alors Prod - zshmeta' | lolcat


}

