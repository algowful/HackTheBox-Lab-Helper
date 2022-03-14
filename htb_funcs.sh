#!/bin/bash
# A bunch of useful functions for hacking on HackTheBox

target_file=".target"

htbhost () {
    ip=$(ip a show tun0 2>/dev/null | grep inet | head -1 | awk '{print $2}' | sed s/...$//)

    if [ -n "$ip" ]; then
        echo $ip
    else
        echo "[*] You Do Not Seem To Be Connected To The VPN..."
    fi
}

# TODO: Add a check to see if openvpn is even running
htbtarget () {
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
    isRunning=$(pidof openvpn)

    if [ -n "$isRunning" ]; then
        echo "[*] OpenVPN is Already Running..."
    else 
        sudo --background openvpn $HOME/Downloads/lab_advenabl.ovpn &>/dev/null
        echo "[*] Initiated Connection..."
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
