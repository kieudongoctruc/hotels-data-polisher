class Hotel < ApplicationRecord
  has_many :hotels_amenities, dependent: :destroy
  has_many :amenities, through: :hotels_amenities
  belongs_to :country
  has_many :images, dependent: :destroy
end
