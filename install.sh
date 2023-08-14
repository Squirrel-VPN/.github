#!/bin/bash

echo -e "\033[2J\033[3;1f"

printf "\n\n\033[1;35mPerfomanceVPN ✨\033[0m"

echo -e "\n\n\033[0;96mInstalling base packages...\033[0m"

eval "apt update -y && apt upgrade -y && apt install net-tools -y"

echo -e "\n\n\033[0;96mInstalling Docker...\033[0m"

eval "curl -sSL https://get.docker.com | sh"

IP=$(hostname -I)
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')

echo -e "\n\n\033[0;96mIP: $IP Password: $PASSWORD \033[0m"

echo -e "\n\n\033[0;96mStarting WireGuard...\033[0m"

eval "docker run -d --name=wg-easy -e WG_HOST=$IP -e PASSWORD=$PASSWORD -v ~/.wg-easy:/etc/wireguard -p 51820:51820/udp -p 51821:51821/tcp --cap-add=NET_ADMIN --cap-add=SYS_MODULE --sysctl=\"net.ipv4.conf.all.src_valid_mark=1\" --sysctl=\"net.ipv4.ip_forward=1\" --restart unless-stopped weejewel/wg-easy"

echo -e "\n\n\033[0;96mSend to backend new server...\033[0m"

eval "curl http://212.118.53.75:8000/api/user/create_server/$IP/$PASSWORD"

echo -e "\n\n\033[0;96mComplete 🔌 \033[0m"
