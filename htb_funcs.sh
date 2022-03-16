#!/bin/bash

#  _   _            _    _____ _          ____            
# | | | | __ _  ___| | _|_   _| |__   ___| __ )  _____  __
# | |_| |/ _` |/ __| |/ / | | | '_ \ / _ \  _ \ / _ \ \/ /
# |  _  | (_| | (__|   <  | | | | | |  __/ |_) | (_) >  < 
# |_| |_|\__,_|\___|_|\_\ |_| |_| |_|\___|____/ \___/_/\_\
#  _____                 _   _                 
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#
# A bunch of useful functions for hacking on HackTheBox

# TODO: htbinit - Make it check for .init file created by htbinitfile()

target_file=".target"
init_file=".init"

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

htbinitfile () {
    if [ -n "$1" ]; then
        if [ -e $1 ]; then
            echo $1 > $init_file
            echo "[*] Set VPN File Path..."
            echo ""
         else
             echo "[*] File Does Not Exists..."
             echo ""
             return 1
         fi
    else
        if [ -e $init_file ]; then
            cat $init_file
        else
            echo "[*] VPN File Path Not Set..."
            echo ""
            return 1
        fi
    fi
}

htbinit () {
    pidof openvpn >/dev/null
    if [ $? -eq 1 ]; then
        sudo --background openvpn $(cat $init_file) &>/dev/null
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
