init:
	echo $(password) | sudo -S xcode-select --install
	# TODO(lukaszwieczorek): Install fish too.
	# https://github.com/fish-shell/fish-shell/releases/download/4.3.3/fish-4.3.3.pkg

update:
	echo $(password) | sudo -S softwareupdate --background

needs-restarting:
	echo $(password) | sudo -S /usr/local/bin/fish ./needs_restarting.fish
