#!/usr/bin/bash

# Firefox Updater #

read -p "[!] Do you want to update firefox? [y/n]: " a
if [ "$a" != "y" ]; then
    exit 0
fi

echo "[*] Killing firefox ..."
kill -SIGKILL $(pidof firefox) 2>/dev/null

urlt=$(curl -s "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" | cut -d '"' -f 2)
filet=$(echo $urlt | cut -d '/' -f 10)

echo "[*] Downloading firefox's last release ..."
wget $urlt -nv -P /tmp 

echo "[*] Unpacking file ..."
tar -xjf /tmp/$filet -C /tmp/ 

echo "[*] Updating firefox files ..."
sudo cp -r /tmp/firefox /usr/lib/

echo "[*] Cleaning tmp files ..."
/usr/bin/rm -rf /tmp/firefox*

echo "[+] Done!"

