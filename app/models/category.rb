class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :category_listings, dependent: :destroy
  has_many :listings, through: :category_listings

  def self.ransackable_attributes(auth_object = nil)
    %w[name description]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
