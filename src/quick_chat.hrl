-define(PRINT(Var), io:format("~p:~p: ~p = ~p~n", [?MODULE, ?LINE, ??Var, Var])).

-record(userinfo, {login = false}).
