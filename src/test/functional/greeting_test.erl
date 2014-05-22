-module(greeting_test).
-compile(export_all).


start() ->
    %% Show a login page
    boss_web_test:get_request("/user/login", [], [
        fun boss_assert:http_ok/1,
        fun(Res) -> boss_assert:tag_with_text("label", "Name", Res) end,
        fun(Res) -> boss_assert:tag_with_text("label", "Password", Res) end
    ], []),

    %% Try logging in
    NewGreeter = boss_record:new(greeter, [{name, "admin"}, {password_hash, user_lib:hash_for("admin", "password")}]),
    {ok, Greeter} = NewGreeter:save(),
    boss_web_test:post_request("/user/login", [], "name=admin&password=password", [
        fun boss_assert:http_redirect/1,
        fun(Res) -> boss_assert:location_header("/greeting/list/", Res) end
    ], [
        "Empty list of greetings shown",
        fun(Res) ->
            boss_web_test:get_request("/greeting/list/", [
                {"Cookie", "user_id=" ++ Greeter:id() ++ ";session_id=" ++ Greeter:session_identifier()}
            ], [
                fun(Res) -> boss_assert:tag_with_text("em", "No greetings", Res) end
            ], [
                fun(Res) ->
                    boss_web_test:follow_link("New Greeting", Res, [
                        fun boss_assert:http_ok/1
                    ], [])
                end
            ])
        end
    ]).
