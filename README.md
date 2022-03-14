# HackTheBox Functions
## Description:
A list of command line bash functions which help to manage HackTheBox VPN connections

## Available Functions:
### htbhost
- Check if `tun0` device is available if so return inet address

### htbtarget
- Expects an IP to be passed in. Once passe in it write IP to a file.
- If no value is passed in and the file it created is avail, return IP in file

### htbinit
- Initiate connection in background using a .ovpn file


### htbkill
- Kill the OpenVPN session by sending `SIGKILL` signal
- Also deletes file created by `htbtarget` function if found
