json.extract! @order, :address, :amount, :id, :city, :created_at, :name, :last_name, :pay_method, :shipping_method,
              :phone, :token, :status, :comuna, :uuid
json.email @order.email
json.line_items @order.line_items do |line_item|
  json.extract! line_item.variant, :id, :price, :size
  json.title line_item.variant.title
  json.quantity line_item.quantity
  json.product_id line_item.variant.product.id
end

json.statuses Order.statuses
