-module(greeting, [Id, GreetingText]).
-compile(export_all).


validation_tests() ->
    [{fun() -> length(GreetingText) > 0 end,
        "Greeting must be non-empty!"},
     {fun() -> length(GreetingText) =< 140 end,
        "Greeting must be tweetable."}].


%% We want to be nice.
before_create() ->
    ModifiedRecord = set(greeting_text,
                         re:replace(GreetingText,
                                    "negative", "positive",
                                    [{return, list}])),
    {ok, ModifiedRecord}.
