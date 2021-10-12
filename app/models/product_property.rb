class ProductProperty < ApplicationRecord
  has_many :products
  has_and_belongs_to_many :products
  belongs_to :property
end
