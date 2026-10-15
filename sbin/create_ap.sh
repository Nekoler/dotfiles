#!/usr/bin/sh
GATEWAY=192.168.1.1/16
HWMODE=g
PASSWD=12345678w
PHYIFACE=wlp0s20f3
SSID=DESKTOP
VIRTIFACE=ap0

APCONFIG="
channel=%s
driver=nl80211
hw_mode=%s
interface=%s
ssid=%s
wpa_passphrase=%s
wpa=3
"

DHCPCONFIG="
bind-interfaces
dhcp-option=3,%s
dhcp-range=%s,%s
interface=%s
"
block() {
	trap 'break' INT
	while true; do
		read _
	done
	trap - INT
}
if ip link show "${PHYIFACE}" | grep "state UP mode"; then
	iw dev "${PHYIFACE}" interface add "${VIRTIFACE}" type __ap
	nmcli device set "${VIRTIFACE}" managed no
	ip addr add "${GATEWAY}" dev "${VIRTIFACE}"
	firewall-cmd --zone=public --add-masquerade
	firewall-cmd --zone=trusted --add-interface="${VIRTIFACE}"
	firewall-cmd --zone=trusted --add-forward
	CHANNEL=$(iw "${PHYIFACE}" info | grep channel | awk '{print $2}')

	PREFIX="${GATEWAY%.*}"
	printf "${APCONFIG}" "${CHANNEL}" "${HWMODE}" "${VIRTIFACE}" "${SSID}" "${PASSWD}" | hostapd /dev/stdin &
	printf "${DHCPCONFIG}" "${GATEWAY%/16}" "${PREFIX}.2" "${PREFIX}.254" "${VIRTIFACE}" | dnsmasq --conf-file=/dev/stdin --no-daemon &

	block

	killall hostapd dnsmasq 2> /dev/null
	firewall-cmd --reload
	ip addr del "${GATEWAY}" dev "${VIRTIFACE}"
	iw dev "${VIRTIFACE}" del
else
	nmcli connection up Hotspot
	block
	nmcli connection down Hotspot
fi
