-module(elli_pong_callback).
-behaviour(elli_handler).

-export([handle/2, handle_event/3]).

handle(_Req, _Args) ->
    {200, [{<<"Content-Type">>, <<"text/plain">>}], <<"PONG">>}.

handle_event(_, _, _) ->
    ok.
