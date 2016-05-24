class AddAttachmentOutfitPictureToOutfits < ActiveRecord::Migration
  def self.up
    change_table :outfits do |t|
      t.attachment :outfit_picture
    end
  end

  def self.down
    remove_attachment :outfits, :outfit_picture
  end
end
