class Listing < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  has_many :category_listings, dependent: :destroy
  has_many :categories, through: :category_listings

  def self.ransackable_attributes(auth_object = nil)
    %w[url]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
