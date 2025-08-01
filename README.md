# HackTheBox Lab Helper

A collection of useful functions for hacking on HackTheBox, all contained in a single bash script.

Assumes HackTheBox VPN session to be the ONLY VPN session.

## Functions
- `htbinitfile`: Sets or prints the path of the OpenVPN config file to use for connecting to the HackTheBox VPN
- `htbinit`: Initiates a connection to the HackTheBox VPN using the specified OpenVPN config file
- `htbhost`: Prints the IP of the current HackTheBox VPN connection
- `htbtarget`: Sets or prints the current HackTheBox target
- `htbkill`: Terminates the current HackTheBox VPN connection and resets the target file


## Installation
### Getting files
Download bash file to desired location
```shell
$ git clone git@github.com:algowful/htbfuncs.git
```
### Adding to bashrc
Edit `~/.bashrc` file with following line:
```shell
source <path to htbfuncs>
```


## Usage
```text
$ htbinitfile ~/Documents/lab.ovpn
[*] Init File Path Set

$ htbinitfile
/home/user/Documents/lab.ovpn

$ htbinit
[sudo] password for user: 
[*] Initiated Connection...

$ htbhost
10.10.14.7

$ htbtarget 10.10.14.9
[*] Set HTB Target...

$ htbtarget
10.10.14.9

$ htbkill
[*] Killing OpenVPN PID: 300243
[sudo] password for user:
```
