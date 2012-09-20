#!/bin/bash

# CONFIGURATION

# Install and configure mongodb
INSTALL_POSTGRES="NO"
INSTALL_MONGO="NO"

echo "=== APTITUDE"

echo "aptitude repositories"
cat > /etc/apt/sources.list << EOF
deb http://ftp.ru.debian.org/debian/ squeeze main contrib non-free
deb-src http://ftp.ru.debian.org/debian/ squeeze main contrib non-free

deb http://security.debian.org/ squeeze/updates main contrib non-free
deb-src http://security.debian.org/ squeeze/updates main contrib non-free

# squeeze-updates, previously known as 'volatile'
deb http://ftp.ru.debian.org/debian/ squeeze-updates main contrib non-free
deb-src http://ftp.ru.debian.org/debian/ squeeze-updates main contrib non-free

deb http://backports.debian.org/debian-backports squeeze-backports main

deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen
EOF

echo "aptitude update"
# Update repositories
aptitude update && upgrade

echo "Setup aptitude security keys for extra repositories"
apt-key adv --keyserver subkeys.pgp.net --recv 9ECBEC467F0CEB10


echo "=== LOCALES"

aptitude install -y locales 
echo "LANG=en_US.UTF-8" > /etc/default/locale
cat > /etc/locale.gen << EOF
en_US.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
EOF
locale-gen


echo "=== GIT"

aptitude install -y git-core


echo "=== VIM"

rm -R ~/.vim ~/.vimrc
git clone https://github.com/imbolc/.vim
ln -s ~/.vim/.vimrc ~
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

aptitude install -y vim-nox
update-alternatives --set editor /usr/bin/vim.nox


echo "=== INSTALL PACKAGES"
# psmsic --> pkill
# apache-utils --> ab
# libxml2-dev libxslt1-dev --> build lxml from source
# libcurl4-openssl-dev --> build pycurl from source
# libjpeg62-dev libfreetype6-dev --> build PIL from source
# postgresql-server-dev-all --> build psycopg from source
# libmysqld-dev --> build mysql driver from source
aptitude install -y libxml2-dev libxslt1-dev
aptitude install -y libcurl4-openssl-dev
aptitude install -y libjpeg62-dev libfreetype6-dev
aptitude install -y postgresql-server-dev-all libmysqld-dev libmemcached-dev
aptitude install -y libtokyocabinet-dbg libtokyocabinet-dev libtokyocabinet8
aptitude install -y libevent1 libevent-dev

aptitude install -y htop screen mc sudo apache2-utils gcc
aptitude install -y nginx runit

aptitude install -y python python-setuptools python-dev
easy_install pip
pip install virtualenv fabric mercurial

if [ "$INSTALL_POSTGRES" == "YES" ]; then
    aptitude install -y posgresql-9.1
fi
if [ "$INSTALL_MONGO" == "YES" ]; then
    aptitude install -y mongodb-10gen
    update-rc.d mongodb defaults
    /etc/init.d/mongodb start
fi

# Disable in-memory /tmp which was enabled by default in debian squeeze
cat /etc/default/rcS | sed s/RAMTMP=yes/RAMTMP=no/g > /tmp/rcS; cp /tmp/rcS /etc/default/

# Enable sudo autocomplete
echo "complete -cf sudo" >> ~/.bashrc
