-module(borkchain).
-compile(export_all).

-record(borkchain, {the_chain}). % List of blocks, the chain
-record(block, {seq_nr,
                timestamp,
                id,
                hash,
                link}).

init() -> 
    loop(#borkchain{the_chain=[]}).

loop(B=#borkchain{}) ->
    receive
        {} ->
            loop(B#borkchain{})
    end.

generate_genesis_block(B=#borkchain{}) ->
    C = B#borkchain.the_chain,
    if C =:= [] ->
           Block = #block{seq_nr=0,
                          timestamp=calendar:local_time(),
                          id="Genesis Block",
                          hash=crypto:hash("Yes. This is a genesis block. Something, something.. religion?"),
                          link="WHAT THE HECK AM I LINKING TO??"},
           B#borkchain{the_chain = [Block|C]};
       C =/= [] ->
           {error, "Borkchain should be empty"}
    end.

next_block(B=#borkchain{}) ->
    ok.
