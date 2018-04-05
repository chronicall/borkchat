-module(tss).
%-behaviour(gen_server).

-compile(export_all).

init([]) -> [].

sign_document() ->
    ok.

loop() -> 
    receive
        _ -> ok
    after 5000 ->
        {error, timeout}
    end.
