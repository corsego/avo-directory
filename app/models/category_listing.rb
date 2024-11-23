class CategoryListing < ApplicationRecord
  belongs_to :category
  belongs_to :listing

  validates :category_id, uniqueness: { scope: :listing_id }
  validates :listing_id, uniqueness: { scope: :category_id }
end
