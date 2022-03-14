# HackTheBox Functions

## Description:
A list of command line functions which help to manage HackTheBox VPN connections

## Available Functions:
### htbhost
- If the `tun0` interface is up -> Return the IPv4 address for the interface.

### htbtarget
- If IP value is passed -> Write to `.target` file.
- If no value is passed -> Return value in `.target` file.

### htbinit
- If OpenVPN proccess not already running -> Initiate OpenVPN session in background

### htbkill
- If OpenVPN proccess is running -> Send `SIGKILL` signal to OpenVPN procces PID.

## Setup:
Source the bash script in your `~/.bashrc` file: `source <Path to Script>`
