-module(hello_chicago_user_controller, [Req, SessionID]).
-compile(export_all).


login('GET', []) ->
    {ok, [{redirect, Req:header(referer)}]};

login('POST', []) ->
    Name = Req:post_param("name"),
    case boss_db:find(greeter, [{name, Name}], [{limit, 1}]) of
        [Greeter] ->
            case Greeter:check_password(Req:post_param("password")) of
                true ->
                    % ok = boss_session:delete_session(SessionID),
                    % NewSessionID = boss_session:new_session("humpty_dumpty"),
                    % io:format("new session: ~p~n", [NewSessionID]),
                    ok = boss_session:set_session_data(SessionID, "user_id", Greeter:id()),
                    {redirect, proplists:get_value("redirect", Req:post_params(), "/")};
                false -> login_failed()
            end;
        [] ->
            login_failed()
    end.

login_failed() ->
    {ok, [
        {redirect, Req:post_param("redirect")},
        {error, "Bad username/password combination."}
    ]}.
