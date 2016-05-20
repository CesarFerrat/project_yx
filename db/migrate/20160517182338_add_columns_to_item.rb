class AddColumnsToItem < ActiveRecord::Migration
  def change
    add_column :items, :name, :string
    add_column :items, :notes, :text
    add_column :items, :id_number, :string
    add_column :items, :new, :boolean, :default => false
  end
end
