class MessagesController < ApplicationController
  before_action :authenticate_end_user!, only: [:create, :destroy]

  def create
    if Entry.where(end_user_id: current_end_user.id, room_id: params[:message][:room_id]).present?
       @message = Message.create(params.require(:message).permit(:end_user_id, :message, :room_id).merge(end_user_id: current_end_user.id))
       redirect_to "/rooms/#{@message.room_id}"
    else
       redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @messages = Message.find(params[:id])
    @messages.destroy
    redirect_to request.referer
  end





  private

  def message_params
    params.require(:message).permit(:room_id, :message, :end_user_id)
  end

end
