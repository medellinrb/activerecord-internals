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

  def test_count
    count = Product.count
    assert_equal count, 2
  end

  def test_first
    assert_equal Product.first.id, 20
  end

  def test_last
    assert_equal Product.last.id, 10
  end

  def test_where
    product = Product.where("id = 20")
    assert_equal product.first.id, 20
  end

  def test_find_by
    products = Product.find_by("name", "Portatil")
    assert_operator products.count, :>=, 1
  end

  def test_attributes
    assert_equal Product.attributes.sort, ["id", "name"]
  end

  def test_respond_to?
    assert_equal Product.respond_to?("name"), true
  end
end
