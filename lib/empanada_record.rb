require 'sqlite_adapter'
require 'missing_empanada_record'

module EmpanadaRecord
  class Base
    @@adapter = SqliteAdapter.new
    
    def self.find(id)
      results = @@adapter.run("SELECT * FROM #{table_name} WHERE id=#{id.to_i}")
      results.any? ? self.new(*results.first) : MissingEmpanadaRecord.new
    end

    def self.table_name
      self.name + "s"
    end
  end
end
