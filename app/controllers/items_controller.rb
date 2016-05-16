class ItemsController < ApplicationController

  def index
    @client = Client.find(session[:current_client_id])
    @items = @client.items
  end

  def new
  end

  def create
    @item = Item.new(item_params)
    @item.client_id = session[:current_client_id]
    if @item.save
        @item.create_activity :create, owner: current_user
        redirect_to @items, notice: "Item was created."
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      @item.create_activity :update, owner: current_user
      redirect_to @items, notice: "item details were updated."
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    @item.create_activity :destroy, owner: current_user
    redirect_to @items, notice: "Item was destroyed."
  end

private

  def item_params

    params.require(:client).permit(:category, :type, :color, :season, :size, :description, :price, :picture, :status)
  end
end
