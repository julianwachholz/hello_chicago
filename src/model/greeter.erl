-module(greeter,
        [Id,
         Name,
         PasswordHash::string()
        ]).
-compile(export_all).

-has({greetings, many}).

-define(SECRET_STRING, "Not telling secrets!").


session_identifier() ->
    mochihex:to_hex(erlang:md5(?SECRET_STRING ++ Id)).


check_password(Password) ->
    user_lib:compare_password(Password, PasswordHash).


login_cookies() ->
    [mochiweb_cookies:cookie("user_id", Id, [{path, "/"}]),
     mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}])].
