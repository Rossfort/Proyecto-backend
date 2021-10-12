class AddCategoryIdToProperty < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :category, null: true, foreign_key: true
  end
end
