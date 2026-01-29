#!/usr/bin/env fish
# Pushes the chosen Makefile script and runs it for correct architecture.

set dir (status dirname)
cd $dir/..

echo "Starting from: "(pwd)

set username "administrator"
echo "Administrator name is:" $username

set servers (cat servers.tsv)
echo "Loaded servers in count:" (count $servers)

echo

echo "Processing servers..."
for server in $servers
    set host_name (echo $server | cut -d\t -f1)
    set host_architecture (echo $server | cut -d\t -f2)
    set host_mac (echo $server | cut -d\t -f3)

    echo "Host name:" $host_name
    echo "Host architecture:" $host_architecture
    echo "Host MAC address:" $host_mac

    echo "Querying host through MAC address to IP..."
    set ip_result (./bin/mac_to_ip.fish $host_mac)
    if [ $status -ne 0 ]
        echo "Failed to query host:" $host_name
        fish
        exit 1
    end
    set host_ip (echo $ip_result | tail -n 1)
    echo "Host IP address:" $host_ip

    echo "Setting DSN..."
    set dsn "$username@$host_ip"
    echo "DSN is $dsn"

    echo "Sending make script..."
    scp "./architectures/$host_architecture/Makefile" "$dsn:Makefile"
    echo "Sending bin scripts..."
    scp "./architectures/$host_architecture/needs_restarting.fish" "$dsn:needs_restarting.fish"

    echo "Running updates..."
    ssh -t "$dsn" "make update"

    echo "Running needs-restarting..."
    ssh -t "$dsn" "make needs-restarting"

    echo
end

echo
echo "Done."
