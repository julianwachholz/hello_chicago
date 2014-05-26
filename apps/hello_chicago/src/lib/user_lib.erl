-module(user_lib).
-compile(export_all).


hash_password(Password, Salt) ->
    mochihex:to_hex(erlang:md5(Salt ++ Password)).


hash_for(Name, Password) ->
    Salt = mochihex:to_hex(erlang:md5(Name)),
    hash_password(Password, Salt).


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
