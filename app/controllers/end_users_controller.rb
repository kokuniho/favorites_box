class EndUsersController < ApplicationController
  def index
    @end_users =EndUser.all
    
  end

  def show
    @end_user = EndUser.find(params[:id])
    @items = @end_user.items.page(params[:page])
    
  end
  
  
  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image)
  end
  
end
