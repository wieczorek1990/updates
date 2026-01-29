#!/usr/bin/env fish
# Searches for IP from MAC address.

set argc (count $argv)
if [ $argc -ne 1 ]
    exit 1
end
set mac $argv[1]
set broadcast_ip "192.168.8.255"

ping $broadcast_ip -c 1 > /dev/null
begin
    set -l IFS
    set arp_result (arp -a | cut -d' ' -f2,4 | sed 's/(//;s/)//')
end

set ip_with_mac (echo $arp_result | grep $mac)
if [ $status -ne 0 ]
    exit 1
end

set ip (echo $ip_with_mac | cut -d' ' -f1)

# Result
echo $ip
