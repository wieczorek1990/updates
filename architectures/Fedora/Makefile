init:
	sudo dnf install --assumeyes make

update:
	sudo dnf upgrade --assumeyes --refresh

needs-restarting:
	sudo dnf needs-restarting
	if [ $? -eq 0 ]; then
		echo "No updates needed."
	else
		echo "Updates available."
		sudo reboot
	fi
