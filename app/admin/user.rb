ActiveAdmin.register User, as: "Stylist" do

  menu priority: 3, label: "Stylists"

  index do
    column :id
    column :username
    column :email
    column "Stylist since", :created_at
    column "Last time online", :last_sign_in_at
    actions
  end

  filter :username
  filter :email
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Stylist Details" do
      f.input :username
      f.input :email
    end
    f.actions
  end

end
