#!/bin/bash
#############################################################
#  Support for Nextion screen, update pistar and install    #
#  BC. BC is used to offload caculatons from trying to do   #
#  them in the display. Script can also be used to install  #
#  other programs by addding them here. Update stripped.csv # 
#  KF6S                                         04-10-2019  #
#############################################################
set -o errexit
set -o pipefail

exec 3>&2
exec 2> /dev/null
sudo mount -o remount,rw /  > /dev/null

# Run Pistar update script before adding BC
sudo pistar-update > /dev/null
# Set to R/W because pi-star update will try and set R/O
# Update files needed for new Nextion functions
sudo apt-get install bc  > /dev/null
# Check and Remove Nextion_Temp if it exists
#sudo rm -f -r /home/pi-star/Nextion_Temp
# Check and Remove usr/local/etc/NX4832K035.tft if it exists
#sudo rm -f /usr/local/etc/NX4832K035.tft
# Give the user an easy way to update DMR ID database called stripped.csv
sudo /home/pi-star/Scripts/getstripped.sh > /dev/null
#sudo wget -O /usr/local/etc/stripped.csv https://database.radioid.net/static/user.csv
# set to R/O when finished
sudo mount -o remount,ro /;
 exec 2>&3
echo "Update Complete"
