class EndUsersController < ApplicationController
  def index
    @end_users =EndUser.page(params[:page])

  end

  def show
    @end_user = EndUser.find(params[:id])
    @items= Item.find_by(id: @end_user.item_ids)
    @items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items : @end_user.items.all
    @items = @end_user.items.page(params[:page])
  end


  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end

end
