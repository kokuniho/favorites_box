class MessagesController < ApplicationController
  before_action :authenticate_end_user!, only: [:create, :destroy]

  def create
    if Entry.where(end_user_id: current_end_user.id, room_id: params[:message][:room_id]).present?
       @message = Message.create(params.require(:message).permit(:end_user_id, :message, :room_id).merge(end_user_id: current_end_user.id))
       @room = @message.room
          if @message.save
             @receiver = Entry.where(room_id: @room.id).where.not(end_user_id: current_end_user.id)
             @theid = @receiver.find_by(room_id: @room.id)
              notification = current_end_user.active_notifications.new(
                visited_id: @theid.end_user_id,
                visitor_id: current_end_user.id,
                room_id: @room.id,
                message_id: @message.id,
                action: 'dm'
              )
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
                notification.save if notification.valid?
                  redirect_to(room_path(@message.room_id))
          else
            redirect_to(room_path(@message.room_id))
          end
    end
  end

  def destroy
    @messages = Message.find(params[:id])
    @messages.destroy
    redirect_to request.referer
  end

  private

  def message_params
      params.require(:message).permit(:room_id, :message, :end_user_id).merge(end_user_id: current_end_user.id)
  end
end