class OutfitsController < ApplicationController

  def index
    @client = Client.find(session[:current_client_id])
    @outfits = @client.outfits
  end

  def new
  end

  def create
    @item1 = Item.find(params[:id]) #every piece of clothes that is selected to make an outfit
    @item2 = Item.find(params[:id])
    @item3 = Item.find(params[:id])
    @item4 = Item.find(params[:id])
    @outfit = Outfit.new(outfit_params)
    @outfit.client_id = session[:current_client_id]
    if @outfit.save
        @outfit.create_activity :create, owner: current_user
        @item1.outfit_id = @outfit.id
        @item2.outfit_id = @outfit.id
        @item3.outfit_id = @outfit.id
        @item4.outfit_id = @outfit.id
        redirect_to @outfits, notice: "Outfit was created."
    else
      render :new
    end
  end

  def show
    @outfit = Outfit.find(params[:id])
  end


  def update
    @outfit = Outfit.find(params[:id])
    if @outfit.update_attributes(outfit_params)
      @outfit.create_activity :update, owner: current_user
      redirect_to @outfits, notice: "Outfit details were updated."
    end
  end

  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.destroy
    @outfit.create_activity :destroy, owner: current_user
    redirect_to @outfits, notice: "Outfit was destroyed."
  end

  private

  def outfit_params
    # add request purchase, and outfit picture
    params.require(:client).permit(:name, :description, :category)
  end

end
