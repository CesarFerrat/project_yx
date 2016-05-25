class AddColumnsToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :like, :boolean, :default => false
    add_column :outfits, :purchase, :boolean, :default => false
  end
end
