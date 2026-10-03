#!/usr/bin/sh
output=$(
	hyprland-dialog --title "Power Control" \
		--text "Select an Operation" \
		--buttons Reboot \
		--buttons Poweroff \
		--buttons Suspend \
		--buttons Logout \
		--buttons Cancel
)
case "${output}" in
"Reboot")
	hyprshutdown
	exec systemctl reboot
	;;
"Poweroff")
	hyprshutdown
	exec systemctl poweroff
	;;
"Suspend")
	exec systemctl suspend
	;;
"Logout")
	exec hyprshutdown
	;;
esac
