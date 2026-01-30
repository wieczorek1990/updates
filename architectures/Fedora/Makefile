init:
	echo $(password) | sudo -S dnf install --assumeyes make fish
	echo $(password) | sudo ln -fs /usr/bin/fish /usr/local/bin/fish

update:
	echo $(password) | sudo -S dnf upgrade --assumeyes --refresh

needs-restarting:
	echo $(password) | sudo -S /usr/local/bin/fish ./needs_restarting.fish
