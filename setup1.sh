#!/bin/bash
set -Eeuox pipefail
IFS=$'\n\t'

err_report() {
    echo "Error on line $1"
}
trap 'err_report $LINENO' ERR

# Setting up a local development environment

sudo apt-get update
sudo apt-get upgrade -y --quiet
sudo apt-get install -y --quiet build-essential git vim-nox wget curl
sudo apt-get install -y --quiet python3 python3-pip python3-dev python3-venv
sudo apt-get install -y --quiet postgresql postgresql-contrib libpq-dev postgis postgresql-12-postgis-3
sudo apt-get install -y --quiet gdal-bin libspatialindex-dev libgeos-dev libproj-dev

sudo apt-get install -y --quiet libvips-dev libvips-tools glib2.0-dev # supposed to solve sharp build error (is having all necessary? Is it even working?)

cd ~/Desktop
mkdir outer_colouring_london_folder
cd outer_colouring_london_folder
git clone https://github.com/colouring-london/colouring-london.git
export NODE_VERSION=v12.14.1
export DISTRO=linux-x64
wget -nc https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-$DISTRO.tar.xz
sudo mkdir /usr/local/lib/node
sudo tar xf node-$NODE_VERSION-$DISTRO.tar.xz -C /usr/local/lib/node
sudo mv /usr/local/lib/node/node-$NODE_VERSION-$DISTRO /usr/local/lib/node/node-$NODE_VERSION
rm node-$NODE_VERSION-$DISTRO.tar.xz

cat >> ~/.profile <<EOF
export NODEJS_HOME=/usr/local/lib/node/node-$NODE_VERSION/bin
export PATH=\$NODEJS_HOME:\$PATH
EOF

# to support interactive VM
cat >> ~/.bashrc <<EOF
export NODEJS_HOME=/usr/local/lib/node/node-$NODE_VERSION/bin
export PATH=\$NODEJS_HOME:\$PATH
EOF

source ~/.profile
echo $PATH
echo $NODEJS_HOME

