#!/bin/bash
#  _   _            _    _____ _          ____              _____                 _   _                 
# | | | | __ _  ___| | _|_   _| |__   ___| __ )  _____  __ |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
# | |_| |/ _` |/ __| |/ / | | | '_ \ / _ \  _ \ / _ \ \/ / | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _  | (_| | (__|   <  | | | | | |  __/ |_) | (_) >  <  |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_| |_|\__,_|\___|_|\_\ |_| |_| |_|\___|____/ \___/_/\_\ |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#
# A bunch of useful functions for hacking on HackTheBox
#TODO: htbinitfile - Function to set path for .ovpn file used for connection

target_file=".target"

htbhost () {
    ip=$(ip a show tun0 2>/dev/null | grep inet | head -1 | awk '{print $2}' | sed s/...$//)

    if [ -n "$ip" ]; then
        echo $ip
    else
        echo "[*] You Do Not Seem To Be Connected To The VPN..."
    fi
}

htbtarget () {
    pidof openvpn >/dev/null
    if [ $? -eq 1 ];then
        echo "[*] OpenVPN Session Not Running..."
        return 1
    fi

    if [ -n "$1" ]; then
        echo $1 > $target_file
        echo "[*] Set HTB Target..."
    else
        if [ -e $target_file ]; then
            cat $target_file
        else
            echo "[*] Please Set Target..."
        fi
    fi
}

htbinit () {
    pidof openvpn >/dev/null
    if [ $? -eq 1 ]; then
        sudo --background openvpn $HOME/Downloads/lab_advenabl.ovpn &>/dev/null
        echo "[*] Initiated Connection..."
        echo ""
    else
        echo "[*] OpenVPN is Already Running..."
        return 1
    fi
}

htbkill () {
    pid=$(pidof openvpn)
    if [ $? -eq 1 ]; then
        echo "[*] No OpenVPN Session Running..."
        echo ""
        return 1
    else
        echo "[*] Killing OpenVPN PID: $pid"
        echo ""
        sudo kill -SIGKILL $pid

        if [ -e $target_file ]; then
            rm $target_file
        fi
    fi
}
