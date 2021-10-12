class AddUuidToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_index :orders, :uuid
  end
end
