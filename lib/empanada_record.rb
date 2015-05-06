require 'sqlite_adapter'

module EmpanadaRecord
  class Base
    @@adapter = SqliteAdapter.new

    # Finder methdos
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

    def self.find_by(attribute, data )
      #Object.const_get("Product")
      if respond_to?(attribute.to_s)
        results = @@adapter.run("SELECT * FROM #{table_name} WHERE #{attribute} = '#{data}'")
        if results.any?
          results.map { |ary| self.new(*ary)}
        else
          raise 'EmpanadaRecordError: Record Not Found!'
        end
      else
        raise "EmpanadaRecordError: undefined method '#{attribute}'"
      end
    end

    def self.attributes
      attrs = @@adapter.run("pragma table_info(#{table_name})")
      attrs.map {|attr| attr[1]}
    end

    def self.respond_to?(attribute)
      attributes.include? attribute
    end
  end
end
