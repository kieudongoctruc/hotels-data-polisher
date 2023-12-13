module Parser
  class Patagonia < Parser::Base

    def id
      hotel[:id]
    end

    def destination_id
      hotel[:destination]
    end

    def name
      hotel[:name]&.strip
    end

    def description
      hotel[:info]&.strip
    end

    def lat
      hotel[:lat]
    end

    def lng
      hotel[:lng]
    end

    def address
      hotel[:address]
    end

    def amenities
      @amenities = hotel[:amenities]&.map { |amenity| amenity.strip.downcase }
      super
    end

    def images
      @images = []
      hotel[:images]&.each do |image_type, images_array|
        images_array.each do |image_data|
          image = {}
          image.image_type = image_type
          image.link = image_data[:url]
          image.description = image_data[:description]
          @iamges << image
        end
      end
    end
  end
end
