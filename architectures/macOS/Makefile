init:
	echo $(password) | sudo -S xcode-select --install
	# TODO(lukaszwieczorek): Install fish too.

update:
	echo $(password) | sudo -S softwareupdate --background

needs-restarting:
	echo $(password) | sudo -S /usr/bin/env fish ./needs_restarting.fish
