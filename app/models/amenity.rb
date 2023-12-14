class Amenity < ApplicationRecord
  has_many :hotels_amenities, dependent: :destroy
  has_many :hotels, through: :hotels_amenities

  enum amenity_type: [:general, :room]

  validates :name, uniqueness: { scope: :amenity_type, case_sensitive: false }
end
