json.products @products.includes([:master]) do |product|
  json.extract!(product, :id, :title)
  json.master_image polymorphic_url(product.images.first)
  json.price product.master.price if product.master
end
json.total_count @total_pages
