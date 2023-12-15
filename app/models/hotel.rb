class Hotel < ApplicationRecord
  has_many :hotels_amenities, dependent: :destroy
  has_many :amenities, through: :hotels_amenities
  belongs_to :country
  has_many :images, dependent: :destroy

  has_many :general_amenities, -> { where("amenities.amenity_type = ?", Amenity.amenity_types[:general]) }, through: :hotels_amenities, source: :amenity
  has_many :room_amenities, -> { where("amenities.amenity_type = ?", Amenity.amenity_types[:room]) }, through: :hotels_amenities, source: :amenity
  has_many :rooms_images, -> { where("images.image_type = ?", Image.image_types[:rooms]) }, class_name: 'Image'
  has_many :site_images, -> { where("images.image_type = ?", Image.image_types[:site]) }, class_name: 'Image'
  has_many :amenities_images, -> { where("images.image_type = ?", Image.image_types[:amenities]) }, class_name: 'Image'
end
