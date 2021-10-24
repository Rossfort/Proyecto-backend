class DropJoinTableProductPropertiesProduct < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :products, :product_properties
  end
end
