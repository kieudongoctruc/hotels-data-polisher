class Image < ApplicationRecord
  belongs_to :hotel
  validates :link, presence: true, uniqueness: true

  enum image_type: [:rooms, :sites, :amenities]
end
