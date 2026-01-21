#!/usr/bin/env fish
# Pushes the chosen Makefile script and runs it for correct architecture.

set dir (status dirname)
cd $dir/..

echo 'Starting from: '(pwd)
set username 'administrator'
echo "Administrator name is: $username"
set servers (cat servers.tsv)
echo 'Loaded servers in count: '(count servers)
echo

echo 'Processing servers...'
for server in $servers
    set host_name (echo $server | cut -d\t -f1)
    set host_architecture (echo $server | cut -d\t -f2)
    echo "Hostname: $host_name"
    echo "Host architecture: $host_architecture"
    echo 'Sending make script...'
    scp "./architectures/$host_architecture/Makefile" "$username@$host_name:Makefile"
    echo 'Running make...'
    ssh -t "$username@$host_name" "make update"
    echo 'Cleaning...'
    ssh -t "$username@$host_name" "rm Makefile"
    echo
end
echo 'Done.'
