class Image < ApplicationRecord
  enum image_type: [:rooms, :sites, :amenities]
end
