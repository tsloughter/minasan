%%
%% minasan_app.erl
%% minasan application
%%
-module(minasan_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ~~~~~~~~~~~~~~~~~~~~~
%% Application callbacks
%% ~~~~~~~~~~~~~~~~~~~~~

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
      {'_', [
        {"/ws", minasan_ws_handler, []},
        {"/", cowboy_static, [
          {directory, {priv_dir, minasan, []}},
          {file, <<"index.html">>},
          {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
        ]},
        {"/[...]", cowboy_static, [
          {directory, {priv_dir, minasan, []}},
          {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
        ]}
      ]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
      {env, [{dispatch, Dispatch}]}
    ]),
    minasan_sup:start_link().

stop(_State) ->
    ok.

