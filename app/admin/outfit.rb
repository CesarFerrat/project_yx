ActiveAdmin.register Outfit do

  menu parent: "Clients"

  index as: :grid, columns: 5 do |outfit|
  link_to image_tag(outfit.image_path), admin_outfit_path(outfit)
  end

end
