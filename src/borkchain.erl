-module(borkchain).
-compile(export_all).

-record(borkchain, {the_chain}). % List of blocks, the chain
-record(block, {seq_nr,
                timestamp,
                id,
                hash,
                link}).

start() ->
    register(?MODULE, Pid=spawn(?MODULE, init, [])),
    Pid.

%% Probably not required.
start_link() ->
    register(?MODULE, Pid=spawn_link(?MODULE, init, [])),
    Pid.

terminate() ->
    ?MODULE ! shutdown.

%% Initialize the blockchain
init() ->
    %% Empty list at first
    B = #borkchain{the_chain=[]},
    %% Create the genesis block and start the loop
    loop(generate_genesis_block(B#borkchain{})).

%% "Sign" a document hash.
sign_document(ID, Hash) ->
    %Ref = make_ref(),
    ?MODULE ! {self(), {sign, ID, Hash}},
    receive
        {successful, Msg} ->
            io:format("~p~n", [Msg])
    after 5000 ->
        {error, timeout}
    end.

%%% The server
loop(B=#borkchain{}) ->
    receive
        {Pid, {sign, ID, Hash}} ->
            %% Create a new block
            NewBlock = next_block(B#borkchain{}, ID, Hash),
            C = B#borkchain.the_chain,
            %% Add the new block to the chain
            NewBork = B#borkchain{the_chain = [NewBlock|C]},
            %% Notify the user that a block has been "added"
            Pid ! {successful, "New block added!"},
            print_chain(NewBork),
            loop(NewBork);
        {exit, Reason} ->
            exit(Reason);
        shutdown ->
            exit(shutdown)
    after 5000 ->
        %% Prints out the length of the block chain atm
        %% Lel.
        io:format("The length of the chain is ~p~n", [length(B#borkchain.the_chain)]),
        loop(B#borkchain{})
    end.

%%% Private function?
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
           ?MODULE ! {exit, "Borkchain should be empty.. BORKBORK!!"}
    end.

%% Creates the "next block" on the blockchain
next_block(B=#borkchain{}, ID, Hash) ->
    %% Get the chain and take out the last item
    C = B#borkchain.the_chain,
    Last = hd(C),
    %% Create the block record
    Block = #block{seq_nr=Last#block.seq_nr + 1,
                   timestamp=calendar:local_time(),
                   id=ID,
                   hash=Hash,
                   link=make_link_info_hashable({Last#block.timestamp,
                                                 Last#block.id,
                                                 Last#block.hash,
                                                 crypto:hash(sha512, Last#block.link)})},
    Block.

%% What it says on the tin.
make_link_info_hashable({T, ID, H, HLL}) ->
    %% Creates a format string, which is in fact a list, with all the info
    %% then flattens that list.
    LinkInfo = lists:flatten(io_lib:format("~w, ~w, ~w - ~w", [T, ID, H, HLL])),
    LinkInfo.

%% This is a Bork-printer
print_chain(B=#borkchain{}) ->
    C = B#borkchain.the_chain,
    %% List comprehension, yay.
    [io:format("~p~n", [X]) || X <- C].
