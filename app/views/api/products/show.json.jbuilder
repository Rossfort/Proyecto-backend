json.extract! @product, :id, :title, :discarded_at
json.master_image @product.images.first.present? ? polymorphic_url(@product.images.first) : asset_url('default_image.png')
json.images(@product.images.map { |image| image.present? ? polymorphic_url(image) : asset_url('default_image.png') }) if @product.images.present?
json.images [asset_url('default_image.png')] if @product.images.blank?
json.master_price @product.master.price
json.description @product.description
json.variants @product.variants do |variant|
  json.id variant.id
  json.title @product.title
  json.price variant.price
  json.stock variant.stock
  json.size variant.size
  json.properties variant.product_properties do |prop|
    json.name prop.property.name
    json.value prop.value
  end
end
