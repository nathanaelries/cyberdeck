#!/bin/bash

#
##
## Downloading files...
##
#

#Clean up previous installations
rm ~/cyberdeck.log 2>/dev/null 
rm -rf ~/cyberdeck
mkdir -p ~/cyberdeck

#We create all the needed folders for installation
cd ~/cyberdeck

#Cloning cyberdeck files
git clone https://github.com/nathanaelries/cyberdeck.git ~/cyberdeck 

#
##
## cyberdeck is installed, start setting up stuff
##
#

for pkgName in $(cat ~/cyberdeck/packages.txt)

do
  pacman -S --force --noconfirm $pkgName
done
echo "Installed/Reinstalled all packages."
