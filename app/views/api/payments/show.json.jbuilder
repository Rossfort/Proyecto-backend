json.payment do
  json.merge! @order.payment.attributes if @order.payment.present?
  json.payment_type 'transfer' if @order.payment.blank?
end
json.order do
  json.merge! @order.attributes
  json.items @order.line_items do |line_item|
    json.variant_id line_item.variant.id
    json.title line_item.variant.product.title
    json.image polymorphic_url(line_item.variant.product.images.first)
    json.price line_item.variant.price
    json.quantity line_item.quantity
  end
end
