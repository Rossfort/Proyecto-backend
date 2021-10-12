json.products @products do |product|
  json.extract!(product, :id, :title, :discarded_at)
  json.image polymorphic_url(product.images.first) if product.images.first
  json.price product.master.price if product.master
end
json.total_count @total_pages
