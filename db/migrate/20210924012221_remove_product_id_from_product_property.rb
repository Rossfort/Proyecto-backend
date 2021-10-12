class RemoveProductIdFromProductProperty < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_properties, :product_id, :integer
  end
end
