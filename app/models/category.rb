class Category < ApplicationRecord
  has_many :products
  has_many :properties
  has_one_attached :image
end
