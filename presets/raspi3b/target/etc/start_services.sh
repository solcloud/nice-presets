#!/bin/sh

if [ -r /debootstrap/ ]; then
    echo "Doing debootstrap second stage first install"
    rm -rf /var/run && mkdir -p /var/run
    /debootstrap/debootstrap --second-stage || cat /debootstrap/debootstrap.log
    rm -rf /debootstrap/
fi

sleep 2 && /etc/init/network.sh usb0 &> /dev/null
chmod 0600 /etc/ssh/ssh_host*
mkdir -p /var/chroot/ssh
while true; do /bin/sshd -D &> /dev/null ; sleep 30; done &
