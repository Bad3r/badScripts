#!/bin/bash
# USAGE: ./pingsweep.sh 192.168.1 
# the scrip will ping the IPs range 192.168.1.1-192.168.1.254
# and returns live hosts

for ip in $(seq 1 254); do
ping -c 1 "$1.$ip" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done