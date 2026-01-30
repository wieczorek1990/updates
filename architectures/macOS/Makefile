init:
	echo $(password) | sudo -S xcode-select --install

update:
	echo $(password) | sudo -S softwareupdate --background

needs-restarting:
	echo $(password) | sudo -S /usr/local/bin/fish ./needs_restarting.fish
