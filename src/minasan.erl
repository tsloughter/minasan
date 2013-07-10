%%
%% minasan.erl
%% minasan entry point
%%
-module(minasan).

-export([start/0, start_link/0, stop/0]).

start_link() ->
    minasan_sup:start_link().

start() ->
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowboy),
    ok = application:start(gproc),
    ok = application:start(minasan).

stop() ->
    application:stop(minasan).

