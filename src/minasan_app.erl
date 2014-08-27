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
    start_cowboy(),
    minasan_sup:start_link().

stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

start_cowboy() ->
    Dispatch =
        cowboy_router:compile([
                              {'_', [
                                    {"/ws", minasan_ws_handler, []}
                                    ,{"/static/[...]", cowboy_static,
                                      {priv_dir, minasan, "static", [{mimetypes, cow_mimetypes, web}]}}
                                    ,{"/", cowboy_static, {priv_file, minasan, "static/index.html"}}
                                    ]}
                              ]),

    ListenPort = os:getenv("PORT"),
    io:format("PORT ~p~n", [ListenPort]),
    cowboy:start_http(minasan_cowboy, 100,
                     [{port, list_to_integer(ListenPort)}], [{env, [{dispatch, Dispatch}]}]).
