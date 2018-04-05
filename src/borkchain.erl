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
    %% Make sure that the chain is empty
    if C =:= [] ->
           %% Create the genesis block
           Block = #block{seq_nr=0,
                          timestamp=calendar:local_time(),
                          id="Genesis Block",
                          hash=crypto:hash(sha512, "Yes. This is a genesis block. Something, something.. religion?"),
                          link="WHAT THE HECK AM I LINKING TO??"},
           B#borkchain{the_chain = [Block|C]};
       %% If it's not.. something's gone horribly wrong.
       C =/= [] ->
           {error, "Borkchain should be empty.. BORKBORK!!"}
    end.

next_block(B=#borkchain{}, ID, Hash) ->
    %% Get the chain and take out the last item
    C = B#borkchain.the_chain,
    Last = lists:last(C),
    %% Create the block record
    Block = #block{seq_nr=Last#block.seq_nr + 1,
                   timestamp=calendar:local_time(),
                   id=ID,
                   hash=Hash,
                   link={Last#block.timestamp,
                         Last#block.id,
                         Last#block.hash,
                         crypto:hash(sha512, Last#block.link)}},
    B#borkchain{the_chain = [Block|C]}.
