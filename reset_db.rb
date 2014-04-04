# USAGE:
# $ bundle exec ruby reset_db.rb
#
# You can also specify a database:
# $ bundle exec ruby reset_db.rb my-app.db
require "sqlite3"

db_name = ARGV[0] || 'rps_test.db'
sqlite = SQLite3::Database.new(db_name)

puts "Destroying #{db_name}..."
sqlite.execute %q{DROP TABLE IF EXISTS users}
sqlite.execute %q{DROP TABLE IF EXISTS matches}
sqlite.execute %q{DROP TABLE IF EXISTS games}
sqlite.execute %q{DROP TABLE IF EXISTS invites}
sqlite.execute %q{DROP TABLE IF EXISTS sessions}

puts "Creating tables..."
sqlite.execute %q{
  CREATE TABLE users (
    id          INTEGER PRIMARY KEY,
    name        TEXT     NOT NULL,
    password    TEXT     NOT NULL
  );
}
sqlite.execute %q{
  CREATE TABLE matches (
    id              INTEGER PRIMARY KEY,
    player1_id      INT     NOT NULL,
    player2_id      INT     NOT NULL,
    player1wins     INT     NOT NULL,
    player2wins     INT     NOT NULL,
    winner          TEXT,
    FOREIGN KEY(player1_id) REFERENCES users(id),
    FOREIGN KEY(player2_id) REFERENCES users(id)
  );
}
sqlite.execute %q{
  CREATE TABLE games (
    id              INTEGER PRIMARY KEY,
    match_id        INT     NOT NULL,
    player1choice   TEXT,
    player2choice   TEXT,
    winner          TEXT,
    FOREIGN KEY(match_id) REFERENCES matches(id)
  );
}
sqlite.execute %q{
  CREATE TABLE invites (
    id            INTEGER PRIMARY KEY,
    inviter_id    INT     NOT NULL,
    invitee_id    INT     NOT NULL,
    match_id      INT,
    status        TEXT    NOT NULL,
    FOREIGN KEY(inviter_id) REFERENCES users(id),
    FOREIGN KEY(invitee_id) REFERENCES users(id),
    FOREIGN KEY(match_id) REFERENCES matches(id)
  );
}
sqlite.execute %q{
  CREATE TABLE sessions (
    id          INTEGER PRIMARY KEY,
    user_id     INT     NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
  );
}

puts "Database Schema:\n\n"
puts `echo .schema | sqlite3 #{db_name}`
