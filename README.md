# BORKCHAT
This is a BORK-erific "chat" server that is distributed over erlang nodes.

Idfk..

## How to
Navigate to root directory, run `erl -make`

Now, start three terminal instances and navigate to the root directory. Once there, run one of these in each window:
```bash
erl -sname a -config config/a -pa ebin/
erl -sname b -config config/b -pa ebin/
erl -sname c -config config/c -pa ebin/
```

You have 30 seconds. If you fail, BORK happens.

Within each node, if all goes as it should, you can now start `crypto` and `borkchat` by running this in each node:
```erlang
application:start(crypto).
application:start(borkchat).
```

You can now ask BORKS by running `borkchat:ask(<Some Question>).` and get a BORK back.

# BORKCHAIN
Okay so. This is.. something? Can create a "chain".

```bash
erl -make
erl -pa ebin/
```
Then start the chain and "sign" some documents:
```erlang
rr(borkchain).
borkchain:start().
borkchain:sign_document("Some ID", crypto:hash(sha512, "This is a message")).
borkchain:sign_document("Some Other ID", crypto:hash(sha512, "Wow these are boring")).
borkchain:sign_document("Pupper", crypto:hash(sha512, "I am gud Doggo")).
```
You can see the chain grow. The entire chain is printed out with each new block.

## TODO
- Fix link information in the non-genesis blocks
  - Hashing can only be done on a "string" or a <<"binary string">>
  - Need to use `io_lib:format` and possibly `lists:flatten`
  - Combine to form one string that is hashed.
- Make certificates that are actually signed
  - RSA keypair for the borkchain service
  - Possibly move to a separate TSS service, idk..
- Generalize the borkchain "server" or w/e it should be called
  - Only export the methods we need
    - Add verified block?
    - Add block for verification?
    - ???
- Implement Mnesia for blockchain distribution and physical storage
  - Make records compatible with Mnesia so it makes sense
    - Watch out for name collisions!
  - When a new node connects, can it then download the database/blockchain from the network?
- Actually connect this with borkchat, or something similar..
  - Store Borks as the Documents?
  - Proof of Bork!?
