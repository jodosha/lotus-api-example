# JSON API App with Lotus

This is an example JSON API application built with Lotus.

## Prerequisites

  * Ruby 2+ (with Bundler)
  * Redis
  * Heroku CLI (for deployment)

## Development

```shell
➜ git clone https://github.com/jodosha/lotus-api-example bookshelf
➜ cd bookshelf && bundle
➜ bundle exec rackup
```

In a separated shell, start `redis-server`, then visit: `http://localhost:9292`.

## Testing

Run the test suite via Rake.

```shell
➜ bundle exec rake
```

## Deployment

### Heroku

Install the Redis plugin for Heroku CLI

```shell
➜ heroku plugins:install heroku-redis
```

```shell
➜ heroku create
➜ heroku addons:create heroku-redis:hobby-dev
➜ git push heroku master
➜ heroku open
```

## Copyright

Copyright © 2015 Luca Guidi – Released under MIT License
