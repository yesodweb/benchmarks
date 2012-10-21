-module(elli_pong_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, {{one_for_all, 0, 1}, [webserver()]}}.


%% ===================================================================
%% Internal functions
%% ===================================================================

webserver() ->
    {webserver,
     {elli, start_link, [[{port, 3000},
                          {callback, elli_pong_callback}]]},
     permanent, 5000, worker, [elli]}.
