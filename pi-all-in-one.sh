#!/bin/bash



PRIMARY_WIFI_SSID="Your SSID" 
PRIMARY_WIFI_PASS="Your wifi password"

SECONDARY_WIFI_SSID="Backup SSID"
SECONDARY_WIFI_PASS="Backup password"

ETH_IF="eth0"
ETH_IP="192.168.50.1"

WIFI_IF="wlan0"



connect_wifi() {

    SSID="$1"
    PASS="$2"

    echo "[*] Attempting WiFi connection to $SSID"

    nmcli dev wifi connect "$SSID" password "$PASS" ifname $WIFI_IF > /dev/null 2>&1

}

setup_eth() {

    CURRENT_IP=$(ip -4 addr show $ETH_IF | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    if [ "$CURRENT_IP" != "$ETH_IP" ]; then

        echo "[*] Configuring Ethernet $ETH_IF -> $ETH_IP"

        ip addr flush dev $ETH_IF
        ip addr add $ETH_IP/24 dev $ETH_IF
        ip link set $ETH_IF up

    fi

}

enable_ip_forwarding() {

    sysctl -w net.ipv4.ip_forward=1 > /dev/null

}

setup_nat() {

    iptables -t nat -C POSTROUTING -o $WIFI_IF -j MASQUERADE 2>/dev/null || \
    iptables -t nat -A POSTROUTING -o $WIFI_IF -j MASQUERADE

    iptables -C FORWARD -i $WIFI_IF -o $ETH_IF -m state --state RELATED,ESTABLISHED -j ACCEPT 2>/dev/null || \
    iptables -A FORWARD -i $WIFI_IF -o $ETH_IF -m state --state RELATED,ESTABLISHED -j ACCEPT

    iptables -C FORWARD -i $ETH_IF -o $WIFI_IF -j ACCEPT 2>/dev/null || \
    iptables -A FORWARD -i $ETH_IF -o $WIFI_IF -j ACCEPT

}

internet_check() {

    ping -c 2 -W 2 8.8.8.8 > /dev/null 2>&1

}



echo "[*] Starting Pi gateway service"

setup_eth
enable_ip_forwarding
setup_nat



while true
do

    if internet_check
    then

        echo "[+] Internet connection active"

    else

        echo "[!] Internet down — reconnecting WiFi"

        connect_wifi "$PRIMARY_WIFI_SSID" "$PRIMARY_WIFI_PASS"

        sleep 5

        if ! internet_check
        then
            echo "[!] Primary WiFi failed — trying secondary"
            connect_wifi "$SECONDARY_WIFI_SSID" "$SECONDARY_WIFI_PASS"
        fi

    fi

    sleep 30

done
