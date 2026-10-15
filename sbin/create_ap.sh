#!/usr/bin/sh
PHYIFACE=wlp0s20f3
VIRTIFACE=ap0

if ip link show "${PHYIFACE}" | grep "state UP mode"; then
	iw dev "${PHYIFACE}" interface add "${VIRTIFACE}" type __ap
	nmcli device set "${VIRTIFACE}" managed no
	ip addr add 192.168.1.1/24 dev "${VIRTIFACE}"
	firewall-cmd --zone=public --add-masquerade
	firewall-cmd --zone=trusted --add-interface="${VIRTIFACE}"
	firewall-cmd --zone=trusted --add-forward
	CHANNEL=$(iw "${PHYIFACE}" info | grep channel | awk '{print $2}')

	APCONFIG="
channel=${CHANNEL}
driver=nl80211
hw_mode=g
interface=${VIRTIFACE}
rsn_pairwise=CCMP
ssid=DESKTOP
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
wpa_passphrase=12345678w
wpa=3
"

	DHCPCONFIG="
bind-interfaces
dhcp-option=3,192.168.1.1
dhcp-range=192.168.1.2,192.168.1.254,255.255.255.0
interface=${VIRTIFACE}
"
	echo "${APCONFIG}" | hostapd /dev/stdin &
	echo "${DHCPCONFIG}" | dnsmasq --conf-file=/dev/stdin --no-daemon &
	trap 'break' INT
	while true; do
		read _
	done
	trap - INT
	killall hostapd dnsmasq 2> /dev/null
	firewall-cmd --reload
	ip addr del 192.168.1.1/24 dev "${VIRTIFACE}"
	iw dev "${VIRTIFACE}" del
else
	nmcli connection up Hotspot
	trap 'break' INT
	while true; do
		read _
	done
	trap - INT
	nmcli connection down Hotspot
fi
