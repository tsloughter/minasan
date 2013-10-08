%%
%% minasan_sup.erl
%% minasan supervisor
%%
-module(minasan_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ~~~~~~~~~~~~~
%% API functions
%% ~~~~~~~~~~~~~

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ~~~~~~~~~~~~~~~~~~~~
%% Supervisor callbacks
%% ~~~~~~~~~~~~~~~~~~~~

init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    Dispatch =
        cowboy_router:compile([
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

    {ok, ListenPort} = application:get_env(http_port),

    ChildSpecs = [ranch:child_spec(minasan_cowboy, 100,
                                   ranch_tcp, [{port, ListenPort}],
                                   cowboy_protocol, [{env, [{dispatch, Dispatch}]}])],

    {ok, {SupFlags, ChildSpecs}}.
