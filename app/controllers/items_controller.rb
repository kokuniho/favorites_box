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
    @items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items: Item.all
    @items = @items.page(params[:page])
    @end_user=current_end_user
   
  end

  def show
    @item = Item.find(params[:id])
    @end_user = EndUser.find_by(id: @item.end_user_id)
    
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    redirect_to item_path(@item.id)
      flash[:notice] ="You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to end_user_path(current_end_user)
    # redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :body, :image, :star, tag_ids: [])
  end
end
