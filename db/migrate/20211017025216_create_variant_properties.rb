class CreateVariantProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :variant_properties do |t|
      t.references :variant, null: false, foreign_key: true
      t.references :product_property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
