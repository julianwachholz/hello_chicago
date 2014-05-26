%% Migration: greeters

UpSQL = "
CREATE TABLE greeters(
    id SERIAL UNIQUE,
    name TEXT NOT NULL,
    password_hash TEXT NOT NULL
);
".

DownSQL = "DROP TABLE greeters;".

{greeters,
  fun(up) -> boss_db:execute(UpSQL);
     (down) -> boss_db:execute(DownSQL)
  end}.
