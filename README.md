# Minasan

Group chat powered by Erlang and Cowboy, Ember.js and Websockets. The layout is
also responsive/mobile-friendly!

Forked from <https://github.com/oruen/quick_chat>, Ember.js app by [@Deteam](https://github.com/deteam), and <https://github.com/mattreduce/minasan>

![screenshot](http://f.cl.ly/items/0x0L3b2k1q1M1b2Q2d23/minasan.png)

## Usage

    $ ./rebar update
    $ ./rebar compile
    $ ./relx
    $ open http://localhost:8080

## Deploy to Heroku

Suggested method requires <https://github.com/heroku/hk> and <https://github.com/tsloughter/hk-slug>

    $ ./relx -i true --dev-mode false tar
    $ hk slug _rel/minasan/minasan-0.0.1.tar.gz

## License

See the `LICENSE` file.
