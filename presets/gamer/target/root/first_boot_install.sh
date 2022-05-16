depmod

echo "Enter root password"
passwd

locale-gen
mkdir -p /var/cache/
fc-cache # create /var/cache/fontconfig
ldconfig --ignore-aux-cache # create /etc/ld.so.cache and /var/cache/ldconfig/aux-cache

fdisk -l
echo "Create additional partitions, mount it (/data, /home, /code) type exit when done"
sh
mkdir -p /data/{dwn,desk,store}

USERS="dan"
for user in $USERS; do
    useradd -m -U -s /bin/bash $user && printf "$user\n$user" | passwd $user
    echo "" > "/home/$user/.bashrc"
    echo ". /etc/environment" >> "/home/$user/.bashrc"
    echo ". /etc/profile" >> "/home/$user/.bashrc"
    ln -sf "/home/$user/.bashrc" "/home/$user/.bash_profile"
done

for user in dan; do
    usermod -aG tty,video,audio,input $user # Allow tty and Xorg (gpu,audio,input) login
    mkdir -p /home/$user/.config/
    cp -r /root/.config/* /home/$user/.config/
    cp /root/.xinitrc /home/$user/
    rm /home/$user/.bash_profile
    echo 'trap ec ERR' >> /home/$user/.bashrc
    printf '
. ~/.bashrc

if [[ "$(tty)" = "/dev/tty1" ]]; then
    exec xinit
fi
' > /home/$user/.bash_profile
done

for user in $USERS; do
    chown -R $user:$user "/home/$user"
done

# Desktop entries
rm -rf /usr/local/share/*
pushd /usr/share/applications || exit 1
    rm -rf *

    printf '[Desktop Entry]
Name=Firefox
Exec=firefox
' > firefox.desktop

    printf '[Desktop Entry]
Name=Steam
Exec=steam -no-cef-sandbox
' > steam.desktop

    chmod o+r *.desktop
popd


chmod -R o-rwx /root/
chmod -R o+rX /etc/X11/
chmod -R o+r /etc/pulse/
chmod -R o+r /usr/share/

rm -rf /lib/udev/rules.d/
rm -f /lib/udev/*.sh

echo "New password for dan"
passwd dan

pacman -Sy steam
