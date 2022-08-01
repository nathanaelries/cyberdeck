#!/bin/bash
wget https://raw.githubusercontent.com/nathanaelries/cyberdeck/main/packages.txt
for pkgName in $(cat packages.txt)

do
  pacman -S --force --noconfirm $pkgName
done
echo "Installed/Reinstalled all packages."
