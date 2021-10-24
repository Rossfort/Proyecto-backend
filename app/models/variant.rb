class Variant < ApplicationRecord
  include Discard::Model

  belongs_to :product
  has_many :line_items
  has_one_attached :variant_image
  has_many :variant_properties, dependent: nil
  has_many :product_properties, through: :variant_properties
  accepts_nested_attributes_for :product_properties, reject_if: :chech_if_exist

  validates :price, presence: true
  validates :stock, presence: true
  validates :size, presence: true

  validates :price, numericality: { only_integer: true }
  validates :stock, numericality: { only_integer: true }

  delegate :title, to: :product

  def chech_if_exist(property)
    # reviso si existe
    new_property = ProductProperty.find_by(value: property[:value])
    return true if new_property.present? && product_properties.exists?(new_property.id)

    # reviso si ya esta ocupado el property
    has_same_property = product_properties.where(property_id: new_property.property_id) if new_property.present?
    if property.present? && new_property.blank?
      has_same_property = product_properties.where(property_id: property[:property_id])
    end
    exist = product_properties.find_by(id: new_property.id) if new_property.present?
    product_properties.delete(has_same_property.first.id) if has_same_property.present?
    product_properties << new_property if new_property.present? && !exist
    return true if new_property.present?

    false
  end
end
