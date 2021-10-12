class Variant < ApplicationRecord
  include Discard::Model

  belongs_to :product
  has_many :line_items
  has_one_attached :variant_image

  validates :price, presence: true
  validates :stock, presence: true
  validates :size, presence: true

  validates :price, numericality: { only_integer: true }
  validates :stock, numericality: { only_integer: true }

  delegate :title, to: :product
end
