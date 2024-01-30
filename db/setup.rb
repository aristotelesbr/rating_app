# frozen_string_literal: true

require 'sqlite3'

db = SQLite3::Database.new ENV['RACK_ENV'] == 'test' ? 'db/teachers_test.db' : 'db/teachers.db'
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS teachers (
    id INTEGER PRIMARY KEY,
    name TEXT
  );
SQL

db.execute "INSERT INTO teachers (name) VALUES ('Sócrates'), ('Aristóteles'), ('Epicteto'), ('João');"

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS ratings (
    id INTEGER PRIMARY KEY,
    rating INTEGER,
    teacher_id INTEGER,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
  );
SQL

db.close
