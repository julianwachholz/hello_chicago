-module(user_lib).
-compile(export_all).


hash_password(Password) ->
    {ok, Salt} = bcrypt:gen_salt(),
    bcrypt:hashpw(Password, Salt).


compare_password(Attempt, Password) ->
    {ok, Password} =:= bcrypt:hashpw(Attempt, Password).


require_login(Req) ->
    case Req:cookie("user_id") of
        undefined -> {ok, []};
        Id ->
            case boss_db:find(Id) of
                undefined -> {ok, []};
                Greeter ->
                    case Greeter:session_identifier() =:= Req:cookie("session_id") of
                        false -> {ok, []};
                        true -> {ok, Greeter}
                    end
                end
    end.
