class CreateProductProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :product_properties do |t|
      t.string "value"
      t.bigint "property_id", null: false
      t.integer "position"

      t.timestamps
    end
  end
end
