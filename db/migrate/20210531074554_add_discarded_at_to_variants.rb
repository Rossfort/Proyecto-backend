class AddDiscardedAtToVariants < ActiveRecord::Migration[6.1]
  def change
    add_column :variants, :discarded_at, :datetime
    add_index :variants, :discarded_at
  end
end
