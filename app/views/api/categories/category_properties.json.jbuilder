json.properties @category.properties do |property|
  json.id property.id
  json.property_name property.name
  json.property_values property.product_properties do |product_property|
    next if product_property.variants.count.zero?

    json.label product_property.value
    json.value product_property.value
    json.product_property_id product_property.id
    json.property_id property.id
  end
end
