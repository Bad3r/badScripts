#! /bin/python3
import os
import socket
import sys
from shlex import quote

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
    os.system(command)
    print("[*] Done!")

if __name__ == "__main__":
    main()