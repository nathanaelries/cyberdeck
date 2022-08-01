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

#Creating log file
echo "" > ~/cyberdeck/cyberdeck.log
LOGFILE=~/cyberdeck/cyberdeck.log
exec > >(tee ${LOGFILE}) 2>&1

#Mark if this not a fresh install
FOLDER=~/cyberdeck/
if [ -d "$FOLDER" ]; then
	echo "" > ~/cyberdeck/.finished
fi
sleep 1
SECONDTIME=~/cyberdeck/.finished

#We create all the needed folders for installation
cd ~/cyberdeck

#Cloning cyberdeck files
git clone https://github.com/nathanaelries/cyberdeck.git ~/cyberdeck 

#
##
## cyberdeck is installed, start setting up stuff
##
#

for pkgName in $(cat ~/cyberdeck/main/packages.txt)

do
  pacman -S --force --noconfirm $pkgName
done
echo "Installed/Reinstalled all packages."
