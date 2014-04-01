require "sqlite3"

#Opens a database
db = SQLite3::Database.new "rps.db"

# Creates a database
rows = db.execute <<-SQL
create table users (
    id val int,
    name varchar(30),
    password varchar(30)
  );
SQL

