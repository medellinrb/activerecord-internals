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

    def self.all
      resultset = @@adapter.run("SELECT * FROM #{table_name}")
      resultset.map { |ary| self.new(*ary)}
    end

    def self.count
      resultset = @@adapter.run("SELECT COUNT(*) FROM #{table_name}")
      resultset.flatten.first
    end

    def self.first
      resultset = @@adapter.run("SELECT * FROM #{table_name} LIMIT 1 OFFSET 0")
      if resultset.any?
        self.new(*resultset.first)
      else
        nil
      end
    end

    def self.last
      resultset = @@adapter.run("SELECT * FROM #{table_name} ORDER BY rowid DESC LIMIT 1 OFFSET 0")
      if resultset.any?
        self.new(*resultset.first)
      else
        nil
      end
    end

    def self.where(query)
      resultset = @@adapter.run("SELECT * FROM #{table_name} WHERE #{query}")
      resultset.map { |ary| self.new(*ary)}
    end

    def self.table_name
      self.name + "s"
    end
  end
end
