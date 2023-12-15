class SaveService
  attr_accessor :attributes

  def initialize(attributes, supplier)
    @attributes = attributes.delete_if { |_k, v| v.blank? }
    @supplier = supplier
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
      amenity_ids = attributes[:amenity_ids] - hotel.amenity_ids
      if amenity_ids.present?
        hotel.amenities << Amenity.where(id: amenity_ids)
        attributes.delete(:amenity_ids)
      end

      hotel.update(attributes)
      ActivityLog.create(
        name: "Updated #{hotel.id} - #{hotel.name} succesfully",
        log: {
          attributes: attributes.merge(amenity_ids: amenity_ids)
        },
        from: @supplier
      )
    rescue Exception => exception
      ActivityLog.create(
        name: exception.message,
        log: {
          message: exception.full_message,
          backtrace: exception.backtrace.join("\n"),
          cause: exception.cause
        },
        from: @supplier
      )
    end
  end
end
