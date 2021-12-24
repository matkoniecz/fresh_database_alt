service postgresql start
sudo locale-gen en_US.UTF-8
sudo sed -i "s/#\?listen_address.*/listen_addresses '*'/" /etc/postgresql/10/main/postgresql.conf
echo "host    all             all             all                     md5" | sudo tee --append /etc/postgresql/10/main/pg_hba.conf > /dev/null
service postgresql restart
sudo -u postgres psql -c "SELECT 1 FROM pg_user WHERE usename = 'cladmin';" | grep -q 1 || sudo -u postgres psql -c "CREATE ROLE cladmin SUPERUSER LOGIN PASSWORD 'password';"
sudo -u postgres psql -c "SELECT 1 FROM pg_database WHERE datname = 'colouringlondondb';" | grep -q 1 || sudo -u postgres createdb -E UTF8 -T template0 --locale=en_US.utf8 -O cladmin colouringlondondb

# to verify
# psql -d colouringlondondb -U cladmin -h localhost

psql -d colouringlondondb -c "create extension postgis;"
psql -d colouringlondondb -c "create extension pgcrypto;"
psql -d colouringlondondb -c "create extension pg_trgm;"
