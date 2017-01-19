# HP5200Tool

Real Time Clock (RTC / pseudo NTP) Update for HP LaserJet 5200 series, i. e. 5200tn.
This script updates the clock, so this compensates the lack of NTP client functionality of this device.

This type of printer is robust, can print duplex in A3 and can occasionally be bought for little money. At least my exemplar's clock runs a few minutes too fast per day, so I wrote this script. 

This script relies problably on the following firmware version on the device:
20110406 08.150.3

The printer's web interface can be secured with a password. This is **not** supported at the moment.

Designed to run on Linux i. e. Raspbian. Requires curl and bc. Tested with Debian GNU/Linux 8.7 (jessie) and Raspbian GNU/Linux 8.0 (jessie).

Example for invocation via /etc/crontab:
`*/15   *     * * *  root   /opt/hp5200update.sh`
