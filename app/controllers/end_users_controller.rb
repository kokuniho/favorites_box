class EndUsersController < ApplicationController
   before_action :authenticate_end_user!
   before_action :ensure_guest_end_user, only: [:edit]
   before_action :set_q, only: [:index, :search]

  def index
    @end_users =EndUser.page(params[:page])
  end

  def show
    @end_user = EndUser.find(params[:id])
    #タグ検索　タグがあれば、end_userのitemタグからitemを絞り込み
    @items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items : @end_user.items.all
    # #ユーザーに紐づいたitem全てのページネーション。
    @items = @items.where(end_user_id: params[:id]).page(params[:page])
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day
    #   items = @end_user.items.all.sort {|a,b|
    #   b.favorites.where(created_at: from...to).size <=>
    #   a.favorites.where(created_at: from...to).size
    # }
    # @items = Kaminari.paginate_array(items).page(params[:page])
     if  params[:sort] == "star"
       @items = @items.all.order("star DESC").page(params[:page])
     elsif params[:sort] == "create"
        @items = @items.all.order(created_at: :desc).page(params[:page])
     end
  end

  def edit
    @end_user = EndUser.find(params[:id])
     if @end_user == current_end_user
      render "edit"
     else
      redirect_to edit_end_user_path(current_end_user)
     end
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id)
      flash[:notice] ="You have updated book successfully."
    else
      render :edit
    end
  end

  def search
    @results=@q.result
  end

  def finished
    @end_user = current_end_user
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def set_q
    @q=EndUser.ransack(params[:q])
  end

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, tag_ids: [])
  end

  def correct_end_user
    @end_user = EndUser.find(params[:id])
     redirect_to(end_user_session_path(end_user_id)) unless @end_user == current_end_user
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.name == "guestuser"
      redirect_to end_user_path(current_end_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end





