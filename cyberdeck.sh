#!/bin/bash
rm -rf ~/cyberdeck
mkdir -p ~/cyberdeck
cd ~/cyberdeck
git clone https://github.com/nathanaelries/cyberdeck.git ~/cyberdeck
for pkgName in $(cat ~/cyberdeck/packages.txt)
do pacman -S --force --noconfirm $pkgName done
