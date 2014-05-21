-module(greeting,
        [Id,
         GreeterId,
         GreetingText,
         CreatedAt::datetime(),
         UpdatedAt::datetime()
        ]).
-compile(export_all).

-belongs_to(greeter).


validation_tests() ->
    [{fun() -> length(GreeterId) > 0 end,
        "Greeting must have a greeter."},
     {fun() -> length(GreetingText) > 0 end,
        "Greeting must be non-empty."},
     {fun() -> length(GreetingText) =< 140 end,
        "Greeting must be tweetable."}].


%% Automated timestamps.
before_create() ->
    Now = calendar:now_to_universal_time(erlang:now()),
    {ok, set([{created_at, Now}, {updated_at, Now}])}.

before_update() ->
    {ok, set([{updated_at, calendar:now_to_universal_time(erlang:now())}])}.
