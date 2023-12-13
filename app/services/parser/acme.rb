module Parser
  class Acme < Parser::Base

    def id
      hotel[:Id]
    end

    def destination_id
      hotel[:DestinationId]
    end

    def name
      hotel[:Name]&.strip
    end

    def description
      hotel[:Description]&.strip
    end

    def lat
      hotel[:Latitude]
    end

    def lng
      hotel[:Longitude]
    end

    def address
      hotel[:Address]&.strip
    end

    def city
      hotel[:City]&.strip
    end

    def country
      @country = hotel[:Country].strip
      super
    end

    def postal_code
      hotel[:PostalCode]
    end

    def amenities
      @amenities = hotel[:Facilities]&.map { |facility| facility.strip.underscore.gsub('_', ' ') }
      super
    end
  end
end
