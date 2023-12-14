class SaveService
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes.delete_if { |_k, v| v.blank? }
  end

  def call
    hotel = Hotel.find_or_create_by(id: attributes[:id])
    begin
      # update images
      if attributes[:images].present?
        attributes[:images].each do |image|
          Image.create(image.merge(hotel_id: hotel.id))
        end
        attributes.delete(:images)
      end

      # update amenities
      if attributes[:amenities].present?
        hotel.amenity_ids = hotel.amenity_ids + attributes[:amenities].ids
      end

      hotel.update(attributes)
    rescue => exception
      puts exception
      # TODO: add logs
    end
  end
end
