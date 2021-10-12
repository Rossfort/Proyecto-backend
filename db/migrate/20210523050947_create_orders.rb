class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :comuna
      t.string :phone
      t.string :postal_code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
