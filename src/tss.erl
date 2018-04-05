-module(tss).
-behaviour(gen_server).

-compile(export_all).

init([]) -> [].

sign_document(Document) -> ok.

loop() -> 
    receive
        _ -> ok
    after 5000 ->
        {error, timeout},
        loop()
    end.
