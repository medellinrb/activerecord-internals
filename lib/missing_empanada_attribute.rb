class MissingEmpanadaAttribute
  attr_accessor :attributes
  ATTRIBUTES = ['id', 'name']

  def initialize(attributes)
    @attributes = attributes.collect(&:to_s)
  end

  def validate
    invalid_attributes = @attributes.select{ |attr| !ATTRIBUTES.include?(attr) }
    invalid_attributes.any? ? invalid_attributes_message(invalid_attributes) : true
  end

  def invalid_attributes_message(attributes_names)
    "Next attributes doesn't exist: #{attributes_names.join(',')}"
  end
end