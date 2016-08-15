# Update system #
cd /tmp
apt-get -y update
apt-get -y upgrade
apt autoremove -y
apt-get clean

# Ubuntu Extras #
apt-get install ubuntu-restricted-extras

# Git #
apt-get install -y git
apt-get install -fy

# VPN Management #
apt-get install -y network-manager-openvpn-gnome

# Subversion #
apt-get install -y subversion

# Curl #
apt-get install -y curl

# C++ Compilation #
apt-get install -y libboost-all-dev g++

# NodeJS
apt-get install -y nodejs-legacy

# Java #
apt-get install -y default-jdk

# WineHQ #
dpkg --add-architecture i386
(echo) | add-apt-repository ppa:wine/wine-builds
apt-get update
apt-get install -y --install-recommends winehq-devel

# Play On Linux #
apt-get install -y playonlinux

# Material Design Theme #
apt-add-repository ppa:tista/adapta -y
apt-get update
apt-get install -y adapta-gtk-theme
apt-get install -y autotools-dev autoconf
git clone https://github.com/snwh/paper-icon-theme.git
cd paper-icon-theme
./autogen.sh
make
make install
cd ..

# Respin #
wget http://security.ubuntu.com/ubuntu/pool/universe/x/xresprobe/xresprobe_0.4.24ubuntu9_amd64.deb
dpkg -i xresprobe_*ubuntu9_amd64.deb
apt-get install -y dialog casper libdebian-installer4 ubiquity-frontend-debconf user-setup discover
apt-get -fy install
rm -rf xresprobe_*ubuntu9_amd64.deb
git clone https://github.com/ch1x0r/LinuxRespin.git
dpkg -i LinuxRespin/ubuntu/respin_1.1.0-1_all.deb
rm -rf LinuxRespin

# Aptik #
apt-add-repository -y ppa:teejee2008/ppa
apt-get update
apt-get install -y aptik

# GuFW #
apt-get install -y gufw

# GParted #
apt-get install -y gparted

# Main Menu #
apt-get install -y alacarte

# Oh My Zsh #
apt-get install -y zsh
tee -a /etc/skel/.bashrc <<EOF
bash .omz-installer.sh
EOF
tee /etc/skel/.omz-installer.sh <<EOF
#!/bin/bash

cd /tmp
echo 'We need your permission to install zshell, a super awsome terminal shell.'
echo -n 'Enter your password: '
read -s password
(echo \$password) | sh -c "\$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &
(echo \$password) | chsh -s \$(which zsh) &
sleep 10s
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k/
sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel9k/powerlevel9k"#g' ~/.zshrc
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/
mkdir ~/.config/
mkdir ~/.config/fontconfig/
mkdir ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
sed -i \'s#bash .omz-installer.sh##g\' ~/.bashrc
echo 'You must log out and log back in to activate zshell.'
read -p 'Press [Enter] to log out.'
gnome-session-quit
EOF
