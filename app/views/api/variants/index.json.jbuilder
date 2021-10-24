json.variants @variants do |variant|
  json.extract!(variant, :id, :price, :size, :stock)
  json.title variant.product.title
  json.image polymorphic_url(variant.product.images.first)
end
