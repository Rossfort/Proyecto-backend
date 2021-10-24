class VariantProperty < ApplicationRecord
  belongs_to :variant
  belongs_to :product_property
end
