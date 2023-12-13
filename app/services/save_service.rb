class SaveService
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def call
    hotel = Hotel.find_or_create_by(
      id: attributes[:id],
      destination_id: attributes[:destination_id]
    )
    hotel.assign_attributes(attributes)
    hotel.save
  end
end
