-module(hello_chicago_test).
-compile(export_all).


start() ->
    boss_web_test:get_request("/greeting/hello", [], [
        fun boss_assert:http_ok/1,
        fun(Res) -> boss_assert:tag_with_text("h1", "Hello, World!", Res) end
    ], []).
