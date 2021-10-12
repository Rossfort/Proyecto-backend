class CreateProductProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :product_properties do |t|
      t.string :value
      t.references :product, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
