-module(borkchat).
-behaviour(application).
-export([start/2, stop/1]).
-export([ask/1, message/2]).

%%%%%%%%%%%%%%%%%
%%% CALLBACKS %%%
%%%%%%%%%%%%%%%%%

%% start({failover, Node}, Args) is only called
%% when a start_phase key is defined.
start(normal, []) ->
    borkchat_sup:start_link();
start({takeover, _OtherNode}, []) ->
    borkchat_sup:start_link().

stop(_State) ->
    ok.

%%%%%%%%%%%%%%%%%
%%% INTERFACE %%%
%%%%%%%%%%%%%%%%%
ask(Question) ->
    borkchat_serv:ask(Question).

message(ID, Message) ->
    borkchat_serv:message(ID, Message).
