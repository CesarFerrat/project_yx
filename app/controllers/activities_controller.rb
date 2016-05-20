class ActivitiesController < ApplicationController
  def index
     @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.clients.pluck(:id).push(current_user.id), owner_type: ["Client", "User"])
  end

  def show
    @client = Client.find(params[:client_id])
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: [current_user, @client], owner_type: ["Client", "User"])
    session[:current_client_id] = @client.id  #saving in session memory current client id everytime it is selected in navbar
  end
end
