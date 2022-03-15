#!/bin/bash
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
    htbPID=$(pidof openvpn)
    if [ -n "$htbPID" ]; then
        echo "[*] Killing OpenVPN PID: $htbPID"
        sudo kill -9 $htbPID
    else
        echo "[*] No OpenVPN Session..."
    fi

    if [ -e $target_file ]; then
        rm $target_file
    fi
}
