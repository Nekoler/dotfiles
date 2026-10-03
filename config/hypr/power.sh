#!/bin/sh
output=$(hyprland-dialog --title "Power Control" \
	--text "Select an Operation" \
	--buttons Suspend \
	--buttons Poweroff \
	--buttons Reboot \
	--buttons Cancel)
case "${output}" in
"Suspend")
	systemctl suspend
	exit
	;;
"Poweroff")
	hyprshutdown
	systemctl poweroff
	exit
	;;
"Reboot")
	hyprshutdown
	systemctl reboot
	exit
	;;
esac
