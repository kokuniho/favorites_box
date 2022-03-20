class ItemsController < ApplicationController
  before_action :redirect_root, except: :index
  # before_action :show_redirect

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
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
    # 過去一週間分のいいね数多い順に並べ替え
    @end_user = current_end_user
    items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items : Item.all
    @tag_id = params[:tag_id].present? ? params[:tag_id] : nil
    if params[:sort] == "star"
       items = items.all.order("star DESC")
    elsif params[:sort] == "create"
          items = items.all.order(created_at: :desc)
    else
     items = items.all.order(created_at: :desc)
      to = Time.current.at_end_of_day
      from = (to - 6.day).at_beginning_of_day
        items = items.all.sort {|a,b|
        b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
        }
    end
    @items = Kaminari.paginate_array(items).page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @end_user = EndUser.find_by(id: @item.end_user_id)
    @item_comment = ItemComment.new

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
        redirect_to item_path(@item.id)
        flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
      redirect_to end_user_path(current_end_user)
  end

  private

  def item_params
      params.require(:item).permit(:name, :body, :image, :star, :comment, :tag_id, tag_ids: [])
  end

  def redirect_root
      redirect_to root_path unless end_user_signed_in?
  end
end
