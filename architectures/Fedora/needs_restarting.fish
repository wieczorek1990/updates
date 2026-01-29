#!/usr/bin/env fish

dnf needs-restarting
if [ $status -eq 0 ]
    echo "No updates needed."
else
    echo "Updates available."
    reboot
end
