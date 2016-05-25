class AddColumnToItem < ActiveRecord::Migration
  def change
    add_column :items, :like, :boolean, :default => false
    add_column :items, :sell, :boolean, :default => false
    add_column :items, :clean, :boolean, :default => false
    add_column :items, :repair, :boolean, :default => false
  end
end
