class RemoveColumnToOutfit < ActiveRecord::Migration
  def change
    remove_column :outfits, :outfit_picture, :json
  end
end
