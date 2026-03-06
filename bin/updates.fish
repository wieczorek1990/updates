#!/usr/bin/env fish
# Pushes the chosen updates scripts and runs them for correct architecture.

set dir (status dirname)
cd $dir/..

set argc (count $argv)
if [ $argc -ne 1 ]
    echo -e "Usage:\tupdates.fish <servers.tsv>"
    exit 1
end
set servers_file $argv[1]
echo "Servers file is:" $servers_file

echo "Starting from:" (pwd)
echo "Running as:" (whoami)

set username "administrator"
echo "Administrator name is:" $username

echo "$username password is: "
read --silent password
export SSHPASS="$password"

set servers (cat $servers_file)
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
        exit 1
    end
    set host_ip (echo $ip_result | tail -n 1)
    echo "Host IP address:" $host_ip

    echo "Setting account details..."
    set account_details "$username@$host_ip"
    echo "Account details are:" $account_details

    echo "Sending make script..."
    sshpass -e scp \
        "./architectures/$host_architecture/Makefile" \
        "$account_details:Makefile"

    echo "Sending scripts..."
    sshpass -e scp \
        "./architectures/$host_architecture/needs_restarting.fish" \
        "$account_details:needs_restarting.fish"

    echo "Running updates..."
    sshpass -e ssh "$account_details" "make update password=$password"

    echo "Running needs-restarting..."
    sshpass -e ssh "$account_details" "make needs-restarting password=$password"

    echo
end

echo "Done."
