require 'sqlite3'

class SqliteAdapter
  def initialize
    @db = SQLite3::Database.new 'db/test.db'
  end

  def run(query)
    @db.execute(query)
  end
end
