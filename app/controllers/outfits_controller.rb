class OutfitsController < ApplicationController

  def_param_group :auth_and_client_and_outfit do
    param :auth_token, String, desc: 'Client is logged in with auth token', required: true
    param :client_id, String, desc: 'The client who owns the outfit', required: true
    param :outfit_id, String, desc: 'The outfit being referenced', required: true
  end

  def_param_group :auth_and_client do
    param :auth_token, String, desc: 'Client is logged in with auth token', required: true
    param :client_id, String, desc: 'The client who owns the outfit', required: true
  end


  api :GET, '/clients/:client_id/outfits', 'Lists all outfits for a client'
  formats ['json']
  param_group :auth_and_client
  param :search, String, desc: 'A category of outfit to filter by', required: true
  example <<-EOT
  Response:
  {

  }
  EOT
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


  api :GET, '/clients/:client_id/outfits/:outfit_id', 'Show a specific outfit'
  formats ['json']
  param_group :auth_and_client_and_outfit
  example <<-EOT
  Response:
  {
      "id": "61acf683-c23d-4f4b-ac5d-bb5cdc51e6be",
      "client_id": "c756f7dc-632e-4ab5-904d-33f9f0a25b94",
      "name": "blue dinner jacket",
      "description": "jacket to go on a date",
      "status": "at client's home"
      "category": "business date ceremony",
      "notes": "This kind of jacket needs to be dry-cleaned once before every season",
      "id_number": "UPC-A11445599",
      "price": 99,
      "new": "false",
      "created_at": "2015-12-17T00:29:41.756Z",
      "updated_at": "2015-12-17T00:29:41.756Z",
      "picture": "https/s3.amazonaws.com/picture_35"
  }
  EOT
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


  def edit
    @outfit = Outfit.find(params[:id])
    @client = Client.find(session[:current_client_id])
    @items = @client.items.without_deleted.search(params[:search])
    @canvas = (@outfit.canvas).to_json
    @selected_category = params[:search]

  end

  api :PUT, '/clients/:client_id/outfits/:outfit_id', 'Update an outfit'
  formats ['json']
  param_group :auth_and_client_and_outfit
  param :outfit, Hash do
    param :like, :bool, desc: 'like outfit'
    param :purchase, :bool, desc: 'Purchase outfit'
  end
  def update
    @client = Client.find(session[:current_client_id])
    @outfit = Outfit.find(params[:id])
    if @outfit.update_attributes(outfit_params)
      @outfit.create_activity :update, owner: @client
      redirect_to outfits_path, notice: "Outfit details were updated."
    end
  end

  def duplicate
    @client = Client.find(session[:current_client_id])
    @outfit = Outfit.find(params[:id])
    @duplicate = @outfit.dup
    @duplicate.outfit_picture = @outfit.outfit_picture
    @duplicate.client_id = session[:current_client_id]
    if @duplicate.save
        @duplicate.create_activity :create, owner: @client
        redirect_to outfits_path, notice: "Outfit was duplicated."
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
    params.permit(:name, :description, :status, :category, :notes, :price, :new, :id_number, :outfit_picture, :canvas, :like, :purchase)
  end

end
