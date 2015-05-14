require 'sqlite_adapter'
require 'missing_empanada_record'
require 'missing_empanada_attribute'

module EmpanadaRecord
  class Base
    ATTRIBUTES = ['id', 'name']
    @@adapter = SqliteAdapter.new

    class << self
      ATTRIBUTES.each do |attr|
        define_method "find_by_#{attr}" do |argument|
          results = @@adapter.run("SELECT * FROM #{table_name} WHERE #{attr} = '#{argument}'")
          results.any? ? self.new(*results.first) : MissingEmpanadaRecord.new
        end
      end
    end

    def method_missing(name, *args) "Not method available for empanada record" end

    def self.find(id)
      results = @@adapter.run("SELECT * FROM #{table_name} WHERE id=#{id.to_i}")
      results.any? ? self.new(*results.first) : MissingEmpanadaRecord.new
    end

    def self.first
      result = @@adapter.run("SELECT * FROM #{table_name} LIMIT 1")
      result.any? ? self.new(*result.first) : MissingEmpanadaRecord.new
    end

    def self.all
      results = @@adapter.run("SELECT * FROM #{table_name}")
      results.any? ? results.map! {|product| self.new(*product)} : [MissingEmpanadaRecord.new]
    end

    def self.count
      result = @@adapter.run("SELECT COUNT(*) FROM #{table_name}")
      result.flatten.first
    end

    def self.where(args)
      attributes = MissingEmpanadaAttribute.new(args.keys)
      valid_attributes = attributes.validate
      raise ArgumentError.new(valid_attributes) if valid_attributes.is_a? String

      conditions = []
      args.each{ |key, value| conditions << "#{key} = '#{value}'"}

      results = @@adapter.run("SELECT * FROM #{table_name} WHERE #{conditions.join(" AND ")}")
      results.any? ? results.map! {|product| self.new(*product)} : [MissingEmpanadaRecord.new]
    end

    def self.table_name
      self.name + "s"
    end
  end
end
