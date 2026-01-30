init:
	echo $(password) | sudo -S dnf install --assumeyes make fish

update:
	echo $(password) | sudo -S dnf upgrade --assumeyes --refresh

needs-restarting:
	echo $(password) | sudo -S /usr/bin/env fish ./needs_restarting.fish
