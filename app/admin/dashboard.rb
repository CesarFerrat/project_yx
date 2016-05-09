ActiveAdmin.register_page "Dashboard" do

  menu priority: 2, label: proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Clients" do
          table_for Client.order('id desc').limit(10).each do |client|
            column(:first_name)    {|client| link_to(client.first_name, admin_client_path(client)) }
            column(:age)    {|client| link_to(client.age, admin_client_path(client)) }
            column(:email)    {|client| link_to(client.email, admin_client_path(client)) }
          end
        end
      end

      column do
        panel "Recent Stylists" do
          table_for User.order('id desc').limit(10).each do |stylist|
            column(:username)    {|stylist| link_to(stylist.username, admin_stylist_path(stylist)) }
          end
        end
      end

    end # columns

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
