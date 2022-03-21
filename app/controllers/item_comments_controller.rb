class ItemCommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @item = Item.find(params[:item_id])
    @comment = current_end_user.item_comments.new(item_comment_params)
    @comment.item_id = @item.id
    @comment_item = @comment.item
    if @comment.save
     #通知の作成
     @comment_item.create_notification_comment!(current_end_user, @comment.id)
    end
  end

  def destroy
    @comment = ItemComment.find_by(id: params[:id], item_id: params[:item_id])
    @comment.destroy
    @item = Item.find(params[:item_id])
  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment)
  end
end