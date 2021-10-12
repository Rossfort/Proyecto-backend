class AddJoinTableToProductProductProperty < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :product_properties
  end
end
