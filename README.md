# Minasan

Group chat powered by Erlang and Cowboy, Ember.js and Websockets. The layout is
also responsive/mobile-friendly!

Forked from <https://github.com/oruen/quick_chat>, Ember.js app by [@Deteam](https://github.com/deteam), and <https://github.com/mattreduce/minasan>

![screenshot](http://f.cl.ly/items/0x0L3b2k1q1M1b2Q2d23/minasan.png)

## Usage

    $ ./rebar3 update
    $ ./rebar3 do compile, release
    $ PORT=8080 _build/default/rel/minasan/bin/minasan console

## Deploy to Heroku

Suggested method requires <https://github.com/heroku/hk> and <https://github.com/tsloughter/hk-slug>

    $ REBAR_DEFAULT_PROFILE=prod ./rebar3 tar
    $ hk slug _rel/minasan/minasan-0.0.1.tar.gz

## License

See the `LICENSE` file.
