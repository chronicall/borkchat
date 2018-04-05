# BORKCHAT

This is a BORK-erific "chat" server that is distributed over erlang nodes.

Idfk..

## How to
Navigate to root directory, run `erl -make`

Now, start three terminal instances and navigate to the root directory. Once there, run one of these in each window:
```
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
