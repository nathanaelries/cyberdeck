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

# Seeting up the progress Bar for the rest of the installation
finished=false
echo "0" > ~/cyberdeck/msg.log
echo "# Downloading files from $branch channel..." >> ~/cyberdeck/msg.log
MSG=~/cyberdeck/msg.log
(	
	while [ $finished == false ]
	do 
		  cat $MSG		    
		  if grep -q "100" "$MSG"; then
			  finished=true
			break
		  fi
							  
	done &
) |
zenity --progress \
  --title="Installing cyberdeck" \
  --text="Downloading files from $branch channel..." \
  --percentage=0 \
  --no-cancel \
  --pulsate \
  --auto-close \
  --width=300 \ &

if [ "$?" = -1 ] ; then
	zenity --error \
	--text="Update canceled."
fi

#We create all the needed folders for installation
mkdir -p ~/nathanaelriesTools/cyberdeck
cd ~/nathanaelriesTools

#Cloning cyberdeck files
git clone https://github.com/nathanaelries/cyberdeck.git ~/nathanaelriesTools/cyberdeck 
if [ ! -z "$devMode" ]; then
	cd ~/nathanaelriesTools/cyberdeck
	git checkout $branch 
fi


#Test if we have a successful clone
cyberdeckGIT=~/nathanaelriesTools/cyberdeck
if [ -d "$cyberdeckGIT" ]; then
	echo -e "Files Downloaded!"
clear
cat ~/nathanaelriesTools/cyberdeck/logo.ans
version=$(cat ~/nathanaelriesTools/cyberdeck/version.md)
echo -e "${BOLD}cyberdeck ${version}${NONE}"
echo -e ""
cat ~/nathanaelriesTools/cyberdeck/latest.md

else
	echo -e ""
	echo -e "We couldn't download the needed files, exiting in a few seconds"
	echo -e "Please close this window and try again in a few minutes"
	sleep 999999
	exit
fi

#
##
## cyberdeck is installed, start setting up stuff
##
#

for pkgName in $(cat ~/nathanaelriesTools/cyberdeck/main/packages.txt)

do
  pacman -S --force --noconfirm $pkgName
done
echo "Installed/Reinstalled all packages."
