json.category do
  json.extract! @category, :id, :name
  json.properties @category.properties do |property|
    json.extract! property, :name, :id
  end
end
json.image do
  json.encoded_image @encoded_image
  json.filename @category.image.filename.to_s
end
