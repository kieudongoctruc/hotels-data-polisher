class Hotel < ApplicationRecord
  has_many :hotels_amenities
  has_many :amenities, through: :hotels_amenities
  belongs_to :country
  has_many :images
end
