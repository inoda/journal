# Installation without Docker on Ubuntu 18.04

Requirements:

- PostgreSQL
- User with `sudo` permissions

## Install steps

#### Create a user for `journal`:

```
$ sudo useradd -m -s /bin/bash journal
```

#### Create a PostgreSQL user for `journal`:

```
$ sudo -u postgres createuser -D -A -P journal
```

This will request a password for accessing the database.

#### Install Ruby for the `journal` user

```
$ sudo su -l journal
$ git clone git://github.com/sstephenson/rbenv.git .rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
$ git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
$ source ~/.bash_profile

$ rbenv install 2.6.6
$ rbenv local 2.6.6
$ rbenv rehash
```

#### Install bundler

```
$ gem install bundler
$ rbenv rehash
```

#### Clone the `journal` repo and install dependencies

```
$ git clone https://github.com/inoda/journal.git
$ cd journal
$ bundle install
```

#### Create the environment variables

```
$ echo 'export CIPHER_KEY=...' >> $HOME/.bash_profile
$ echo 'export SHARING_TOKEN_CIPHER_IV=...' >> $HOME/.bash_profile
$ echo 'export SECRET_KEY_BASE=...' >> $HOME/.bash_profile
$ echo 'export RAILS_ENV="production"' >> $HOME/.bash_profile

# one of the following two:
$ echo 'export JOURNAL_DATABASE_PASSWORD=...' >> $HOME/.bash_profile
$ echo 'export DATABASE_URL=...' >> $HOME/.bash_profile
```

#### Create the `journal` database

```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

#### Edit the production environment

In the `journal` repo:

`config/environments/production.rb`
```
# add the following line, replacing with the appropriate hostname
config.hosts << my.host.tld

# comment out the following line by prepending a # character
config.assets.compile = false
```

##### Optional: Change default hosted port

`config/puma.rb`
```
# change to whatever port you like
port        ENV.fetch("PORT") { 3001 }
```

This can also be set later in the `systemd` service as an environment variable `PORT`.

#### Run `journal`

```
$ bundle exec rails s
```

##### Optional: Make it a `systemd` service

As the `sudo` user, create the file `/etc/systemd/system/journal.service` with the following contents:

```
[Unit]
Description=InodaJournal
After=network.target

[Service]
Type=simple
User=journal
Group=journal
WorkingDirectory=/home/journal/journal
Environment="JOURNAL_DATABASE_PASSWORD=..."
Environment="CIPHER_KEY=..."
Environment="SHARING_TOKEN_CIPHER_IV=..."
Environment="RAILS_ENV=production"
Environment="SECRET_KEY_BASE=..."
Environment="PATH=/your/full/journal/user/path"
ExecStart=/home/journal/.rbenv/bin/rbenv exec bundle exec rails s
TimeoutSec=30
RestartSec=15s
Restart=always

[Install]
WantedBy=multi-user.target
```

The environment variables should reflect the same variables that were created for the `journal` user specifically. Start the service with:

```
$ sudo systemctl start journal
$ sudo systemctl enable journal
```
