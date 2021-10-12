json.category do
  json.extract! @category, :id, :name
end
json.image do
  json.encoded_image @encoded_image
  json.filename @category.image.filename.to_s
end
