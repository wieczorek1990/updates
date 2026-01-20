#!/usr/bin/env fish
# Pushes the chosen Makefile script and runs it for correct architecture.

set dir (status dirname)
set username 'administrator'
cd $dir/..

echo 'Starting from: '(pwd)
set servers (cat servers.tsv)
echo 'Loaded servers.'
echo
for server in $servers
    set ip (echo $server | cut -d\t -f1)
    set arch (echo $server | cut -d\t -f2)
    echo "Architecture: $arch"
    echo "IP: $ip"
    echo 'Sending make script.'
    scp "./architectures/$arch/Makefile" "$username@$ip:Makefile"
    ssh -t "$username@$ip" "make install"
    echo
end
echo 'Done.'
