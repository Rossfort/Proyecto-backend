json.categories @categories do |category|
  json.id category.id
  json.label category.name.capitalize
  json.value category.name.parameterize(separator: '_')
end
