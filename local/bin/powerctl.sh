#!/usr/bin/sh
output=$(
	hyprland-dialog --title "Power Control" \
		--apptitle "Power Control for Hyprland" \
		--text "Select an Operation" \
		--buttons "Reboot;Poweroff;Suspend;Logout;Cancel"
)
case "${output}" in
	"Reboot")
		exec hyprshutdown --post-cmd "exec systemctl reboot"
		;;
	"Poweroff")
		exec hyprshutdown --post-cmd "exec systemctl poweroff"
		;;
	"Suspend")
		exec systemctl suspend
		;;
	"Logout")
		exec hyprshutdown
		;;
esac
