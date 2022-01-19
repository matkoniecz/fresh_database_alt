#!/bin/bash
set -Eeuox pipefail
IFS=$'\n\t'

err_report() {
    echo "Error on line $1"
}
trap 'err_report $LINENO' ERR

if [[ -e ~/.profile ]] ; then
    if [[ -e ~/.bash_profile ]] ; then
        echo ".profile file is existing, likely created by the previous step"
        echo "This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists."
        exit 1
    fi
fi
if [[ -e ~/.profile ]] ; then
    if [[ -e ~/.bash_login ]] ; then
        echo ".profile file is existing, likely created by the previous step"
        echo "This file is not read by bash(1), if ~/.bash_login or ~/.bash_login exists."
        exit 1        
    fi
fi
service postgresql start
sudo locale-gen en_US.UTF-8
sudo sed -i "s/#\?listen_address.*/listen_addresses '*'/" /etc/postgresql/10/main/postgresql.conf
echo "host    all             all             all                     md5" | sudo tee --append /etc/postgresql/10/main/pg_hba.conf > /dev/null
service postgresql restart
sudo -u postgres psql -c "SELECT 1 FROM pg_user WHERE usename = '$USER';" | grep -q 1 || sudo -u postgres psql -c "CREATE ROLE $USER SUPERUSER LOGIN PASSWORD 'password';"
sudo -u postgres psql -c "SELECT 1 FROM pg_database WHERE datname = 'colouringlondondb';" | grep -q 1 || sudo -u postgres createdb -E UTF8 -T template0 --locale=en_US.utf8 -O $USER colouringlondondb

# to verify
# psql -d colouringlondondb -U $USER -h localhost

psql -d colouringlondondb -c "create extension postgis;"
psql -d colouringlondondb -c "create extension pgcrypto;"
psql -d colouringlondondb -c "create extension pg_trgm;"
