#!/bin/sh

sleep 2 && /etc/init/network.sh usb0 &> /dev/null
chmod 0600 /etc/ssh/ssh_host*
mkdir -p /var/chroot/ssh
while true; do /bin/sshd -D &> /dev/null ; sleep 30; done &
