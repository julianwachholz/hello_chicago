%% Migration: greetings

UpSQL = "
CREATE TABLE greetings(
    id SERIAL UNIQUE,
    greeter_id INTEGER NOT NULL REFERENCES greeters(id),
    greeting_text TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);
".

DownSQL = "DROP TABLE greetings;".

{greetings,
  fun(up) -> boss_db:execute(UpSQL);
     (down) -> boss_db:execute(DownSQL)
  end}.
