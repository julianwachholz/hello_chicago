-module(hello_chicago_greeting_controller, [Req]).
-compile(export_all).

-default_action(list).


before_("hello") -> ok;
before_(_) ->
    user_lib:require_login(Req).


hello('GET', []) ->
    {ok, [{greeting, "Hello, World!"}]}.


list('GET', [], Greeter) ->
    Greetings = boss_db:find(greeting, []),
    {ok, [{'greetings', Greetings}, {greeter, Greeter}]}.


show('GET', [GreetingId], Greeter) ->
    Greeting = boss_db:find(GreetingId),
    {ok, [{greeting, Greeting}, {greeter, Greeter}]}.


create('GET', [], Greeter) ->
    {ok, [{greeter, Greeter}]};
create('POST', [], Greeter) ->
    GreetingText = Req:post_param("greeting_text"),
    NewGreeting = greeting:new(id, Greeter:id(), GreetingText, undefined, undefined),
    case NewGreeting:save() of
        {ok, SavedGreeting} ->
            {redirect, [{action, "list"}]};
        {error, ErrorList} ->
            {ok, [{errors, ErrorList}, {new_greeting, NewGreeting}, {greeter, Greeter}]}
    end.


delete('POST', [], Greeter) ->
    boss_db:delete(Req:post_param("greeting_id")),
    {redirect, [{action, "list"}]}.


live('GET', []) ->
    Greetings = boss_db:find(greeting, []),
    Timestamp = boss_mq:now("new-greetings"),
    {ok, [{greetings, Greetings}, {timestamp, Timestamp}]}.


pull('GET', [LastTimestamp]) ->
    {ok, Timestamp, Greetings} = boss_mq:pull("new-greetings",
        list_to_integer(LastTimestamp)),
    {json, [{timestamp, Timestamp}, {greetings, Greetings}]}.
