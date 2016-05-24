class AddDeletedAtToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :deleted_at, :datetime
    add_index :outfits, :deleted_at
  end
end
