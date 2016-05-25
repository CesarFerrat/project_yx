class ItemsController < ApplicationController

  def_param_group :auth_and_client_and_item do
    param :auth_token, String, desc: 'Client is logged in with auth token', required: true
    param :client_id, String, desc: 'The client who owns the item', required: true
    param :item_id, String, desc: 'The item being referenced', required: true
  end

  def_param_group :auth_and_client do
    param :auth_token, String, desc: 'Client is logged in with auth token', required: true
    param :client_id, String, desc: 'The client who owns the item', required: true
  end

  api :GET, '/clients/:client_id/items', 'Lists all items for a client'
  formats ['json']
  param_group :auth_and_client
  param :search, String, desc: 'A category of item to filter by', required: true
  example <<-EOT
  Response:
  {

  }
  EOT
  def index
    @client = Client.find(session[:current_client_id])
    @items = @client.items.without_deleted.search(params[:search])
    @selected_category = params[:search]

    render :items, :layout => false if params[:skip_layout]
  end

  def new
  end


  def create
    @client = Client.find(session[:current_client_id])
    @item = Item.new(item_params)
    @item.client_id = session[:current_client_id]
    if @item.save
        @item.create_activity :create, owner: @client
        redirect_to items_path, notice: "Item was created."
    else
      render :new
    end
  end


  api :GET, '/clients/:client_id/items/:item_id', 'Show a specific item'
  formats ['json']
  param_group :auth_and_client_and_item
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
    @item = Item.without_deleted.find(params[:id])
  end

  api :PUT, '/clients/:client_id/items/:item_id', 'Update an item'
  formats ['json']
  param_group :auth_and_client_and_item
  param :item, Hash do
    param :like, :bool, desc: 'like item'
    param :sell, :bool, desc: 'Sell item'
    param :clean, :bool, desc: 'Clean item'
    param :repair, :bool, desc: 'Repair item'
  end
  def update
    @client = Client.find(session[:current_client_id])
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      @item.create_activity :update, owner: @client #need to find a way to record exactly what kind of update is made to then have a correct activity feed
      redirect_to items_path, notice: "item's details were updated."
    end
  end

  def destroy
    @client = Client.find(session[:current_client_id])
    @item = Item.find(params[:id])
    @item.create_activity :destroy, owner: @client
    @item.deleted_at = Time.now   #here we are soft deleting items in the database to still be able to use them in the activity feed
    @item.save
    redirect_to items_path, notice: "Item was destroyed."
  end

private

  def item_params
    params.permit(:name, :notes, :id_number, :status, :new, :category, :type, :color, :season, :size, :description, :price, :picture, :sell, :clean, :repair, :like)
  end
end
