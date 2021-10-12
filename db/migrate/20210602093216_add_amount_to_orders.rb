class AddAmountToOrders < ActiveRecord::Migration[6.1]
  def up
    add_column :orders, :amount, :integer
    change_column_null :orders, :amount, false
  end

  def down
    remove_column :orders, :amount, :integer
  end
end
