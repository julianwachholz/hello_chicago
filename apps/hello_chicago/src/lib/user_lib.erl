-module(user_lib).
-compile(export_all).


hash_password(Password) ->
    {ok, Salt} = bcrypt:gen_salt(),
    bcrypt:hashpw(Password, Salt).


compare_password(Attempt, Password) ->
    {ok, Password} =:= bcrypt:hashpw(Attempt, Password).


require_login(SessionID) ->
    UserId = boss_session:get_session_data(SessionID, "user_id"),
    case boss_db:find(UserId) of
        undefined -> {ok, []};
        {error, _} -> {ok, []};
        Greeter -> {ok, Greeter}
    end.
