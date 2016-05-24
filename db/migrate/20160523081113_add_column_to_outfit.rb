class AddColumnToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :canvas, :json
  end
end
