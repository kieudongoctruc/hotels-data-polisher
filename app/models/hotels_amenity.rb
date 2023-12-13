class HotelsAmenity < ApplicationRecord
  belongs_to :hotel
  belongs_to :amenity

  validates :hotel_id, uniqueness: { scope: :amenity_id }
end
