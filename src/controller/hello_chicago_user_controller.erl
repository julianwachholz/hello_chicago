-module(hello_chicago_user_controller, [Req]).
-compile(export_all).


login('GET', []) ->
    ok;
login('POST', []) ->
    Name = Req:post_param("name"),
    case boss_db:find(greeter, [{name, Name}], [{limit, 1}]) of
        [Greeter] ->
            case Greeter:check_password(Req:post_param("password")) of
                true ->
                    {redirect, "/greeting/list/", Greeter:login_cookies()};
                false ->
                    {ok, [{error, "Bad username/password combination."}]}
            end;
        [] ->
            {ok, [{error, "Bad username/password combination."}]}
    end.