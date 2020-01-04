#!/bin/sh
# Entry point for the application in Docker.

set -eu

if [ -z "${RAILS_ENV+x}" ]
then
  export RAILS_ENV=production
fi

if [ -z "${1+x}" ]
then
  echo "Migrating database..."
  bundle exec rake db:migrate
  bundle exec rails console <<END
require 'securerandom'
unless User.exists?
  @password = SecureRandom.alphanumeric(32)
  puts "Creating initial user, password: '" + @password + "'."
  User.create!(
    username: "admin",
    password: @password,
  )
end
END

  echo "Starting Web server."
  exec bundle exec puma -C config/puma.rb
else
  "$@"
fi
