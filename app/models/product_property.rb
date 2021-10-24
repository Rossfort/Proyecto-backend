class ProductProperty < ApplicationRecord
  has_many :products
  belongs_to :property
  has_many :variant_properties, dependent: nil
  has_many :variants, through: :variant_properties

  validates :value, uniqueness: true
end
