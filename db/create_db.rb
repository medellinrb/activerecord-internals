require "sqlite3"

# Open a database
db = SQLite3::Database.new "db/test.db"

# Create a database
rows = db.execute <<-SQL
  create table products (
    name varchar(30),
    id int
  );
SQL

# Execute a few inserts
{
  "Portatil" => 20,
  "Palito de Queso" => 10,
}.each do |pair|
  db.execute("insert into products values ( ?, ? )", pair)
end
