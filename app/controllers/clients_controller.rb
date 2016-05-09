class ClientsController < ApplicationController

  def create
    @user = current_user
    respond_to do |format|
      @client = @user.clients.new(client_params)
      if @client.save
        format.json { render json: @client, status: :created }
      else
        respond_to_validation_error(format: format, model: @client)
      end
    end
  end



  private

  def client_params
     params.require(:client).permit(:first_name, :last_name, :age, :address, :city, :state, :zip_code, :phone_number, :email)
  end

end
