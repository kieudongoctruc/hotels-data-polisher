class HotelSerializer < ActiveModel::Serializer
  attributes :id, :destination_id, :name, :location, :description, :amenities, :images, :booking_conditions

  def location
    {
      lat: object.lat,
      lng: object.lng,
      postal_code: object.postal_code,
      city: object.city,
      country: object.country.name,
    }
  end

  def amenities
    amenities = {}
    Amenity.amenity_types.each do |amenity_type, _id|
      amenities[amenity_type] = object.send("#{amenity_type}_amenities").map(&:name)
    end
    amenities
  end

  def images
    images = {}
    Image.image_types.each do |image_type, _id|
      images[image_type] = object.send("#{image_type}_images").map do |image|
        {
          link: image.link,
          description: image.description
        }
      end
    end
    images
  end
end
