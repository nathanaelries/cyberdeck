#!/bin/bash
for pkgName in $(curl https://raw.githubusercontent.com/nathanaelries/cyberdeck/main/packages.txt)

do
  pacman -S --force --noconfirm $pkgName
done
echo "Installed/Reinstalled all packages."
