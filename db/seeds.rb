# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#

COUNTRIES = [
  { name: 'Singapore', iso_alpha2_code: 'SG' },
  { name: 'Japan', iso_alpha2_code: 'JP' },
  { name: 'Malaysia', iso_alpha2_code: 'MY' },
  { name: 'Vietnam', iso_alpha2_code: 'VN' },
]
COUNTRIES.each do |country|
  Country.find_or_create_by(country)
end

AMENITIES = {
  general: ["outdoor pool", "indoor pool", "business center", "childcare", "wifi", "dry cleaning", "breakfast", "bar", "parking", "concierge"],
  room: ["aircon", "tv", "coffee machine", "kettle", "hair dryer", "iron", "bathtub", "minibar"]
}
AMENITIES.each do |amenity_type, amenities|
  amenities.each do |name|
    Amenity.find_or_create_by(amenity_type: amenity_type, name: name)
  end
end
