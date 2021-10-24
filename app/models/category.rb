class Category < ApplicationRecord
  has_many :products
  has_many :properties
  has_one_attached :image
  accepts_nested_attributes_for :properties, allow_destroy: true

  def variants
    products
  end
end
