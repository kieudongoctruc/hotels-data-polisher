module Parser
  class Base
    attr_accessor :hotel

    def initialize(hotel)
      @hotel = hotel.with_indifferent_access
    end

    def attributes
      {
        id: id,
        destination_id: destination_id,
        name: name,
        lat: lat,
        lng: lng,
        address: address,
        city: city,
        country_id: country&.id,
        postal_code: postal_code,
        description: description,
        amenity_ids: amenities,
        booking_conditions: booking_conditions,
        images: images
      }
    end

    def id
      raise NotImplementedError
    end

    def destination_id
      raise NotImplementedError
    end

    def lat
      nil
    end

    def lng
      nil
    end

    def city
      nil
    end

    def country
      return nil if @country.blank?

      Country.find_by(name: @country) || Country.find_by(iso_alpha2_code: @country)
    end

    def postal_code
      nil
    end

    def booking_conditions
      nil
    end

    def amenities
      return [] if @amenities.blank?

      Amenity.where(name: @amenities).ids
    end

    def images
      return nil if @images.blank?

      @images
    end
  end
end
