init:
	echo $(password) | sudo -S dnf install --assumeyes make

update:
	echo $(password) | sudo -S dnf upgrade --assumeyes --refresh

needs-restarting:
	echo $(password) | sudo -S fish ./needs_restarting.fish
