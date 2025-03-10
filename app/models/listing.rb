class Listing < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  has_many :category_listings, dependent: :destroy
  has_many :categories, through: :category_listings
  has_one_attached :cover_image

  ransacker :payload do
    Arel.sql("payload")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[url payload]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end

  def cover_image_for_display
    return cover_image.url if cover_image.attached?

    payload&.dig("og_image_url") || "/icon.png"
  end

  def clean_url
    url.gsub(/(https?:\/\/)|(www\.)/, "").gsub(/\/$/, "")
  end

  extend FriendlyId
  friendly_id :url, use: :slugged
end
