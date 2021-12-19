json.products @products do |product|
  json.extract!(product, :id, :title)
  json.master_image product.images.first.present? ?  polymorphic_url(product.images.first) : asset_url('default_image.png')
  json.price product.master.price if product.master
end
json.total_count @total_pages
