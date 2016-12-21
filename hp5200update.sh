#!/bin/bash

# This script updates the clock of 
# HP LaserJet 5200tn Printer, possibly also other models of the HP 5200 series
# So this compensates the lack of NTP client functionality of this device.
#
# This script relies problably on the following firmware version on the device:
# 20110406 08.150.3
#
# Example for invocation via /etc/crontab
#  */15   *     * * *  root   /opt/hp5200update.sh
#
# (c) Cornelis Denhart 2016, Licensed as GNU GPLv3
# Visit https://github.com/CornelisDenhart/HP5200Tool for updates and more information 

MFCIP=192.168.24.54

# Set to "1" if a CSV file should be written, indicating if the device is responding or not
writeUptimeLog=1

# Locations of logfiles
uptimelLogFile="hp5200UpLog.txt"

# CSV field separator; either Tab \t or ; are suggested
CSVSeparator="\t"
CSVSeparator=";"

#------------------------------------------------------------------------------------------

dateURL="http://$MFCIP/hp/device/this.LCDispatcher?nav=hp.DateAndTime"

headerData="Content-Type: application/x-www-form-urlencoded"
currentYr=$(date "+%Y")
currentMthReal=$(date "+%m")
currentMth=$(echo "$currentMthReal - 1" | bc -l)
currentDay=$(date "+%d")
currentHr=$(date "+%H")
currentMin=$(date "+%M")
currentStamp=$(date "+%Y-%m-%d %H:%M:%S")
postData="fieldyear=$currentYr&fieldmonth=$currentMth&fieldday=$currentDay&fieldhour=$currentHr&fieldmin=$currentMin&btnApply=Apply"
#echo $postData

curl --header "$headerData" --connect-timeout 5 --max-time 10 --data $postData $dateURL 2>/dev/null >/dev/null
result=$?
if [ "$writeUptimeLog" = "1" ]; then
	if [ ! -f $uptimelLogFile ]; then
		echo -e "Date/Time""$CSVSeparator""Up=0 / Down!=0" > $uptimelLogFile
	fi
	echo -e $currentStamp"$CSVSeparator"$result >> $uptimelLogFile
fi
