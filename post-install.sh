#!/bin/bash
# autoexit on error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e

#Prompt for password
sudo echo "Starting..."
sleep 2

# Repos and ppas
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:webupd8team/terminix
sudo add-apt-repository -y ppa:nathan-renniewaldock/qdirstat
sudo apt-add-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:mmk2410/intellij-idea
sudo add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
sudo add-apt-repository -y ppa:peterlevi/ppa

# Update and upgrage
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

# Install packages
sudo apt-get -y install terminix mc git gparted openssh-server \
    silversearcher-ag thunderbird grub-customizer kdiff3 keepass2 checkinstall \
    gnome-calculator audacity audacious htop hardinfo pinta conky libpam-google-authenticator \
    deluge virtualbox virtualbox-qt telegram workrave catdoc qdirstat \
    libgoo-canvas-perl gnome-web-photo mp3splt wxhexeditor variety variety-slideshow

# Install dev
sudo apt-get -y install python-dev python3-dev mono-complete fsharp \
    build-essential cmake exfat-utils exfat-fuse dkms linux-headers-generic dconf-tools ctags \
    dh-autoreconf autotools-dev debhelper ffmpeg golang python-pip

# Java 8 and IntelliJ IDEA
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-set-default
sudo apt-get -y install intellij-idea-community
sudo rm -f /usr/share/applications/intellij-idea-community.desktop

# Install vim build dependecies
sudo apt-get -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev

#Install File Compression Libs
sudo apt-get -y install unace rar unrar zip unzip lzip lunzip xz-utils p7zip-full p7zip-rar sharutils uudeview mpack arj cabextract

#Gain yourself access to USB ports
sudo usermod -a -G dialout smaugfm

#Clean-up System
sudo apt-get -y autoremove
sudo apt-get -y autoclean

read -p "Continues to the rest of the post-installation? (y|n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
else
    ./post-install2.sh
fi

