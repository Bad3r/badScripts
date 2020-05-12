#! /bin/python3
import os
import socket
import sys
from shlex import quote

# simple script given a box name and IP address
# the script will create a folder for the box  and a sub folder called recon
# it will also add an entery into /etc/hosts
# ex: 10.10.10.188 cache.htb
# to use the script change the path your HTB home directory
# by modifiying the variable "directory"
# USAGE: ./htb_init.py
# NOTE: the script requires admin priviliege to append to etc/hosts

def main():
    box = input("[!] Enter Box name: ").strip()
    boxIP = input("[!] Enter Box IP: ").strip()
    boxIP = quote(boxIP)
    box = quote(box)
    directory = f"/root/htb/{box}"
    reconDIR = f"{directory}/recon"
    hostname = f"{box}.htb"

    try:
        socket.inet_aton(boxIP)
    except socket.error:
        sys.exit("[!] IP address not valid!")

    print(f"Creating folder {directory}..")
    if not os.path.exists(directory):
        os.makedirs(directory)
        os.makedirs(reconDIR)
        print("[*] Done!")


    print(f"[*] Adding host: {hostname} IP: {boxIP} to /etc/hosts..")
    command = f"echo '{boxIP} {box.lower()}.htb' >> /etc/hosts"
    os.system(quote(command))
    print("[*] Done!")

if __name__ == "__main__":
    main()