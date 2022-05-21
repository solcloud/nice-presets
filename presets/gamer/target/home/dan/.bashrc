. /etc/environment
. /etc/profile

ec() {
    echo -e "\e[1;31mExit code: $?\e[m\n"
}
trap ec ERR
