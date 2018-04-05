-module(tss).
%-behaviour(gen_server).

-compile(export_all).

init([]) -> [].

sign_document(_ID, _Hash) ->
    receive
        {} -> ok
    end.

loop() -> 
    receive
        _ -> ok
    after 5000 ->
        {error, timeout}
    end.
