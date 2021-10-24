json.extract! @variant, :id, :price, :stock, :is_master, :product_id, :created_at, :updated_at, :discarded_at
json.product_properties @variant.product_properties do |pp|
  json.id pp.id
  json.value pp.value
  json.property_id pp.property_id
end
