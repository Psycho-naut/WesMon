#!/bin/bash
clear

#Install Library Gps 
echo -e '\e[31m** \e[0mInstall library for GPS receiver\e[31m**\e[0m'
sudo apt-get install -y screen gpsd libncurses5-dev libpcap-dev tcpdump libnl-dev gpsd-clients python-gps
clear
echo -e '-Library Gps \e[32mINSTALLED'
echo

#Install Kismet-2016
echo -e '\e[31m**\e[0mDownload an install Kismet\e[31m**\e[0m'
echo
cd /opt
mkdir Kismet
cd /opt/Kismet
mkdir DATA
.<<Old_Installer
wget http://www.kismetwireless.net/code/kismet-2016-07-R1.tar.xz
tar -xvf kismet-2016-07-R1.tar.xz
cd kismet-2016-07-R1
sudo ./configure
sudo make dep
sudo make
sudo make install
echo
Old_Installer
sudo apt-get install kismet
echo -e '\e[31m**\e[0mKismet Installed\e[31m**\e[0m'
sleep 3
clear
echo -e '-Library Gps \e[32mINSTALLED\e[0m'
echo -e '-Kismet       \e[32mINSTALLED'
echo


#Install Netxml2Kml
echo -e '\e[31m**\e[0mInstall NetXml2Kml\e[31m**\e[0m'
echo
cd /opt/Kismet/DATA
wget https://gist.githubusercontent.com/ScottHelme/5c6869e17c3e9c8b2034dc8fc13e180b/raw/31c2d34f66748b6bd26415fd7d120c06b3d92eaf/netxml2kml.py -O netxml2kml.py
mkdir OLD; mkdir KML_FILE;
echo -e '\e[31m**\e[0mNetXml2Kml installed\e[31m**\e[0m '
sleep 3
clear
echo -e '-Library Gps \e[32mINSTALLED\e[0m'
echo -e '-Kismet       \e[32mINSTALLAED\e[0m'
echo -e '-NetXml2Kml   \e[32mINSTALLAED'

# Install MariaDB on Raspberry
echo -e '\e[31m**\e[0mInstall MariaDB\e[31m**\e[0m'
clear
sudo apt install mariadb-server
echo "You want make Secure Installation? (Y/n)"
read CHOIS

if [[ $CHOIS == "Y" ]]
then
    sudo mysql_secure_installation
elif [[ $CHOIS == "n" ]]
then
    echo "Complete"
fi
clear
echo -e '\e[31m****\e[0mINSTALL COMPLETE\e[31m****\e[0m'



