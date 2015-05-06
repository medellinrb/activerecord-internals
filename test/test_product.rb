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
    err = assert_raises RuntimeError do
      Product.find(999)
    end
    assert_equal err.message, 'EmpanadaRecordError: Record Not Found!'
  end

  def test_all
    ids = Product.all.map { |p| p.id }
    assert_equal ids.sort, [10, 20]
  end
end
