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
    assert_instance_of MissingEmpanadaRecord, product
    assert_equal product.name, 'EmpanadaRecordError: Record Not Found!'    
  end

  def test_find_first_record
    product = Product.first

    refute_nil product
    assert_equal product.id, 20
  end

  def test_find_all_records
    products = Product.all

    refute_nil products
    assert_equal products.class, Array
    assert_equal products.size, 2
  end

  def test_count_records
    number_of_products = Product.count

    assert_equal Fixnum, number_of_products.class
    assert_equal number_of_products, 2
  end

  def test_find_by_id
    product = Product.find_by_id("20")

    assert_equal product.id, 20
    assert_equal product.name, 'Portatil'
    assert_instance_of Product, product
  end

  def test_find_by_name
    product = Product.find_by_name("Portatil")

    assert_equal product.id, 20
    assert_equal product.name, 'Portatil'
    assert_instance_of Product, product
  end

  def test_find_by_id_no_record_found
    product = Product.find_by_id("20123")

    assert_instance_of MissingEmpanadaRecord, product
    assert_equal product.id, 'EmpanadaRecordError: Record Not Found!'
    assert_equal product.name, 'EmpanadaRecordError: Record Not Found!'
  end

  def test_find_by_name_no_record_found
    product = Product.find_by_name("Empanada")

    assert_instance_of MissingEmpanadaRecord, product
    assert_equal product.id, 'EmpanadaRecordError: Record Not Found!'
    assert_equal product.name, 'EmpanadaRecordError: Record Not Found!'
  end

  def test_where_method
    products = Product.where(:id => 20, :name => "Portatil")

    assert_equal products.size, 1
    assert_equal products.first.id, 20
    assert_equal products.first.name, 'Portatil'
    assert_instance_of Product, products.first
  end

  def test_where_method_invalid_attributes
    assert_raises(ArgumentError) {
      products = Product.where(:random_attribute => 20, :nmas => "Portatil")
    }
  end

  def test_where_method_no_records_found
    products = Product.where(:id => 220, :name => "Empanada")

    assert_equal products.first.id, 'EmpanadaRecordError: Record Not Found!'
    assert_equal products.first.name, 'EmpanadaRecordError: Record Not Found!'
    assert_instance_of MissingEmpanadaRecord, products.first
  end  
end
