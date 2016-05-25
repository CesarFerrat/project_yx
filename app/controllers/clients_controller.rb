class ClientsController < SecuredClientController

  # test to check if http request works and return the correct current_client info
  # def show
  #   render json: current_client
  # end

  def all_items
    @items = current_client.items
    render json: @items
  end

  def item
    @item = current_client.items.find(params[:id])
    @item.create_activity :show, owner: current_client
    render json: @item
  end

  def update_item
    @item = current_client.items.find(params[:id])
    respond_to do |format|
      if @item.update_attributes(params[:status])
        @item.create_activity :update, owner: current_client
        format.json { render json: @item, status: :updated }
      end
    end
  end


  def all_outfits
    @outfits = current_client.outfits
    render json: @outfits
  end

  def outfit
    @outfit = current_client.outfits.find(params[:id])
    @outfit.create_activity :show, owner: current_client
    render json: @outfit
  end

  def update_outfit
    @outfit = current_client.outfits.find(params[:id])
    respond_to do |format|
      if @outfit.update_attributes(params[:status])
        @outfit.create_activity :update, owner: current_client
        format.json { render json: @outfit, status: :updated }
      end
    end
  end



  private

  def client_params
     params.require(:client).permit(:first_name, :last_name, :age, :address, :city, :state, :zip_code, :phone_number, :email, :status)
  end

end
