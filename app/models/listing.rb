class Listing < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  has_many :category_listings, dependent: :destroy
  has_many :categories, through: :category_listings
  has_one_attached :cover_image

  def self.ransackable_attributes(auth_object = nil)
    %w[url]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end

  def cover_image_for_display
    return cover_image if cover_image.attached?

    payload&.dig("og_image_url") || "/icon.png"
  end
end
