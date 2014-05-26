-module(greeting_tests).
-include_lib("eunit/include/eunit.hrl").


suite_test_() ->
    {foreach, local,
        fun setup/0,
        tests()
    }.


tests() ->
    [{"Validations of greeting_text.",
      ?_test(val_greeting_text())}
    ].


val_greeting_text() ->
    Greeting = boss_record:new(greeting, []),
    ?assertEqual({error, []}, Greeting:validate()),
    Greeting2 = Greeting:set([{greeting_text, "Tweetable."}]),
    {Res, _} = Greeting2:validate(),
    ?assertEqual(ok, Res).


setup() ->
    ok.
