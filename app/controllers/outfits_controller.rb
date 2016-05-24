class OutfitsController < ApplicationController

  def index
    @client = Client.find(session[:current_client_id])
    @outfits = @client.outfits.without_deleted.search(params[:search])
    @selected_outfit = params[:search]

  end

  def new
    @client = Client.find(session[:current_client_id])
    @items = @client.items.without_deleted.search(params[:search])
    @selected_category = params[:search]
  end

  def show
    @outfit = Outfit.without_deleted.find(params[:id])
  end

  def create
    @client = Client.find(session[:current_client_id])
    # @item1 = Item.find(params[:id]) #every piece of clothes that is selected to make an outfit
    # @item2 = Item.find(params[:id])
    # @item3 = Item.find(params[:id])
    # @item4 = Item.find(params[:id])
    # @image = Paperclip.io_adapters.for(params[:outfit_picture])
    # @image.original_filename = "outfit.png"
    # params[:outfit_picture] = @image
    @outfit = Outfit.new(outfit_params)
    @outfit.client_id = session[:current_client_id]
    if @outfit.save
        @outfit.create_activity :create, owner: @client
        # @item1.outfit_id = @outfit.id
        # @item2.outfit_id = @outfit.id
        # @item3.outfit_id = @outfit.id
        # @item4.outfit_id = @outfit.id
        redirect_to outfits_path, notice: "Outfit was created."
    else
      render :new
    end
  end

  def show
    @outfit = Outfit.find(params[:id])
  end

  def edit
    @outfit = Outfit.find(params[:id])
    @client = Client.find(session[:current_client_id])
    @items = @client.items.without_deleted.search(params[:search])
    @canvas = (@outfit.canvas).to_json
    @selected_category = params[:search]

  end


  def update
    @client = Client.find(session[:current_client_id])
    @outfit = Outfit.find(params[:id])
    if @outfit.update_attributes(outfit_params)
      @outfit.create_activity :update, owner: @client
      redirect_to outfits_path, notice: "Outfit details were updated."
    end
  end

  def destroy
    @client = Client.find(session[:current_client_id])
    @outfit = Outfit.find(params[:id])
    @outfit.create_activity :destroy, owner: @client
    @outfit.deleted_at = Time.now   #here we are soft deleting outfits in the database to still be able to use them in the activity feed
    @outfit.save
    redirect_to outfits_path, notice: "Outfit was destroyed."
  end

  private

  def outfit_params
    params.permit(:name, :description, :status, :category, :notes, :price, :new, :id_number, :outfit_picture, :canvas)
  end

end
