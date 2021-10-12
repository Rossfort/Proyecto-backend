json.orders @orders do |order|
  json.extract! order, :id, :status, :amount
  json.created_at order.created_at.strftime('%d/%m/%Y')
  json.email order.user.email
end
json.statuses @statuses
json.total_pages @pages
