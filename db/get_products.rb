require "sqlite3"

# Open a database
db = SQLite3::Database.new "db/test.db"

db.execute( "select * from products" ) do |row|
  p row
end
