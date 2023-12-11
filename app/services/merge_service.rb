class MergeService
  # order of field names define by how good data is
  REFERENCE_FIELD_NAMES = {
    id: ['id', 'hotel_id', 'Id'],
    destination_id: ['destination_id', 'DestinationId', 'destination'],
    name: ['name', 'hotel_name', 'Name'],
    lat: ['Latitude', 'lat'],
    long: ['Longitude', 'lng'],
    address: ['address', 'Address'],
    city: ['City'],
    postal_code: ['PostalCode'],
    description: ['Description'],
    info: ['info'],
    details: ['details'],
    booking_conidtions: ['booking_conditions']
}.freeze

  HOTEL_FORMAT = {
    destination_id: nil,
    name: nil,
    lat: nil,
    long: nil,
    address: nil,
    city: nil,
    postal_code: nil,
    description: nil,
    info: nil,
    details: nil,
    booking_conidtions: nil,
}.freeze

  def initialize(hotels)
    @hotels = hotels
  end

  def call
    grouped_by_id_hotels = @hotels.group_by do |hotel|
      get_value(hotel, :id)
    end
    merge(grouped_by_id_hotels)
  end

  def merge(grouped_by_id_hotels)
    hotels = []
    grouped_by_id_hotels.each do |hotel_id, uncleaned_hotel_array|
      next if hotel_id.blank?

      hotel = Hotel.find_or_create_by_id(hotel_id)
      merged_all_attributes = {}
      uncleaned_hotel_array.each do |obj|
        hotel.country = parse_country(object.dig(:location, :country)) if object.dig(:location, :country).present?
        hotel.images << parse_images(obj[:images]) if obj[:images].present?
        hotel.amenities << parse_amenities(obj.dig(:amenities, :room) || obj[:amenities])
        hotel.facilities << parse_facilities(obj.dig(:amenities, :general) || obj[:Facilities])

        merged_all_attributes.merge!(obj)
      end
      hotel_attributes = HOTEL_FORMAT.clone
      hotel_attributes.each do |key, value|
        value = get_value(merged_all_attributes, key)
      end
      hotel.assign_attributes(hotel_attributes)
      hotel.save
    end
    hotels
  end

  def get_value(data, key)
    defined_key = nil
    REFERENCE_FIELD_NAMES[key].each do |reference_key|
      if data.has_key?(reference_key) && data[reference_key]
        defined_key = reference_key
        break
      end
    end
    data[defined_key]
  end

  def parse_country(country_name)
    Country.find_by(name: country_name.strip)
  end

  def parse_images(images_data)
    images = []
    images_data.each do |image_type, images_array|
      images_array.each do |image_data|
        image = Image.new
        image.image_type = image_type
        image.link = image_data[:link].strip! || image_data[:url]
        image.description = image_data[:description].strip! || image_data[:caption]
        images << image
      end
    end
    images
  end

  def parse_facilities(facilities_data)
    facilities_data.map { |facility| facility.strip!.downcase! }
    Facility.where(name: facilities_data)
  end

  def parse_amenities(amenities_data)
    amenities_data.map { |amenity| amenity.strip!.downcase! }
    Amenity.where(name: amenities_data)
  end
end
