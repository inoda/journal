## About

In a nutshell: a private self-hosted journal with sharing capabilities.

This project is an attempt to make myself journal more
consistently. I find it much easier to gather my thoughts
with a keyboard. Having an online journal also means that
I don't need to remember to bring it with me everywhere. The app
is meant to be used by 1 person, and you can host easily your own instance.

The app was designed by [Iana Noda](https://iananoda.com).

## Features

#### Dark mode

#### Sharing capabilities

#### Journaling prompts

#### Data encryption

#### Email alert when a login occurs (optional)

## Installation

- [Install with Homebrew](docs/homebrew_install.md)
- Spin up an instance (for free) using the Heroku deploy button below. Heroku account is required.

### Creating a user

- `bundle exec rails c` to run Rails console
- `User.create!(username: "...", password: "...")` The username and password will be hashed.
- If you ever need to change your username/password: `User.first.update!(username: "...", password: "...")`

## Hosting your own

I'd recommend using [Heroku](https://heroku.com) since it's super simple (and free) to
deploy a Rails app. Keep it awake with my [Heroku Pinger](https://github.com/inoda/heroku-pinger)!
All you need to do once your instance is deployed is run
`heroku run bundle exec rails c` to open the Rails console and create your user.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/inoda/journal/tree/master)

## Usage and feedback
Feel free to use this however you'd like! If you use this, credit
would be nice but I don't really care that much. I'm primarily maintaining
this for my own use cases. But...if you have features you'd like to see built, or changes
that you think should be made, please open issues on this repo and tag me in them!
I'd love to improve the tool from your feedback.
