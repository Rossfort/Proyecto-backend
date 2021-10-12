class AddShippingMethodToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipping_method, :string
  end
end
