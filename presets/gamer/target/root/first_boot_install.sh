depmod

echo "Enter root password"
passwd

locale-gen
mkdir -p /var/cache/
fc-cache # create /var/cache/fontconfig
ldconfig --ignore-aux-cache # create /etc/ld.so.cache and /var/cache/ldconfig/aux-cache

fdisk -l
echo '#UUID=bfb6c646-a609-4ea6-841e-1cada65e4c5d /data ext2 nosuid,nodiratime,noatime 0 0' >> /etc/fstab
echo "Check partitions, resize2fs, fstab, etc. Type exit when done"
sh
mkdir -p /data/{dwn,steam}

wget -i nvidia.download
sh NVIDIA-Linux-*.run
pacman -Sy --overwrite="*" steam

useradd -m -U -s /bin/bash dan
echo "New password for dan"
passwd dan
for user in dan; do
    usermod -aG tty,video,audio,input $user
    chown -R $user:$user "/home/$user"
done

# Desktop entries
rm -rf /usr/local/share/*
pushd /usr/share/applications || exit 1
    rm -rf *

    printf '[Desktop Entry]
Name=Firefox
Exec=firefox
Type=Application
' > firefox.desktop

    printf '[Desktop Entry]
Name=Steam
Exec=steam -no-cef-sandbox
Type=Application
' > steam.desktop

    chmod o+r *.desktop
popd

# Fix permissions
chmod -R o-rwx /root/
chmod -R o+rX /etc/X11/
chmod -R o+r /etc/pulse/
chmod -R o+r /usr/share/
chmod o+r /etc/resolv.conf

echo "Done, pls reboot"
