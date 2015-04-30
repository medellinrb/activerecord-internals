require 'sqlite_adapter'

module EmpanadaRecord
  class Base
    @@adapter = SqliteAdapter.new
    
    def self.find(id)
      results = @@adapter.run("SELECT * FROM #{table_name} WHERE id=#{id.to_i}")
      if results.any?
        self.new(*results.first)
      else
        raise 'EmpanadaRecordError: Record Not Found!'
      end
    end

    def self.table_name
      self.name + "s"
    end
  end
end
