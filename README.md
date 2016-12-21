# HP5200Tool

Real Time Clock (RTC / pseudo NTP) Update for HP LaserJet 5200 series, i. e. 5200tn.
This script updates the clock of, so this compensates the lack of NTP client functionality of this device.

This script relies problably on the following firmware version on the device:
20110406 08.150.3

Designed to run on Linux i. e. Raspbian. Requires curl and bc.

Example for invocation via /etc/crontab
*/15   *     * * *  root   /opt/hp5200update.sh
