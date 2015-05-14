class MissingEmpanadaRecord
  ATTRIBUTES = [:id, :name]

  ATTRIBUTES.each do |attr|
    define_method "#{attr}" do get_message end
  end

  def method_missing(name, *args) get_message end

  private
  def get_message
    "EmpanadaRecordError: Record Not Found!"
  end
end