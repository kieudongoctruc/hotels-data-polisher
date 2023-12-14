module Parser
  class Paperflies < Parser::Base

    def id
      hotel[:hotel_id]
    end

    def destination_id
      hotel[:destination_id]
    end

    def name
      hotel[:hotel_name]&.strip
    end

    def description
      hotel[:details]&.strip
    end

    def address
      hotel.dig(:location, :address)&.strip
    end

    def country
      @country = hotel.dig(:location, :country)&.strip
      super
    end

    def booking_conditions
      hotel[:booking_conditions].map {|c| c.strip }
    end

    def amenities
      @amenities = []
      hotel.dig(:amenities, :general)&.each { |amenity| @amenities << amenity.strip }
      hotel.dig(:amenities, :room)&.each { |amenity| @amenities << amenity.strip }
      super
    end

    def images
      @images = []
      hotel[:images]&.each do |image_type, images_array|
        images_array.each do |image_data|
          image = {}
          image[:image_type] = image_type
          image[:link] = image_data[:link]
          image[:description] = image_data[:caption]
          @images << image
        end
      end
      super
    end
  end
end
