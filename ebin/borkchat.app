{application, borkchat,
 [{vsn, "1.0.0"},
  {description, "BORK! BORK! ARF?"},
  {modules, [borkchat, borkchat_sup, borkchat_serv]},
  {applications, [stdlib, kernel, crypto]},
  {registered, [borkchat, borkchat_sup, borkchat_serv]},
  {mod, {borkchat, []}},
  {env, [
    {answers, {<<"BORK!">>, <<"BARK!">>, <<"ARF!!!">>,
               <<"BOFF.">>, <<"BARF!!">>}}
  ]}
 ]}.
