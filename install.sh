#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
curl -s -o ip.txt https://raw.githubusercontent.com/MuLuu09/conf/master/ip.txt
find=`grep $myip ip.txt`
if [ "$find" = "" ]
then
clear
echo "
      System Menu By MuLuu(MappakkoE)
[ YOUR IP NOT REGISTER ON MY SCRIPT ]

----==== CONTACT FOR REGISTER ====----
[ SMS/Telegram : 011131731782 / @MuLuu09 ]
"
rm *.txt
rm *.sh
exit
fi
if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

#info
echo "=================================================="
echo "SUPPORT SERVER GOOGLE CLOUD/DIGITAL OCEAN/LINODE/etc"
echo "DEBIAN 7.X 64/32 BIT ONLY"
echo "=================================================="

clear 
#set time zone malaysia
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
CHECK AND INSTALL IT
COMPLETE 1%
"
apt-get -y install wget curl
clear
echo "
INSTALL COMMANDS
COMPLETE 15%
"

#install sudo
apt-get -y install sudo
apt-get -y wget
 
#needed by openvpn-nl
apt-get -y install apt-transport-https
#adding source list
echo "deb https://openvpn.fox-it.com/repos/deb wheezy main" > /etc/apt/sources.list.d/foxit.list
apt-get update
wget https://openvpn.fox-it.com/repos/fox-crypto-gpg.asc
apt-key add fox-crypto-gpg.asc
apt-get update
cd /root
#installing normal openvpn, easy rsa & openvpn-nl
apt-get install easy-rsa -y
apt-get install openvpn -y
apt-get install openvpn-nl -y
#ipforward
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.1.0.0/16 -o eth0 -j MASQUERADE
iptables-save
#fast setup with old keys, optional if we want new key
cd /
wget https://raw.githubusercontent.com/Qeesya/script/master/script/ovpn.tar
tar -xvf ovpn.tar
rm ovpn.tar
service openvpn-nl restart
openvpn-nl --remote CLIENT_IP --dev tun0 --ifconfig 10.9.8.1 10.9.8.2
#get ip address
apt-get -y install aptitude curl

if [ "$IP" = "" ]; then
        IP=$(curl -s ifconfig.me)
fi
#installing squid3
aptitude -y install squid3
rm -f /etc/squid3/squid.conf

#restoring squid config with open port proxy 8080,7166
wget -P /etc/squid3/ "https://raw.githubusercontent.com/Qeesya/script/master/script/squid.conf"
sed -i "s/$myip/$IP/g" /etc/squid3/squid.conf
service squid3 restart
cd

#install vnstat
apt-get -y install vnstat
vnstat -u -i eth0
sudo chown -R vnstat:vnstat /var/lib/vnstat
service vnstat restart

clear
echo 
"INSTALL MENU COMMAND
39% COMPLETE "

# User Status
cd
wget http://raw.github.com/MuLuu09/conf/master/user-list
mv ./user-list /usr/local/bin/user-list
chmod +x /usr/local/bin/user-list

# Install Dos Deflate
apt-get -y install dnsutils dsniff
wget http://raw.github.com/MuLuu09/autoscript/master/ddos-deflate-master.zip
unzip master.zip
cd ddos-deflate-master
./install.sh
cd

# Install SSH autokick
cd
wget http://raw.github.com/MuLuu09/conf/master/Autokick-debian.sh
bash Autokick-debian.sh


# Install Monitor
cd
wget http://raw.github.com/MuLuu09/conf/master/monssh; 
mv monssh /usr/local/bin/; 
chmod +x /usr/local/bin/monssh


# Install Menu
cd
wget http://raw.github.com/MuLuu09/conf/master/menu
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# moth
cd
wget wget http://raw.github.com/MuLuu09/conf/master/motd
mv ./motd /etc/motd
#ssh
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
wget -O /etc/issue.net " https://raw.githubusercontent.com/zero9911/script/master/script/banner"

clear
echo 
"65% COMPLETE"

#install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" » /etc/shells

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.820_all.deb"
dpkg --install webmin_1.820_all.deb;
apt-get -y -f install;
rm /root/webmin_1.820_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
service vnstat restart


#config upload
wget -O /home/vps/public_html/client.ovpn " https://raw.githubusercontent.com/Qeesya/script/master/script/max.ovpn"
sed -i "s/ipserver/$myip/g" /home/vps/public_html/max.ovpn
cd

clear

echo "
BLOCK TORRENT PORT INSTALL
COMPLETE 94%
"
#bonus block torrent
wget https://raw.githubusercontent.com/Qeesya/script/master/script/torrent.sh
chmod +x  torrent.sh
./torrent.sh

#add user
useradd -m -g users -s /bin/bash MuLuu
echo "MuLuu:12345" | chpasswd

clear
echo "COMPLETE 100%"

echo "RESTART SERVICE"
service openvpn-nl restart
service squid3 restart
service vnstat restart
service webmin restart
service dropbear restart
service ssh restart
echo " DONE RESTART SERVICE"

clear

echo "===============================================--"
echo "                             "
echo "  === AUTOSCRIPT FROM MuLuu09 === "
echo "WEBMIN : http://$myip:10000 "
echo "OPENVPN PORT : 59999"
echo "DROPBEAR PORT : 22,443"
echo "PROXY PORT : 7166,8080"
echo "Config OPENVPN : http://$myip/max.ovpn"
echo "SERVER TIME/LOCATION : KUALA LUMPUR +8"
echo "TORRENT PORT HAS BLOCK BY SCRIPT"
echo "CONTACT OWNER SCRIPT"
echo "WHATSAPP : +601131731782"
echo "TELEGRAM : @MuLuu09"

echo "  === PLEASE REBOOT TAKE EFFECT  ===  "
echo "                                  "
echo "=================================================="
rm install.sh
