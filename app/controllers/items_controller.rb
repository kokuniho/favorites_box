class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item=Item.new(item_params)
    @item.end_user_id = current_end_user.id
    @end_user = current_end_user
    if @item.save
      redirect_to item_path(@item)
      flash[:notice] ="You have created item successfully."
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
    @end_user=current_end_user
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :body, :image, :star, tag_ids: [])
  end
end
