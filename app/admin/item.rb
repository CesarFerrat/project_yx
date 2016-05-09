ActiveAdmin.register Item do

  menu parent: "Clients"

  index :as => :grid, columns: 3 do |item|
    div do
      a :href => admin_item_path(item) do
        image_tag("items/" + item.image_file_name)
      end
    end
    a truncate(item.description), :href => admin_item_path(item)
  end


end
