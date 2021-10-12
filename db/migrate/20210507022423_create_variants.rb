class CreateVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.integer :price
      t.string :size
      t.integer :stock
      t.boolean :is_master, default: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
