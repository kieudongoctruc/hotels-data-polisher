class Country < ApplicationRecord
  has_many :hotels

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :iso_alpha2_code, presence: true, uniqueness: { case_sensitive: false }
end
