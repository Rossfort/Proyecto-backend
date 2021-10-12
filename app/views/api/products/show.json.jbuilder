json.extract! @product, :id, :title, :discarded_at
json.master_image polymorphic_url(@product.images.first)
json.images @product.images.map { |image| polymorphic_url(image) }
json.description @product.description
json.variants @product.variants do |variant|
  json.id variant.id
  json.title @product.title
  json.price variant.price
  json.stock variant.stock
  json.size variant.size
end
