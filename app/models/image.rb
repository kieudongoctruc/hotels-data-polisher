class Image < ApplicationRecord
  belongs_to :hotel
  validates :link, presence: true, uniqueness: true

  enum image_type: [:rooms, :site, :amenities]
end
