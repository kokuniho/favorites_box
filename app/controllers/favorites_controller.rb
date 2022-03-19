class FavoritesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    favorite = current_end_user.favorites.new(item_id: @item.id)
    favorite.save
    #通知の作成
    @item.create_notification_by(current_end_user)
        respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_end_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
  end
end
