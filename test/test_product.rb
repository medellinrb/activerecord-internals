require_relative 'test_helper'
require 'product'

class ProductTest < MiniTest::Test
  def test_initialize
    product = Product.new('Empanada', 15)
    assert_equal product.name, 'Empanada'
  end

  def test_find_by_id
    product = Product.find(20)
    assert_equal product.name, 'Portatil'
  end

  def test_find_no_records
    product = Product.find(9929)
    assert_equal product.class, MissingEmpanadaRecord
    assert_equal product.name, 'EmpanadaRecordError: Record Not Found!'    
  end
end
