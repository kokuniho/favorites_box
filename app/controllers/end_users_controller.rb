class EndUsersController < ApplicationController
   before_action :authenticate_end_user!
   before_action :ensure_guest_end_user, only: [:edit]

  def index
    @end_users =EndUser.page(params[:page])

  end

  def show
    @end_user = EndUser.find(params[:id])
    #タグ検索　タグがあれば、end_userのitemタグからitemを絞り込み
    @items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items : @end_user.items.all
    # #ユーザーに紐づいたitem全てのページネーション。
    @items = @items.where(end_user_id: params[:id]).page(params[:page])
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


  private

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





