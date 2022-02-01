# Now run all 'up' migrations to create tables, data types, indexes etc. The `.sql` scripts to
# do this are located in the `migrations` folder of your local repository.
# `ls ./colouring-london/migrations/*.up.sql 2>/dev/null | while read -r migration; do psql -d colouringlondondb < $migration; done;`

## Setting up Python - kept for later (is it needed for running?)
# likely should be modified https://stackoverflow.com/questions/1534210/use-different-python-version-with-virtualenv/39713544#39713544
#Now set up a virtual environment for python. In the following example we have named the
#virtual environment *colouringlondon* but it can have any name.
cd ~/Desktop/outer_colouring_london_folder
pyvenv colouringlondon # python3 one

#Activate the virtual environment so we can install python packages into it.

source colouringlondon/bin/activate

Install python pip package manager and related tools.

pip install --upgrade pip

sudo apt install -y  --quiet python3-testresources # to silence an error on install below 
pip install --upgrade setuptools wheel

#Now install the required python packages. This relies on the `requirements.txt` file located
in the `etl` folder of your local repository.

`pip install -r ./colouring-london/etl/requirements.txt`

## Setting up Node

Now upgrade the npm package manager to the most recent release with global privileges. This
needs to be performed as root user, so it is necessary to export the node variables to the
root user profile. Don't forget to exit from root at the end.

```
sudo su root
```
# potential password entry

# https://github.com/colouring-london/colouring-london/pull/704
export NODEJS_HOME=/usr/local/lib/node/node-v12.14.1/bin/
export PATH=$NODEJS_HOME:$PATH
npm install -g npm@6
exit

original:

```
export NODEJS_HOME=/usr/local/lib/node/node-v12.14.1/bin/
export PATH=$NODEJS_HOME:$PATH`
npm install -g npm@next`
exit
```

# Now install the required Node packages. This needs to done from the `app` directory of your
# local repository, so that it can read from the `package.json` file.

cd ./colouring-london/app && npm install


## Running the application

Now we are ready to run the application. The `APP_COOKIE_SECRET` is arbitrary.

```
PGPASSWORD='password' PGDATABASE=colouringlondondb PGUSER=$USER PGHOST=localhost PGPORT=5432 APP_COOKIE_SECRET=123456 npm start
```

If you a running Ubuntu in a virtual environment you will need to configure networking to
forward ports from the guest to the host. For Virtual Box the following was configured under
NAT port forwarding.

Name     | Protocol  | Host Port  | Guest Port
-------- | --------- | ---------- | -----------
app      | TCP       | 8080       | 3000
app_dev  | TCP       | 3001       | 3001
ssh      | TCP       | 4022       | 22

The site can then be viewed on http://localhost:8080. The `app_dev` mapping is used in
development by Razzle which rebuilds and serves client side assets on the fly.

Finally to quit the application type `Ctrl-C`.
