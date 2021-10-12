class Property < ApplicationRecord
  has_many :product_properties, dependent: :destroy
  belongs_to :category
end
