class Listing < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  has_many :category_listings, dependent: :destroy
  has_many :categories, through: :category_listings
end
