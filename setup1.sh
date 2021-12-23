# Setting up a local development environment

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential git vim-nox wget curl
sudo apt-get install -y python3 python3-pip python3-dev python3-venv
sudo apt-get install -y postgresql postgresql-contrib libpq-dev postgis postgresql-10-postgis-2.4
sudo apt-get install -y gdal-bin libspatialindex-dev libgeos-dev libproj-dev
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
source ~/.profile
echo $PATH
echo $NODEJS_HOME
service postgresql start

