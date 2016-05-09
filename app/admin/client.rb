ActiveAdmin.register Client do

  menu priority: 4

  index do
    column :id
    column :first_name
    column :last_name
    column :age
    column :city
    column :state
    column :phone_number
    column :email
    column "Client since", :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :age
  filter :city
  filter :state
  filter :phone_number
  filter :email
  filter :sign_in_count
  filter :created_at



end
