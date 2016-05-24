class AddStatusToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :status, :string
    add_column :outfits, :notes, :text
    add_column :outfits, :price, :float
    add_column :outfits, :id_number, :string
    add_column :outfits, :outfit_picture, :json
  end
end
