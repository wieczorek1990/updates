#!/usr/bin/env fish
# Searches for IP from MAC address.

set argc (count $argv)
if [ $argc -ne 1 ]
    echo "Usage:\t./mac-to-ip.fish \$MAC"
end
set mac $argv[1]
set broadcast_ip "192.168.8.255"

echo "Looking for MAC address $mac..."
echo "Broadcasting..."
ping $broadcast_ip -c 1
echo "Calling arp..."
begin
    set -l IFS
    set arp_result (arp -a | cut -d' ' -f2,4 | sed 's/(//;s/)//')
end
echo "Looking for MAC address in arp result..."
set ip_with_mac (echo $arp_result | grep $mac)
if [ $status -eq 0 ]
    set ip (echo $ip_with_mac | cut -d' ' -f1)
    echo "Found IP: $ip"
else
    echo 'IP not found.'
    exit 1
end
