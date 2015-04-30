require 'empanada_record'

class Product < EmpanadaRecord::Base
  attr_accessor :id, :name

  def initialize(name, id)
    @name = name
    @id = id
  end
end
